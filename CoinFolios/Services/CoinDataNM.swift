	//
	//  CoinDataNM.swift
	//  CoinFolios
	//
	//  Created by Jono Jono on 13/11/2022.
	//

import Foundation

protocol CoinDataService {
	func fetchCoinData() async throws -> CoinModel
}


class CoinDataNM {
	
	
	func fetchCoinData() async throws -> CoinModel  {
		let plainUrl = "https://api.coincap.io/v2/assets"
		guard let url = URL(string: plainUrl) else{
			print("URL Error")
			print(URLError.Code.self)
			fatalError("Invalid URL")
		}
		
		let (data, _) = try await URLSession.shared.data(from: url)
		print("Data Task Done, now we need to decode")
		let decoded = try! JSONDecoder().decode(CoinModel.self, from: data)
		return decoded
		
	}
	
	
	
}



