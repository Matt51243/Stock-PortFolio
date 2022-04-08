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
    @IBOutlet var timeSoldDatePicker: UIDatePicker!
    
    @IBOutlet var tickerSymbol: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
