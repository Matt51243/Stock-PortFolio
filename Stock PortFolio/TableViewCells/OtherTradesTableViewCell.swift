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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
