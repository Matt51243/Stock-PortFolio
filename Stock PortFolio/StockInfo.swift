//
//  StockInfo.swift
//  Stock PortFolio
//
//  Created by Matthew on 4/15/22.
//

import Foundation

struct StockInfo: Codable {
    var tickerSymbol: String
    var boughtPrice: Double
    var soldPrice: Double
    var shares: Int
    
    
//    static let archiveURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("Stocks_file").appendingPathExtension("plist")
//
//    static func saveToFile(stocks: [StockInfo]) {
//        let propertyListEncoder = PropertyListEncoder()
//        let endcodeStocks = try? propertyListEncoder.encode(stocks)
//        try? endcodeStocks?.write(to: archiveURL, options: .noFileProtection)
//
//    }
//
//    static func loadFromFile() -> [StockInfo]? {
//        let propertyListDecoder = PropertyListDecoder()
//        if let retrivedStockData = try? Data(contentsOf: archiveURL),
//           let decodedStock = try? propertyListDecoder.decode(Array<StockInfo>.self, from: retrivedStockData) {
//            return decodedStock
//        }
//        return nil
//    }
}

struct StockInfoAndDate: Codable {
    var tickerSymbol: String
    var boughtPrice: Double
    var soldPrice: Double
    var shares: Int
    var timeBought: Date
    var timeSold: Date
}
