//
//  ProfitLossCalculatorViewController.swift
//  Stock PortFolio
//
//  Created by Matthew on 4/8/22.
//

import UIKit

class ProfitLossCalculatorViewController: UIViewController {
    @IBOutlet var buyPrice: UITextField!
    @IBOutlet var sellPrice: UITextField!
    @IBOutlet var shares: UITextField!
    
    @IBOutlet var showResultsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupToolbar()
    }
    
    func calculateProfitOrLoss() {
        let buyPrice = buyPrice.text
        let sellPrice = sellPrice.text
        let shares = shares.text
        
        let buyTotal = Double(buyPrice!)! * Double(shares!)!
        let sellTotal = Double(sellPrice!)! * Double(shares!)!
        
        let calculatedTotal = sellTotal - buyTotal
        
        if calculatedTotal > 0 {
            showResultsLabel.text = "Total Profit: $\(calculatedTotal)"
            showResultsLabel.textColor = .green
        } else if calculatedTotal < 0 {
            showResultsLabel.text = "Total Loss: $\(calculatedTotal)"
            showResultsLabel.textColor = .red
        } else {
            showResultsLabel.text = "You Broke Even!"
            showResultsLabel.textColor = .black
        }
    }
    
    @IBAction func calculateButton(_ sender: Any) {
        calculateProfitOrLoss()
    }
    
    //MARK: Done for NumberPad
    func setupToolbar() {
        let bar = UIToolbar()
        let doneBtn = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissMyKeyboard))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        bar.items = [flexSpace, flexSpace, doneBtn]
        bar.sizeToFit()
        buyPrice.inputAccessoryView = bar
        sellPrice.inputAccessoryView = bar
        shares.inputAccessoryView = bar
    }
    
    @objc func dismissMyKeyboard() {
        view.endEditing(true)
    }
}



