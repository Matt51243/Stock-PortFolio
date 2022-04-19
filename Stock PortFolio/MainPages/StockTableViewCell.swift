//
//  StockTableViewCell.swift
//  Stock PortFolio
//
//  Created by Matthew on 4/19/22.
//

import UIKit

class StockTableViewCell: UITableViewCell {

    @IBOutlet var tickerSymbol: UILabel!
    @IBOutlet var totalShares: UILabel!
    @IBOutlet var upOrDownImage: UIImageView!
    @IBOutlet var profitLossLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func update(with stock: StockInfo) {
        tickerSymbol.text = stock.tickerSymbol
        totalShares.text = String(stock.shares)
        profitLossLabel.text = String(stock.soldPrice - stock.boughtPrice)
    }

}
