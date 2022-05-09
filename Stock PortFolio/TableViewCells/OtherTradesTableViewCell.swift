//
//  OtherTradesTableViewCell.swift
//  Stock PortFolio
//
//  Created by Matthew on 5/6/22.
//

import UIKit

class OtherTradesTableViewCell: UITableViewCell {

    @IBOutlet var OtherTradesSharesLabel: UILabel!
    @IBOutlet var OtherTradesTotalProfitLossLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        overrideUserInterfaceStyle = .light
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateOtherTrades(with stock: StockInfo) {
        OtherTradesSharesLabel.text = String(stock.shares)
        OtherTradesTotalProfitLossLabel.text = String((stock.soldPrice) * Double(stock.shares) - (stock.boughtPrice * Double(stock.shares)))
    }
}
