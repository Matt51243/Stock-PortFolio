//
//  StoreItem.swift
//  Stock PortFolio
//
//  Created by Matthew on 4/28/22.
//

import Foundation

struct StoreItem: Codable, Hashable {
    let openPrice: String
    let closePrice: String
    
    enum CodingKeys: String, CodingKey {
        case openPrice = "open"
        case closePrice = "close"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.openPrice = try container.decode(String.self, forKey: .openPrice)
        self.closePrice = try container.decode(String.self, forKey: .closePrice)
    }
}

