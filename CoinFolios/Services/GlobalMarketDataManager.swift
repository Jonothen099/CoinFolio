//
//  GlobalMarketDataManager.swift
//  CoinFolios
//
//  Created by Jono Jono on 7/12/2022.
//

import Foundation

protocol GlobalmarketDataService {
	
	func fetchGlobalData() async throws -> GlobalMarketData
		
}


class GlobalMarketDataNM {
	func fetchGlobalData() async throws -> GlobalMarketData {
		let plainUrl = "https://api.coingecko.com/api/v3/global"
		guard let url = URL(string: plainUrl) else {
			print("URL Error")
			fatalError()
		}
		
		do {
			let (data, _) = try await URLSession.shared.data(from: url)
			print("Global Data task done, decoding now")
			if let decodedData = try? JSONDecoder().decode(GlobalMarketData.self, from: data){
//				print("this is decoded Data\(decodedData)")
				return decodedData
			} else {
				throw URLError(.badURL)
			}
			
		} catch  {
			print(error)
			throw error
			
		}
		
		
		
		
	}

	
}
