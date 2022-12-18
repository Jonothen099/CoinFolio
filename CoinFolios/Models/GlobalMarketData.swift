//
//  GlobalMarketData.swift
//  CoinFolios
//
//  Created by Jono Jono on 7/12/2022.
//

import Foundation


	// MARK: - Welcome
struct GlobalMarketData: Codable {
	let data: DataClass
}

	// MARK: - DataClass
struct DataClass: Codable {
	let activeCryptocurrencies, upcomingIcos, ongoingIcos, endedIcos: Int
	let markets: Int
	let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
	let marketCapChangePercentage24HUsd: Double
	let updatedAt: Int
	
	var marketCapTotal: String {
		if let marketCapValue = totalMarketCap.first(where: { $0.key == "usd"}){
			return "\(marketCapValue.value)"
		}
		return ""
	}
	
	var volumeTotal: String {
		if let volume = totalVolume.first(where: { $0.key == "usd"}){
			return "\(volume.value)"
		}
		return ""
	}
	
	enum CodingKeys: String, CodingKey {
		case activeCryptocurrencies = "active_cryptocurrencies"
		case upcomingIcos = "upcoming_icos"
		case ongoingIcos = "ongoing_icos"
		case endedIcos = "ended_icos"
		case markets
		case totalMarketCap = "total_market_cap"
		case totalVolume = "total_volume"
		case marketCapPercentage = "market_cap_percentage"
		case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
		case updatedAt = "updated_at"
		
	}
}


