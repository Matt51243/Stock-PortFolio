//
//  StockMainPageViewController.swift
//  Stock PortFolio
//
//  Created by Matthew on 4/19/22.
//

import UIKit

class StockMainPageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    var stockArray: [StockInfo] = []
    
    @IBAction func unwindToStockMainPage(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind", let sourceViewController = segue.source as? AddNewStockViewController, let stock = sourceViewController.stockInfo else { return }
        let indexPath = IndexPath(row: stockArray.count, section: 0)
        stockArray.append(stock)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentStock = stockArray[indexPath.row]
        performSegue(withIdentifier: "viewStock", sender: currentStock)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath) as! StockTableViewCell
        let stock = stockArray[indexPath.row]
        let calculatedBought = stock.boughtPrice * Double(stock.shares)
        let calculatedSold = stock.soldPrice * Double(stock.shares)
        let calculatedProfitLoss = calculatedSold - calculatedBought
        cell.tickerSymbol.text = stock.tickerSymbol
        cell.totalShares.text = String("\(stock.shares) shares")
        cell.profitLossLabel.text = String(calculatedProfitLoss)
        
        if calculatedProfitLoss > 0.01 {
            cell.profitLossLabel.textColor = .green
        } else if calculatedProfitLoss == 0.0000 {
            cell.profitLossLabel.text = "Broke Even!"
        } else {
            cell.profitLossLabel.textColor = .red
        }
        return cell
    }
}





