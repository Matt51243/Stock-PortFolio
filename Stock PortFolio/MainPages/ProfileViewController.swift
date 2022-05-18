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
    var calculatedBrokeEvenArray = [Double]()
    
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
    @IBOutlet var noStocksLabel: UILabel!
    
    var numberOfTimesProfile = 0
    
    var profits = PieChartDataEntry(value: 0)
    var losses = PieChartDataEntry(value: 0)
    var brokeEven = PieChartDataEntry(value: 0)
    
    var profitsLossDataEntries = [PieChartDataEntry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTotalTrades()
        calculateTotalProfit()
        calculateBreakEven()
        calculateTotalLosses()
        biggestProfit()
        biggestLoss()
        calculateNetWorth()
        
        if profits.value > 0 {
            profitsLossDataEntries.append(profits)
        }
        if losses.value > 0 {
            profitsLossDataEntries.append(losses)
        }
        if brokeEven.value > 0 {
            profitsLossDataEntries.append(brokeEven)
        }

        
        if numberOfTimesProfile < 3 {
            numberOfTimesProfile += 1
            //run function
        }
    }

    
    override func viewWillAppear(_ animated: Bool) {
        overrideUserInterfaceStyle = .light
        noStocksLabel.isHidden = true
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
    
    //Adds all of the stocks that are broke even
    func calculateBreakEven() {
        stockArray.forEach { stock in
            if (stock.soldPrice * Double(stock.shares)) - (stock.boughtPrice * Double(stock.shares)) == 0.000 {
                let totalSoldPrice = stock.soldPrice * Double(stock.shares)
                let totalBoughtPrice = stock.boughtPrice * Double(stock.shares)
                let calculatedBrokeEven = totalSoldPrice - totalBoughtPrice
                
                calculatedBrokeEvenArray.append(calculatedBrokeEven)
            }
        }
    }
    
    //Adds all of the stocks that they added that are losses and changes totalLossesLabel to that
    func calculateTotalLosses() {
        stockArray.forEach { stock in
            if (stock.soldPrice * Double(stock.shares)) - (stock.boughtPrice * Double(stock.shares)) < 0.0 {
                let totalSoldPrice = stock.soldPrice * Double(stock.shares)
                let totalBoughtPrice = stock.boughtPrice * Double(stock.shares)
                let calculatedLoss = totalSoldPrice - totalBoughtPrice
                
                calculatedLossArray.append(calculatedLoss)
                let totalAddedLosses = calculatedLossArray.reduce(0, +)
                let absoulteValueLosses = abs(totalAddedLosses)
                totalLossesLabel.text = String("- \(absoulteValueLosses.withCommas())")
                
            }

                //For the Losses Part
                losses.value = Double(calculatedLossArray.count)
                if calculatedLossArray.count == 0 {
                    losses.label = ""
                    losses.value = 0
                } else if calculatedLossArray.count == 1 {
                    losses.label = "Loss"
                } else if calculatedLossArray.count >= 2 {
                    losses.label = "Losses"
                }
                
                //For the Profits Part
                profits.value = Double(calculatedProfitArray.count)
                if calculatedProfitArray.count == 0 {
                    profits.label = ""
                } else if calculatedProfitArray.count == 1 {
                    profits.label = "Profit"
                } else if calculatedProfitArray.count >= 2 {
                    profits.label = "Profits"
                }
                
                //For the Break Even Part
                brokeEven.value = Double(calculatedBrokeEvenArray.count)
                if calculatedBrokeEvenArray.count == 0 {
                    brokeEven.label = ""
                    brokeEven.value = 0
                } else if calculatedBrokeEvenArray.count == 1 {
                    brokeEven.label = "Break Even"
                } else if calculatedBrokeEvenArray.count >= 2 {
                    brokeEven.label = "Break Evens"
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
        let largestLoss = calculatedLossArray.min()
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
        pieChart.chartDescription?.text = "Trades Outcome"
        pieChart.drawHoleEnabled = false
        pieChart.rotationAngle = 270
        pieChart.rotationEnabled = false
 
        let chartDataSet = PieChartDataSet(entries: profitsLossDataEntries, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        
        var colors = [UIColor]()
        let green = UIColor(rgb: 0x55B400)
        let red = UIColor(rgb: 0xDD1E1C)
        let grey = UIColor(rgb: 0xC9D1CE)
        
        if profits.value == 0 && losses.value == 0 && brokeEven.value == 0 {
            noStocksLabel.isHidden = false
            pieChart.chartDescription?.enabled = false
        }
        
        if profits.value > 0 {
            colors.append(green)
        }
        
        if losses.value > 0 {
            colors.append(red)
        }
        
        if brokeEven.value > 0 {
            colors.append(grey)
        }
        
        chartDataSet.colors = colors
        
        pieChart.data = chartData

        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        chartData.setValueFormatter(DefaultValueFormatter(formatter: formatter))
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
