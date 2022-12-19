	//
	//  NewTestingCoinModel.swift
	//  CoinFolios
	//
	//  Created by Jono Jono on 14/11/2022.
	//

import Foundation


struct CoinModel: Decodable {
	let data: [CoinData]
	let timestamp: Int

	
}

struct CoinData: Codable, Identifiable, Hashable {
	let id, rank, symbol, name : String
	let supply, maxSupply, marketCapUsd: String?
	let volumeUsd24Hr, priceUsd: String
	let changePercent24Hr, vwap24Hr, explorer: String?
	var amount, price: Double?
	var dateAndTime: Date?
	var transactionNotes: String?
	var holdingCurrentValue: Double?
	var boughtValue: Double?
	var profitLoss: Double?
	var profitLossPercent: Double?
	
	func updatePortfolioHodling(amount: Double, price: Double, dateAndTime: Date,  transactionNotes: String, holdingCurrentValue: Double) -> CoinData {
		return CoinData(id: id, rank: rank, symbol: symbol, name: name, supply: supply, maxSupply: maxSupply, marketCapUsd: marketCapUsd, volumeUsd24Hr: volumeUsd24Hr, priceUsd: priceUsd, changePercent24Hr: changePercent24Hr, vwap24Hr: vwap24Hr, explorer: explorer, amount: amount, price: price, dateAndTime: dateAndTime, transactionNotes: transactionNotes, holdingCurrentValue: holdingCurrentValue, boughtValue: amount  * (price), profitLoss: priceUsd.convertTodouble() - (price ), profitLossPercent: (priceUsd.convertTodouble() - price)/price * 100)
	}
}

struct ImageForLogos {
	var coinImage = "https://assets.coincap.io/assets/icons/"
	var imageFormat = "@2x.png"
	
}


struct TotalPortfolio: Hashable {
	let totalPortfolio: Double
	let totalBuyPrice: Double
	var percentProfitLoss: Double{
		return (totalPortfolio - totalBuyPrice)/totalBuyPrice * 100
	}
	
}



