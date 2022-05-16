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
    
    //option3
    @IBOutlet var sharesLabel3: UILabel!
    @IBOutlet var sharesTextField3: UITextField!
    @IBOutlet var priceBoughtLabel3: UILabel!
    @IBOutlet var priceBought3: UITextField!
    
    //option4
    @IBOutlet var sharesLabel4: UILabel!
    @IBOutlet var sharesTextField4: UITextField!
    @IBOutlet var priceBoughtLabel4: UILabel!
    @IBOutlet var priceBought4: UITextField!
    
    //option5
    @IBOutlet var sharesLabel5: UILabel!
    @IBOutlet var sharesTextField5: UITextField!
    @IBOutlet var priceBoughtLabel5: UILabel!
    @IBOutlet var priceBought5: UITextField!
    
    var numberOfTimesAverageStock = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupToolbar()
        hideOption3()
        hideOption4()
        hideOption5()
        if numberOfTimesAverageStock < 3 {
            numberOfTimesAverageStock += 1
            //run function
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        overrideUserInterfaceStyle = .light
    }

    
    //hides and shows option3
    func hideOption3() {
        sharesLabel3.isHidden = true
        sharesTextField3.isHidden = true
        priceBoughtLabel3.isHidden = true
        priceBought3.isHidden = true
    }
    func showOption3() {
        sharesLabel3.isHidden = false
        sharesTextField3.isHidden = false
        priceBoughtLabel3.isHidden = false
        priceBought3.isHidden = false
    }

    //hides and shows option4
    func hideOption4() {
        sharesLabel4.isHidden = true
        sharesTextField4.isHidden = true
        priceBoughtLabel4.isHidden = true
        priceBought4.isHidden = true
    }
    func showOption4() {
        sharesLabel4.isHidden = false
        sharesTextField4.isHidden = false
        priceBoughtLabel4.isHidden = false
        priceBought4.isHidden = false
    }
    
    //hides and shows option5
    func hideOption5() {
        sharesLabel5.isHidden = true
        sharesTextField5.isHidden = true
        priceBoughtLabel5.isHidden = true
        priceBought5.isHidden = true
    }
    func showOption5() {
        sharesLabel5.isHidden = false
        sharesTextField5.isHidden = false
        priceBoughtLabel5.isHidden = false
        priceBought5.isHidden = false
    }
    
    func calculateAveragePrice() {
        let sharesTextField = sharesTextField.text
        let buyPriceTextField = buyPriceTextField.text
        let sharesTextField2 = sharesTextfield2.text
        let priceBought2 = priceBought2.text
        var sharesTextField3 = sharesTextField3.text
        var buyPrice3 = priceBought3.text
        var sharesTextField4 = sharesTextField4.text
        var buyPrice4 = priceBought4.text
//        var sharesTextField5 = sharesTextField5.text
//        var buyPrice5 = priceBought5.text
        
        if sharesTextField3?.isEmpty == true && buyPrice3?.isEmpty == true {
            sharesTextField3 = String(0)
            buyPrice3 = String(0)
        }
        if sharesTextField4?.isEmpty == true && buyPrice4?.isEmpty == true {
            sharesTextField4 = String(0)
            buyPrice4 = String(0)
        }
        
        let optionOne = (Double(sharesTextField!)! * Double(buyPriceTextField!)!)
        let optionTwo = (Double(sharesTextField2!)! * Double(priceBought2!)!)
        let optionThree = (Double(sharesTextField3!)! * Double(buyPrice3!)!)
        let optionFour = (Double(sharesTextField4!)! * Double(buyPrice4!)!)
//        let optionFive = (Double(sharesTextField5!)! * Double(buyPrice5!)!)
        
        
        //need to make it show the actual label when it is more than two
        if sharesLabel3.isHidden == false {
            let totalSharesThree = Double(sharesTextField!)! + Double(sharesTextField2!)! + Double(sharesTextField3!)!
            let totalAmountBoughtThree = optionOne + optionTwo + optionThree
            let totalThree = totalAmountBoughtThree / totalSharesThree
            let totalToTwoPlaces = String(format: "%.2f", totalThree)
            
            showResultsLabel.text = "Price: $\(String(totalToTwoPlaces))"
            showTotalSharesLabel.text = "Total Shares: \(Int(totalSharesThree))"
        } else if sharesLabel3.isHidden == false && sharesLabel4.isHidden == false {
            let totalSharesFour = Double(sharesTextField!)! + Double(sharesTextField2!)! + Double(sharesTextField3!)! + Double(sharesTextField4!)!
            let totalAmountBoughtFour = optionOne + optionTwo + optionThree + optionFour
            let totalFour = totalAmountBoughtFour / totalSharesFour
            let totalToTwoPlaces = String(format: "%.2f", totalFour)
            
            showResultsLabel.text = "Price: $\(String(totalToTwoPlaces))"
            showTotalSharesLabel.text = "Total Shares: \(Int(totalSharesFour))"
        } else if sharesLabel3.isHidden == true {
            let totalShares = Double(sharesTextField!)! + Double(sharesTextField2!)!
            let totalAmountBought = optionOne + optionTwo
            let total = totalAmountBought / totalShares
            let totalToTwoPlaces = String(format: "%.2f", total)
            
            showResultsLabel.text = "Price: $\(String(totalToTwoPlaces))"
            showTotalSharesLabel.text = "Total Shares: \(Int(totalShares))"
        }
    }
    
    //shows the options. Need to add it so that it adds the 5th one too
    @IBAction func addMoreButton(_ sender: Any) {
        if sharesLabel3.isHidden == true {
            showOption3()
            showResultsLabel.isHidden = true
            showTotalSharesLabel.isHidden = true
        } else if sharesLabel3.isHidden == false {
            showOption4()
            showResultsLabel.isHidden = true
            showTotalSharesLabel.isHidden = true
        }
    }
    
    @IBAction func calculateButton(_ sender: Any) {
        calculateAveragePrice()
    }
    
    //makes the numberpad have the done button
    func setupToolbar() {
        let bar = UIToolbar()
        let doneBtn = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissMyKeyboard))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        bar.items = [flexSpace, flexSpace, doneBtn]
        bar.sizeToFit()
        sharesTextField.inputAccessoryView = bar
        sharesTextfield2.inputAccessoryView = bar
        sharesTextField3.inputAccessoryView = bar
        sharesTextField4.inputAccessoryView = bar
        sharesTextField5.inputAccessoryView = bar
        
        buyPriceTextField.inputAccessoryView = bar
        priceBought2.inputAccessoryView = bar
        priceBought3.inputAccessoryView = bar
        priceBought4.inputAccessoryView = bar
        priceBought5.inputAccessoryView = bar
    }
    
    @objc func dismissMyKeyboard() {
        view.endEditing(true)
    }
}
