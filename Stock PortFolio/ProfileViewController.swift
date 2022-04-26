//
//  ProfileViewController.swift
//  Stock PortFolio
//
//  Created by Matthew on 4/26/22.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet var todaysProfitLossLabel: UILabel!
    @IBOutlet var totalProfitLabel: UILabel!
    @IBOutlet var totalLossesLabel: UIView!
    
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
    }
    
    func setTotalTrades() {
        if stockArray.count == 0 {
            totalTradesMadeLabel.text = "NA"
        } else if stockArray.count >= 1 {
            totalTradesMadeLabel.text = String(stockArray.count)
        }
    }
    
    //Not sure how do this right here
    func calculateTotalProfit() {
        let filteredPositive = stockArray.filter { stock in
            return (stock.soldPrice) - (stock.boughtPrice) >= 0.0001
        }
    }
}
