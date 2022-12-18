	//
	//  NewTestingCoinModel.swift
	//  CoinFolios
	//
	//  Created by Jono Jono on 14/11/2022.
	//

import Foundation


	// MARK: - Welcome
struct CoinModel: Decodable {
	let data: [CoinData]
	let timestamp: Int
	
	static let newcoinCapExample = CoinModel(data: [CoinData(id: "bitcoin",
															 rank: "1",
															 symbol: "BTC",
															 name: "Bitcoin",
															 supply: "19193100.0000000000000000",
															 maxSupply: "21000000.0000000000000000",
															 marketCapUsd: "397888264525.5591083450053800",
															 volumeUsd24Hr: "11007783003.0388538590720480",
															 priceUsd: "20730.7972409646752398",
															 changePercent24Hr: "0.0394813888297129",
															 vwap24Hr: "20849.4764965301855711",
															 explorer: "https://blockchain.info/")],
											 timestamp: 1667102350328)
	
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
	
		// coinDetail init data
	static let newcoinDetailExample = CoinData(id: "bitcoin",
											   rank: "1",
											   symbol: "BTC",
											   name: "Bitcoin",
											   supply: "19193100.0000000000000000",
											   maxSupply: "21000000.0000000000000000",
											   marketCapUsd: "397888264525.5591083450053800",
											   volumeUsd24Hr: "11007783003.0388538590720480",
											   priceUsd: "20730.7972409646752398",
											   changePercent24Hr: "0.0394813888297129",
											   vwap24Hr: "20849.4764965301855711",
											   explorer: "https://blockchain.info/")
	
		// coinDetail init data for the new one
	static let newcoinDetailExample2 = [CoinData(id: "bitcoin",
												 rank: "1",
												 symbol: "BTC",
												 name: "Bitcoin",
												 supply: "19193100.0000000000000000",
												 maxSupply: "21000000.0000000000000000",
												 marketCapUsd: "397888264525.5591083450053800",
												 volumeUsd24Hr: "11007783003.0388538590720480",
												 priceUsd: "20730.7972409646752398",
												 changePercent24Hr: "0.0394813888297129",
												 vwap24Hr: "20849.4764965301855711",
												 explorer: "https://blockchain.info/")]
	
	func updatePortfolioHodling(amount: Double, price: Double, dateAndTime: Date,  transactionNotes: String, holdingCurrentValue: Double) -> CoinData {
		return CoinData(id: id, rank: rank, symbol: symbol, name: name, supply: supply, maxSupply: maxSupply, marketCapUsd: marketCapUsd, volumeUsd24Hr: volumeUsd24Hr, priceUsd: priceUsd, changePercent24Hr: changePercent24Hr, vwap24Hr: vwap24Hr, explorer: explorer, amount: amount, price: price, dateAndTime: dateAndTime, transactionNotes: transactionNotes, holdingCurrentValue: holdingCurrentValue, boughtValue: amount  * (price), profitLoss: priceUsd.convertTodouble() - (price ), profitLossPercent: (priceUsd.convertTodouble() - price)/price * 100)
	}
}

struct ImageForLogos {
	var coinImage = "https://assets.coincap.io/assets/icons/"
	var imageFormat = "@2x.png"
	
}


struct TotalHolding: Identifiable, Equatable{
	let id: String
	let date: Date
	let totalHolding: Double
	
}


struct TotalPortfolio: Hashable {
	let totalPortfolio: Double
	let totalBuyPrice: Double
	var percentProfitLoss: Double{
		return (totalPortfolio - totalBuyPrice)/totalBuyPrice * 100
	}
	
}



