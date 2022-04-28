//
//  AddNewStockViewController.swift
//  Stock PortFolio
//
//  Created by Matthew on 4/8/22.
//

import UIKit

class AddNewStockViewController: UIViewController {
    
    var stockInfo: StockInfo?
    
    @IBOutlet var SaveButton: UIButton!
    
    @IBOutlet var boughtPrice: UITextField!
    @IBOutlet var soldPrice: UITextField!
    @IBOutlet var totalShares: UITextField!
    
    @IBOutlet var timeBoughtDatePicker: UIDatePicker!
    @IBOutlet var timeBoughtLabel: UILabel!
    @IBOutlet var timeBoughtLabelThatIsntDate: UILabel!
    
    @IBOutlet var timeSoldDatePicker: UIDatePicker!
    @IBOutlet var timeSoldLabel: UILabel!
    @IBOutlet var timeSoldLabelThatIsntDate: UILabel!
    
    @IBOutlet var tickerSymbol: UITextField!
    
    @IBOutlet var basicOrAdvanced: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeSoldLabel.isHidden = true
        timeSoldLabelThatIsntDate.isHidden = true
        timeBoughtLabel.isHidden = true
        timeBoughtLabelThatIsntDate.isHidden = true
        
        let tapTimeBoughtLabel = UITapGestureRecognizer(target: self, action: #selector(AddNewStockViewController.tapBoughtFunction))
        timeBoughtLabel.isUserInteractionEnabled = true
        timeBoughtLabel.addGestureRecognizer(tapTimeBoughtLabel)
        
        let tapTimeSoldLabel = UITapGestureRecognizer(target: self, action: #selector(AddNewStockViewController.tapSoldFunction))
        timeSoldLabel.isUserInteractionEnabled = true
        timeSoldLabel.addGestureRecognizer(tapTimeSoldLabel)
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.addTarget(self, action: #selector(boughtDateChanged(_:)), for: .valueChanged)
        
        
        //Disables the Save Button if textfield are empty
        SaveButton.isEnabled = false
        [tickerSymbol, boughtPrice, soldPrice, totalShares].forEach({ $0?.addTarget(self, action: #selector(editingChanged), for: .editingChanged)})
    }

    
    //Disables the Save Button if textfield are empty
    @objc func editingChanged(_ textField: UITextField) {
        if tickerSymbol.hasText && boughtPrice.hasText && soldPrice.hasText && totalShares.hasText {
            SaveButton.isEnabled = true
        }
    }
    
    //when cancel button is pressed this makes it disappear
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func boughtDateChanged(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        let date = dateFormatter.string(from: timeBoughtDatePicker.date)
        timeBoughtLabel.text = date
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.timeSoldLabel.isHidden = false
            self.timeSoldLabelThatIsntDate.isHidden = false
            self.timeBoughtDatePicker.isHidden = true
            self.timeSoldDatePicker.isHidden = false
        }
    }
    
    @IBAction func soldDateChanged(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        let date = dateFormatter.string(from: timeBoughtDatePicker.date)
        timeSoldLabel.text = date
    }
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        switch basicOrAdvanced.selectedSegmentIndex {
        case 0:
            timeSoldLabel.isHidden = true
            timeSoldLabelThatIsntDate.isHidden = true
            timeBoughtLabel.isHidden = true
            timeBoughtLabelThatIsntDate.isHidden = true
            timeSoldDatePicker.isHidden = true
            timeBoughtDatePicker.isHidden = true
        case 1:
            timeSoldLabel.isHidden = false
            timeSoldLabelThatIsntDate.isHidden = false
            timeBoughtLabel.isHidden = false
            timeBoughtLabelThatIsntDate.isHidden = false
        default:
            break
        }
    }
    
    @objc func tapBoughtFunction(sender: UITapGestureRecognizer) {
        timeSoldLabelThatIsntDate.isHidden = true
        timeSoldLabel.isHidden = true
        timeBoughtDatePicker.isHidden = false
        
        if timeBoughtDatePicker.isHidden == false {
            timeSoldDatePicker.isHidden = true
        }
    }
    
    @objc func tapSoldFunction(sender: UITapGestureRecognizer) {
        timeSoldDatePicker.isHidden = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.timeSoldDatePicker.isHidden = true
        }
    }
    
    //For when You tap the save button
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch basicOrAdvanced.selectedSegmentIndex {
        case 0:
            let tickerSymbol = tickerSymbol.text
            let boughtPriceString = boughtPrice.text
            let boughtPrice = Double(boughtPriceString ?? "")
            let soldPriceString = soldPrice.text ?? ""
            let soldPrice = Double(soldPriceString)
            let sharesString = totalShares.text ?? ""
            let shares = Int(sharesString)

            stockInfo = StockInfo(tickerSymbol: tickerSymbol!, boughtPrice: boughtPrice!, soldPrice: soldPrice!, shares: shares!)
            
            
        case 1:
            let tickerSymbol = tickerSymbol.text
            let boughtPriceString = boughtPrice.text
            let boughtPrice = Double(boughtPriceString ?? "")
            let soldPriceString = soldPrice.text ?? ""
            let soldPrice = Double(soldPriceString)
            let sharesString = totalShares.text ?? ""
            let shares = Int(sharesString)
                        
            stockInfo = StockInfo(tickerSymbol: tickerSymbol!, boughtPrice: boughtPrice!, soldPrice: soldPrice!, shares: shares!)
        default:
            break
        }
    }
}
