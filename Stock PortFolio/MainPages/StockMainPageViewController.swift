//
//  StockMainPageViewController.swift
//  Stock PortFolio
//
//  Created by Matthew on 4/19/22.
//

import UIKit

var stockArray: [StockInfo] = []

class StockMainPageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    
    let customGreenColor = UIColor(rgb: 0x55B400)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
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
    
    //For Deleting stocks
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Are You Sure", message: "Are you sure you want to do this? This will be permanently deleted.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            if editingStyle == .delete {
                stockArray.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath) as! StockTableViewCell
        let stock = stockArray[indexPath.row]
        let calculatedBought = stock.boughtPrice * Double(stock.shares)
        let calculatedSold = stock.soldPrice * Double(stock.shares)
        let calculatedProfitLoss = calculatedSold - calculatedBought
        let absoluteProfitLoss = abs(calculatedProfitLoss)
        cell.tickerSymbol.text = stock.tickerSymbol
        cell.totalShares.text = String("\(stock.shares) shares")
        cell.profitLossLabel.text = String(calculatedProfitLoss)
        
        if calculatedProfitLoss > 0.01 {
            cell.profitLossLabel.textColor = customGreenColor
            cell.profitLossLabel.text = String("+ $\(absoluteProfitLoss)")
        } else if calculatedProfitLoss == 0.0000 {
            cell.profitLossLabel.text = "Broke Even!"
            cell.profitLossLabel.textColor = .black
        } else {
            cell.profitLossLabel.textColor = .red
            cell.profitLossLabel.text = String("- $\(absoluteProfitLoss)")
        }
        return cell
    }
}


//For The Custom Color
extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(red: (rgb >> 16) & 0xFF, green: (rgb >> 8) & 0xFF, blue: rgb & 0xFF)
   }
}




