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
    
    @IBOutlet var todaysProfitLossLabel: UILabel!
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
    }
    
    func setTotalTrades() {
        if stockArray.count == 0 {
            totalTradesMadeLabel.text = "NA"
        } else if stockArray.count >= 1 {
            totalTradesMadeLabel.text = String(stockArray.count)
        }
    }
    
    //Adds all of the stocks that they added that are profit and changes the label to that
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
    
    func calculateTotalLosses() {
        stockArray.forEach { stock in
            if (stock.soldPrice * Double(stock.shares)) - (stock.boughtPrice * Double(stock.shares)) < 0.001 {
                let totalSoldPrice = stock.soldPrice * Double(stock.shares)
                let totalBoughtPrice = stock.boughtPrice * Double(stock.shares)
                let calculatedLoss = totalSoldPrice - totalBoughtPrice
                
                calculatedLossArray.append(calculatedLoss)
                print(calculatedLoss)
                let totalAddedLosses = calculatedLossArray.reduce(0, +)
                let absoulteValueLosses = abs(totalAddedLosses)
                totalLossesLabel.text = String("- $\(absoulteValueLosses)")
            }
        }
    }
}
