//
//  ProfileViewController.swift
//  Stock PortFolio
//
//  Created by Matthew on 4/26/22.
//

import UIKit
import Charts

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
    
    @IBOutlet var pieChart: PieChartView!
    
    var numberOfTimesProfile = 0
    
    var profits = PieChartDataEntry(value: 0)
    var losses = PieChartDataEntry(value: 0)
    
    var profitsLossDataEntries = [PieChartDataEntry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTotalTrades()
        calculateTotalProfit()
        calculateTotalLosses()
        biggestProfit()
        biggestLoss()
        calculateNetWorth()
        profitsLossDataEntries = [profits, losses]
        
        if numberOfTimesProfile < 3 {
            numberOfTimesProfile += 1
            //run function
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        overrideUserInterfaceStyle = .light
        updateChartData()
    }
    
    //sets the totalTradesMadeLabel to the amount of trades that they have
    func setTotalTrades() {
        if stockArray.count == 0 {
            totalTradesMadeLabel.text = "NA"
        } else if stockArray.count >= 1 {
            totalTradesMadeLabel.text = String(stockArray.count.withIntCommas())
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

                totalProfitLabel.text = String("\(totalAddedProfit.withCommas())")
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
                let totalAddedProfit = calculatedProfitArray.reduce(0, +)
                
                //Use for finding the percentage
                let total: Double = totalAddedProfit + absoulteValueLosses
                
                //For the Profit part
//                let realTotal: Double = totalAddedProfit / (total)
//                let realPerentage = realTotal * 100
//                profits.value = realPerentage
////
//
//                // For the Losses Part
//                let percentage = absoulteValueLosses / (total)
//                let realPercentage = percentage * 100
//                losses.value = realPercentage
//                losses.label = "Losses"
                
                //For the Losses Part
                losses.value = Double(calculatedLossArray.count)
                if calculatedLossArray.count == 0 {
                    losses.label = "No Trades"
                } else if calculatedLossArray.count == 1 {
                    losses.label = "Trade"
                } else if calculatedLossArray.count >= 2 {
                    losses.label = "Trades"
                }
                
                //For the Profits Part
                profits.value = Double(calculatedProfitArray.count)
                if calculatedProfitArray.count == 0 {
                    profits.label = "No Trades"
                } else if calculatedProfitArray.count == 1 {
                    profits.label = "Trade"
                } else if calculatedProfitArray.count >= 2 {
                    profits.label = "Trades"
                }
                
                
                totalLossesLabel.text = String("- \(absoulteValueLosses.withCommas())")
            }
        }
    }
    
    //finds the biggest profit and makes biggestProfitLabel that number
    func biggestProfit() {
        let largestProfit = calculatedProfitArray.max()
        if calculatedProfitArray.count == 0 {
            biggestProfitLabel.text = "NA"
        } else if calculatedProfitArray.count >= 1 {
            biggestProfitLabel.text = String("\(largestProfit!.withCommas())")
        }
    }
    
    //finds the biggest loss and makes biggestLossLabel that number
    func biggestLoss() {
        let largestLoss = calculatedLossArray.max()
        if calculatedLossArray.count == 0 {
            biggestLossLabel.text = "NA"
        } else if calculatedLossArray.count >= 1 {
            let absoluteValueLosses = abs(largestLoss!)
            biggestLossLabel.text = String("- \(absoluteValueLosses.withCommas())")
        }
    }
    
    //calculates the net worth of the person account
    func calculateNetWorth() {
        let networth = calculatedProfitArray.reduce(0, +) + calculatedLossArray.reduce(0, +)
        netWorthLabel.text = (networth >= 0 ? "" : "-") + "" + (abs(networth).withCommas())

        if networth > 0.00 {
            netWorthLabel.textColor = customGreenColor
        } else if networth < 0.00 {
            netWorthLabel.textColor = customRedColor
        } else {
            netWorthLabel.textColor = .black
        }
    }
    
    //Sets up the Pie Chart
    func updateChartData() {
        pieChart.chartDescription?.enabled = false
        pieChart.drawHoleEnabled = true
        pieChart.rotationAngle = 270
        pieChart.rotationEnabled = false
 
        let chartDataSet = PieChartDataSet(entries: profitsLossDataEntries, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        
        let colors = [UIColor(rgb: 0x55B400), UIColor(rgb: 0xDD1E1C)]
        chartDataSet.colors = colors
        
        pieChart.data = chartData
    }
}

//adds commas to doubles
extension Double {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale.current
        numberFormatter.numberStyle = .currency
        return numberFormatter.string(from: NSNumber(value: self))!
    }
}
//adds commas to Ints
extension Int {
    func withIntCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: self))!
    }
}
