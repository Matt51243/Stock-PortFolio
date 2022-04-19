//
//  StockMainPageViewController.swift
//  Stock PortFolio
//
//  Created by Matthew on 4/19/22.
//

import UIKit

class StockMainPageViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    var stockArray: [StockInfo] = []
    
    @IBAction func unwindToStockMainPage(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind", let sourceViewController = segue.source as? AddNewStockViewController, let stock = sourceViewController.stockInfo else { return }
        let newIndexPath = IndexPath(row: stockArray.count, section: 0)
        stockArray.append(stock)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "addNewStock", let vc = segue.destination as? AddNewStockViewController  {
//        }
//
//        if segue.identifier == "viewStock", let vc = segue.destination as? AddedStockViewController {
//        }
//    }
}


extension StockMainPageViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath) as! StockTableViewCell
        let stock = stockArray[indexPath.row]
        cell.tickerSymbol.text = stock.tickerSymbol
        cell.totalShares.text = String(stock.shares)
        cell.profitLossLabel.text = String(stock.soldPrice - stock.boughtPrice)
        return cell
    }
}
