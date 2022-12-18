////
////  CoinModel.swift
////  CoinFolios
////
////  Created by Jono Jono on 23/10/2022.
////
//
////
////import Foundation
////
////
////struct CoinModel : Identifiable, Codable{
////	let id : String
////	let symbol: String
////	let image: String
////	let current_price: Double
////	let market_cap: Int
////	let market_cap_rank: Int
////	let market_cap_change_percentage_24h: Double
////	let price_change_percentage_24h: Double
////	let last_updated: String
////	var sparkline_in_7d: Sparkline_in_7d
////	var portfolio: Double?
////
////
////
////		// for later portfolio
////	func updatePortfolio(amount: Double) -> CoinModel {
////		return CoinModel(id: id, symbol: symbol, image: image, current_price: current_price, market_cap: market_cap, market_cap_rank: market_cap_rank, market_cap_change_percentage_24h: market_cap_change_percentage_24h, price_change_percentage_24h: price_change_percentage_24h, last_updated: last_updated, sparkline_in_7d: sparkline_in_7d, portfolio: portfolio)
////	}
////		// for later portfolio
////
////	var portfolioValue: Double {
////		return(portfolio ?? 0) * current_price
////	}
////		// for later portfolio
////	var portfolioRank: Int {
////		return Int(market_cap_rank)
////	}
////
////
////
////		// example placeholder coin data
////	static let exampleCoinData =
////	CoinModel(id: "bitcoin",
////			  symbol: "btc",
////			  image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
////			  current_price: 19103.19,
////			  market_cap: 366322969335,
////			  market_cap_rank: 1,
////			  market_cap_change_percentage_24h: -0.68193,
////			  price_change_percentage_24h: 2.9, last_updated: "2022-10-12T04:12:55.947Z",
////			  sparkline_in_7d: Sparkline_in_7d(price: [19629.436726014468, 19832.03947701027, 20073.74596854634, 19888.52381298449, 19956.748560508324, 19985.71340364127, 19958.65860336516, 20014.055970895763, 20165.00749408891, 20089.741496965144, 20086.858987393316, 19989.09172013866, 20149.880742522742, 20247.618224575548, 20346.28387064516, 20327.79384349392, 20281.6135942938, 20345.398520106643, 20190.03704032425, 20244.14420129776, 20210.286155816968, 20206.077347881113, 20132.69380957914, 20205.603585675744, 20228.989713623803, 20228.989713623803, 20270.711957770167, 20129.371885481934, 20076.679928438527, 20115.78969217367, 20010.678187803518, 20042.800700642925, 19911.243635202813, 19915.247638692173, 19992.255020597353, 20248.552954454222, 20197.349114545897, 20239.360504772387, 20151.583810890184, 20032.002263067814, 20051.34264004818, 20163.361588378815, 20161.830614985047, 20377.310488515064, 20420.507309657056, 20326.281212218324, 20351.859687650194, 20385.718673998093, 20295.52833106279, 20202.922170254835, 20235.15839184066, 20158.43390044222, 20102.64312692146, 20131.87518416923, 20233.124886177106, 20205.99390668989, 20240.158110414446, 20092.017702606056, 20071.17816840879, 20081.986993611154, 20127.84383239967, 20021.83259190284, 20020.071066874156, 20035.099703191016, 19947.23526474766, 19922.671962564382, 19949.051041418512, 19983.014487633158, 19978.144559771044, 20042.5610462963, 20008.43915941483, 19974.60761407077, 19983.837785039814, 19866.408195052518, 19937.60397758876, 19989.253201940555, 19973.438862718172, 19986.501481972562, 20015.467843043927, 19714.931273870803, 19575.372726842128, 19635.406179602924, 19568.56464163464, 19378.996314888107, 19433.643021776577, 19457.308951251147, 19504.713218861503, 19502.61140064051, 19483.47601213879, 19512.648184862534, 19507.93694883784, 19529.940881167193, 19507.185443550337, 19496.27356041626, 19494.514719372994, 19496.545850939267, 19527.316952243917, 19497.729930464047, 19488.68288527137, 19467.124401991572, 19479.60220231644, 19319.725713659474, 19369.08596022181, 19419.398372249936, 19405.792092644053, 19379.968763706278, 19395.163959343496, 19383.750510976493, 19380.8839927649, 19409.815660718283, 19432.52357570095, 19417.812043576265, 19392.857079033794, 19419.3110013487, 19448.573369317768, 19476.83715483821, 19493.5919103997, 19492.97481496653, 19526.95683762805, 19538.645102325067, 19508.47986809752, 19507.74732132686, 19503.271603147754, 19465.042466311086, 19480.583197426084, 19460.935211750042, 19431.764534258986, 19435.52286156838, 19446.74373818419, 19505.90837096838, 19471.866733153704, 19443.480391776277, 19474.756431916227, 19406.73317945203, 19390.384608648572, 19426.356493454867, 19235.368641319732, 19345.037751257107, 19304.647722802234, 19338.367620235498, 19395.47751336837, 19325.749994852926, 19252.7182488222, 19280.690474449875, 19202.755865444997, 19350.334501131296, 19225.483589606276, 19223.734035640016, 19234.29096816081, 19248.997333072206, 19139.30435088603, 19142.694767392895, 19034.26720085647, 19034.30601534245, 19053.599421973064, 19051.31473685178, 19037.57059279476]),
////			  portfolio: nil)
////
////
////}
////struct Coins: Codable{
////	let coins: [CoinModel]
////}
////
////
////
////struct Sparkline_in_7d : Codable {
////	let price: [Double]
////}
//
//// Data Model for CoinCap
//
////   let CoinData = try? newJSONDecoder().decode(CoinData.self, from: jsonData)
//
//import Foundation
//
//	// MARK: - Welcome
//struct OldCoinData: Decodable {
//	let data: [CoinDetail]
//	let timestamp: Int
//
//	static let coinCapExample = OldCoinData(data: [CoinDetail(id: "bitcoin",
//														   rank: "1",
//														   symbol: "BTC",
//														   name: "Bitcoin",
//														   supply: "19193100.0000000000000000",
//														   maxSupply: "21000000.0000000000000000",
//														   marketCapUsd: "397888264525.5591083450053800",
//														   volumeUsd24Hr: "11007783003.0388538590720480",
//														   priceUsd: "20730.7972409646752398",
//														   changePercent24Hr: "0.0394813888297129",
//														   vwap24Hr: "20849.4764965301855711",
//														   explorer: "https://blockchain.info/")],
//										 timestamp: 1667102350328)
//
//}
//
//struct CoinDetail: Codable, Identifiable, Hashable {
//	let id, rank, symbol, name : String
//	let supply, maxSupply, marketCapUsd: String?
//	let volumeUsd24Hr, priceUsd: String
//	let changePercent24Hr, vwap24Hr, explorer: String?
//	var amount, price: Double?
//	var dateAndTime: Date?
//	var transactionNotes: String?
//
//
//		// coinDetail init data
//	static let coinDetailExample = CoinDetail(id: "bitcoin",
//											  rank: "1",
//											  symbol: "BTC",
//											  name: "Bitcoin",
//											  supply: "19193100.0000000000000000",
//											  maxSupply: "21000000.0000000000000000",
//											  marketCapUsd: "397888264525.5591083450053800",
//											  volumeUsd24Hr: "11007783003.0388538590720480",
//											  priceUsd: "20730.7972409646752398",
//											  changePercent24Hr: "0.0394813888297129",
//											  vwap24Hr: "20849.4764965301855711",
//											  explorer: "https://blockchain.info/")
//
//
//		// coinDetail init data for the new one
//	static let coinDetailExample2 = [CoinDetail(id: "bitcoin",
//											  rank: "1",
//											  symbol: "BTC",
//											  name: "Bitcoin",
//											  supply: "19193100.0000000000000000",
//											  maxSupply: "21000000.0000000000000000",
//											  marketCapUsd: "397888264525.5591083450053800",
//											  volumeUsd24Hr: "11007783003.0388538590720480",
//											  priceUsd: "20730.7972409646752398",
//											  changePercent24Hr: "0.0394813888297129",
//											  vwap24Hr: "20849.4764965301855711",
//											  explorer: "https://blockchain.info/")]
//
//	func updatePortfolioHodling(amount: Double, price: Double, dateAndTime: Date,  transactionNotes: String) -> CoinDetail {
//		return CoinDetail(id: id, rank: rank, symbol: symbol, name: name, supply: supply, maxSupply: maxSupply, marketCapUsd: marketCapUsd, volumeUsd24Hr: volumeUsd24Hr, priceUsd: priceUsd, changePercent24Hr: changePercent24Hr, vwap24Hr: vwap24Hr, explorer: explorer, amount: amount, price: price, dateAndTime: dateAndTime, transactionNotes: transactionNotes )
//
//
//	}
//
//}
//
//struct ImageForLogos {
//	var coinImage = "https://assets.coincap.io/assets/icons/"
//	var imageFormat = "@2x.png"
//
//}
//
//
// //example api call from coin cap
////{
////	"data": [
////		{
////			"id": "bitcoin",
////			"rank": "1",
////			"symbol": "BTC",
////			"name": "Bitcoin",
////			"supply": "19193100.0000000000000000",
////			"maxSupply": "21000000.0000000000000000",
////			"marketCapUsd": "397888264525.5591083450053800",
////			"volumeUsd24Hr": "11007783003.0388538590720480",
////			"priceUsd": "20730.7972409646752398",
////			"changePercent24Hr": "0.0394813888297129",
////			"vwap24Hr": "20849.4764965301855711",
////			"explorer": "https://blockchain.info/"
////		},
////		{
////			"id": "ethereum",
////			"rank": "2",
////			"symbol": "ETH",
////			"name": "Ethereum",
////			"supply": "122373863.4990000000000000",
////			"maxSupply": null,
////			"marketCapUsd": "198025458802.9149843174233529",
////			"volumeUsd24Hr": "6749941743.5403241765690747",
////			"priceUsd": "1618.2005956241888605",
////			"changePercent24Hr": "2.0353382464117480",
////			"vwap24Hr": "1616.8033722219912704",
////			"explorer": "https://etherscan.io/"
////		}],
////			"timestamp": 1667102350328
////}
