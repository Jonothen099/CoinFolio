//
//  ChartModel.swift
//  CoinFolios
//
//  Created by Jono Jono on 23/10/2022.
//

	//   let result = try? newJSONDecoder().decode(ChartModel.self, from: jsonData)

import Foundation
//MARK: - MasterChart
struct MasterChart: Codable {
	var masterChart: [ChartModel]
}


	// MARK: - ChartModel
struct ChartModel: Codable {
	let data: [ChartDetail]
	let timestamp: Int
	
	
	static let chartExample = ChartModel(data: [ChartDetail(
		open: "9128.7800000000000000",
		high: "9159.5500000000000000",
		low: "1911.7200000000000000",
		close: "19151.2200000000000000",
		volume: "4821.3840400000000000",
		period: 1666407600000)],
		timestamp: 1666498113801)
	
}

	// MARK: - ChartDetail
struct ChartDetail: Codable, Hashable {
	let open, high, low, close: String
	let volume: String
	let period: Double
}


