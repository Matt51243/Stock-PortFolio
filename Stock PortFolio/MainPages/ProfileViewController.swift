//
//  ProfileViewController.swift
//  Stock PortFolio
//
//  Created by Matthew on 4/26/22.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var calculatedProfitArray = [Double]()
    var calculatedLossArray = [Double]()
    
    var todaysDate = Date()
    let calendar = Calendar.current
    
    @IBOutlet var netWorthLabel: UILabel!
    @IBOutlet var totalProfitLabel: UILabel!
    @IBOutlet var totalLossesLabel: UILabel!
    
    @IBOutlet var barGraphImage: UIImageView!
    
    @IBOutlet var biggestProfitLabel: UILabel!
    @IBOutlet var biggestLossLabel: UILabel!
    @IBOutlet var totalTradesMadeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setTotalTrades()
        calculateTotalProfit()
        calculateTotalLosses()
        biggestProfit()
        biggestLoss()
        calculateNetWorth()
    }
    
    //sets the totalTradesMadeLabel to the amount of trades that they have
    func setTotalTrades() {
        if stockArray.count == 0 {
            totalTradesMadeLabel.text = "NA"
        } else if stockArray.count >= 1 {
            totalTradesMadeLabel.text = String(stockArray.count)
        }
    }
    
    //Adds all of the stocks that they added that are profit and changes totalProfitLabel to that
    func calculateTotalProfit() {
        stockArray.forEach { stock in
            if (stock.soldPrice * Double(stock.shares)) - (stock.boughtPrice * Double(stock.shares)) >= 0.001 {
                let totalSoldPrice = stock.soldPrice * Double(stock.shares)
                let totalBoughtPrice = stock.boughtPrice * Double(stock.shares)
                let calculatedProfit = totalSoldPrice - totalBoughtPrice

                calculatedProfitArray.append(calculatedProfit)
                let totalAddedProfit = calculatedProfitArray.reduce(0, +)
                totalProfitLabel.text = String("$\(totalAddedProfit)")
            }
        }
    }
    
    //Adds all of the stocks that they added that are losses and changes totalLossesLabel to that
    func calculateTotalLosses() {
        stockArray.forEach { stock in
            if (stock.soldPrice * Double(stock.shares)) - (stock.boughtPrice * Double(stock.shares)) < 0.001 {
                let totalSoldPrice = stock.soldPrice * Double(stock.shares)
                let totalBoughtPrice = stock.boughtPrice * Double(stock.shares)
                let calculatedLoss = totalSoldPrice - totalBoughtPrice
                
                calculatedLossArray.append(calculatedLoss)
                let totalAddedLosses = calculatedLossArray.reduce(0, +)
                let absoulteValueLosses = abs(totalAddedLosses)
                totalLossesLabel.text = String("- $\(absoulteValueLosses)")
            }
        }
    }
    
    //finds the biggest profit and makes biggestProfitLabel that number
    func biggestProfit() {
        let largestProfit = calculatedProfitArray.max()
        if calculatedProfitArray.count == 0 {
            biggestProfitLabel.text = "NA"
        } else if calculatedProfitArray.count >= 1 {
            biggestProfitLabel.text = String("$\(largestProfit!)")
        }
    }
    
    //finds the biggest loss and makes biggestLossLabel that number
    func biggestLoss() {
        let largestLoss = calculatedLossArray.max()
        if calculatedLossArray.count == 0 {
            biggestLossLabel.text = "NA"
        } else if calculatedLossArray.count >= 1 {
            let absoluteValueLosses = abs(largestLoss!)
            biggestLossLabel.text = String("- $\(absoluteValueLosses)")
        }
    }
    
    //calculates the net worth of the person account
    func calculateNetWorth() {
        let networth = calculatedProfitArray.reduce(0, +) + calculatedLossArray.reduce(0, +)
        netWorthLabel.text = (networth >= 0 ? "" : "-") + " $" + String(abs(networth))
    }
}
