//
//  AverageStockPriceViewController.swift
//  Stock PortFolio
//
//  Created by Matthew on 4/9/22.
//

import UIKit

class AverageStockPriceViewController: UIViewController {

    @IBOutlet var sharesLabel: UILabel!
    @IBOutlet var sharesTextField: UITextField!
    @IBOutlet var buyPriceLabel: UILabel!
    @IBOutlet var buyPriceTextField: UITextField!
    
    @IBOutlet var showResultsLabel: UILabel!
    @IBOutlet var showTotalSharesLabel: UILabel!
    
    @IBOutlet var sharesTextfield2: UITextField!
    @IBOutlet var priceBought2: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func calculateAveragePrice() {
        let sharesTextField = sharesTextField.text
        let buyPriceTextField = buyPriceTextField.text
        let sharesTextField2 = sharesTextfield2.text
        let priceBought2 = priceBought2.text
        
        let totalShares = Double(sharesTextField!)! + Double(sharesTextField2!)!
        
        let totalAmountBought = (Double(sharesTextField!)! * Double(buyPriceTextField!)!) + Double(sharesTextField2!)! * Double(priceBought2!)!
        
        let total = totalAmountBought / totalShares
        
        let totalToTwoPlaces = String(format: "%.2f", total)
        
        
        if total > 0.00 {
            showResultsLabel.text = "Price: $\(String(totalToTwoPlaces))"
            showTotalSharesLabel.text = "Total Shares: \(Int(totalShares))"
        } else {
            showResultsLabel.text = "Now...Reality Can Be Whatever I Want"
        }
    }
    
    @IBAction func addMoreButton(_ sender: Any) {
        
    }
    
    @IBAction func calculateButton(_ sender: Any) {
        calculateAveragePrice()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
