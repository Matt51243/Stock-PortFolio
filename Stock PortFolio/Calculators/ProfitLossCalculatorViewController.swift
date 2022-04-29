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
    
    @IBOutlet var calculateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupToolbar()
        
        //Disabled the calculate button if textfields are empty
        calculateButton.isEnabled = false
        [buyPrice, sellPrice, shares].forEach({ $0?.addTarget(self, action: #selector(editingChanged), for: .editingChanged)})
    }
    
    //Disabled the calculate button if textfields are empty
    @objc func editingChanged(_ textField: UITextField) {
        if buyPrice.hasText && sellPrice.hasText && shares.hasText {
            calculateButton.isEnabled = true
        }
    }
    
    //calculates the profit you would make or the loss you would make
    func calculateProfitOrLoss() {
        let buyPrice = buyPrice.text
        let sellPrice = sellPrice.text
        let shares = shares.text
        
        let buyTotal = Double(buyPrice!)! * Double(shares!)!
        let sellTotal = Double(sellPrice!)! * Double(shares!)!
        
        let calculatedTotal = sellTotal - buyTotal
        let calculatedTotalAtTwoDecimals = String(format: "%.2f", calculatedTotal)
        let calculatedTotalDouble = Double(calculatedTotalAtTwoDecimals)!
        let absoluteCalculated = abs(calculatedTotalDouble)
        
        if calculatedTotal > 0 {
            showResultsLabel.text = "Total Profit: $\(absoluteCalculated)"
            showResultsLabel.textColor = customGreenColor
        } else if calculatedTotal < 0 {
            showResultsLabel.text = "Total Loss: - $\(absoluteCalculated)"
            showResultsLabel.textColor = .red
        } else {
            showResultsLabel.text = "You Broke Even!"
            showResultsLabel.textColor = .black
        }
    }
    
    //action for when the button is tapped
    @IBAction func calculateButton(_ sender: Any) {
        calculateProfitOrLoss()
    }
    
    //makes the numberpad have the done button
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



