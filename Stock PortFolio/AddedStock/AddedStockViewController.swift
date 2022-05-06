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
    
    @IBOutlet var NoOtherTradesLabel: UILabel!
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        
        tableView.delegate = self
        tableView.dataSource = self
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
        
        
        let filteredStockArray = stockArray.filter { $0.tickerSymbol == tickerSymbolLabel.text }
        if filteredStockArray.count == 0 {
        } else if filteredStockArray.count >= 1 {
            
//            NoOtherTradesLabel.isHidden = true
            print(filteredStockArray.count)
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


extension AddedStockViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
        //have to return the filteredArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OtherTradesCell", for: indexPath) as! OtherTradesTableViewCell
        cell.OtherTradesSharesLabel.text = String("\(shares) Shares")
        cell.OtherTradesTotalProfitLossLabel.text = shares
        
        return cell
    }
}
