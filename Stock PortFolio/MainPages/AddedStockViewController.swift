//
//  AddedStockViewController.swift
//  Stock PortFolio
//
//  Created by Matthew on 4/14/22.
//

import UIKit

class AddedStockViewController: UIViewController {
    
    var mainPage = StockMainPageViewController()
    
    @IBOutlet var tickerSymbolLabel: UILabel!
    @IBOutlet var totalSharesLabel: UILabel!
    @IBOutlet var totalMoneyMadeLostLabel: UILabel!
    @IBOutlet var boughtForLabel: UILabel!
    @IBOutlet var soldForLabel: UILabel!
    @IBOutlet var possibleGraphsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
}
