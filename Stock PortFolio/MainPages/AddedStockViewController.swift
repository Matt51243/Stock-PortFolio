//
//  AddedStockViewController.swift
//  Stock PortFolio
//
//  Created by Matthew on 4/14/22.
//

import UIKit

class AddedStockViewController: UIViewController {
    
    var tickerSymbol: String
    var shares: String
    var boughtPrice: Double
    var soldPrice: Double
    var profitLoss: Double
    
    @IBOutlet var tickerSymbolLabel: UILabel!
    @IBOutlet var totalSharesLabel: UILabel!
    @IBOutlet var totalMoneyMadeLostLabel: UILabel!
    @IBOutlet var boughtForLabel: UILabel!
    @IBOutlet var soldForLabel: UILabel!
    @IBOutlet var possibleGraphsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tickerSymbolLabel.text = tickerSymbol
        totalSharesLabel.text = ("\(shares) Shares")
        boughtForLabel.text = String("Bought For: \(boughtPrice.withCommas())")
        soldForLabel.text = String("Sold For: \(soldPrice.withCommas())")
        if profitLoss > 0.00 {
            totalMoneyMadeLostLabel.text = String("Total Profit: \(profitLoss.withCommas())")
        } else if profitLoss < 0.00 {
            totalMoneyMadeLostLabel.text = String("Total Loss: \(profitLoss.withCommas())")
        } else {
            totalMoneyMadeLostLabel.text = "You Broke Even!"
        }
    }
    
    init?(tickerSymbol: String, shares: String, boughtPrice: Double, soldPrice: Double, profitLoss: Double, coder: NSCoder) {
        self.tickerSymbol = tickerSymbol
        self.shares = shares
        self.boughtPrice = boughtPrice
        self.soldPrice = soldPrice
        self.profitLoss = profitLoss
        super.init(coder: coder)   
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
