//
//  AddNewStockViewController.swift
//  Stock PortFolio
//
//  Created by Matthew on 4/8/22.
//

import UIKit

class AddNewStockViewController: UIViewController {
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
    }
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        switch basicOrAdvanced.selectedSegmentIndex {
        case 0:
            timeSoldLabel.isHidden = true
            timeSoldLabelThatIsntDate.isHidden = true
            timeBoughtLabel.isHidden = true
            timeBoughtLabelThatIsntDate.isHidden = true
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.timeSoldLabel.isHidden = false
            self.timeSoldLabelThatIsntDate.isHidden = false
            self.timeBoughtDatePicker.isHidden = true
            self.timeSoldDatePicker.isHidden = false
        }
    }
    
    @objc func tapSoldFunction(sender: UITapGestureRecognizer) {
        timeSoldDatePicker.isHidden = false
    }
}
