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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func calculateAveragePrice() {
        let sharesTextField = sharesTextField.text
        let buyPriceTextField = buyPriceTextField.text
        
        let total1 = Double(buyPriceTextField!)! * Double(sharesTextField!)!
        
        if total1 > 0.00 {
            showResultsLabel.text = String(total1)
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
