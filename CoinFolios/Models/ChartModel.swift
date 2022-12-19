//
//  ChartModel.swift
//  CoinFolios
//
//  Created by Jono Jono on 23/10/2022.
//


import Foundation
//MARK: - MasterChart
struct MasterChart: Codable {
	var masterChart: [ChartModel]
}


// MARK: - ChartModel
struct ChartModel: Codable {
	let data: [ChartDetail]
	let timestamp: Int
	}

// MARK: - ChartDetail
struct ChartDetail: Codable, Hashable {
	let open, high, low, close: String
	let volume: String
	let period: Double
}


