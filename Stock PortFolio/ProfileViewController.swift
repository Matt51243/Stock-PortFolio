//
//  ProfileViewController.swift
//  Stock PortFolio
//
//  Created by Matthew on 4/26/22.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet var todaysProfitLossLabel: UILabel!
    @IBOutlet var totalProfitLabel: UILabel!
    @IBOutlet var totalLossesLabel: UIView!
    
    @IBOutlet var barGraphImage: UIImageView!
    
    @IBOutlet var biggestProfitLabel: UILabel!
    @IBOutlet var biggestLossLabel: UILabel!
    @IBOutlet var totalTradesMadeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

}
