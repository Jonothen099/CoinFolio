////
////  CoinNetworkManager.swift
////  CoinFolios
////
////  Created by Jono Jono on 28/10/2022.
////
//
//import Foundation
//import SwiftUI
//
//class NetworkManager: ObservableObject {
//
//	@Published var coinModel = [CoinModel]()
//
//		// creating this func with keyword async which means device can sleep while
//		//it loads the data from the internet/aka networking
//		// to allows this to work, where this loadData func is called, we need to mark it as await whic is another keyword
//	func loadData() {
//			// the url to request data from
//		if let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=ah%2C24h%2C7d") {
//				// requesting data using URL session and dataTask, getting 3 parameters back, and put em in dat, response, error
//				// data is what the data we get back that we will be decoding and put em into our data object
//			let session = URLSession.shared
//			let task = session.dataTask(with: url){ data,response,error in
//					// if no error do this
//					// we will unwrap the optional data into unwrappedData and decode it using JSONDecoder
//				if error == nil{
//					print("task complete")
//					let decoder = JSONDecoder()
//					if let safeData = data {
//						do{
//
//								// decode the data from internet and store it into [CoinsData]constant results
//							let results = try decoder.decode([CoinModel].self, from: safeData)
//								//							print(results[0])
//							DispatchQueue.main.async {
//									// and pass the result to coinsData
//								self.coinModel = results
////								print(self.coinModel[0])
//							}
//						} catch {
//							print(error.localizedDescription)
//							print(error)
//						}
//					}
//
//				}
//
//			}
//			task.resume()
//
//
//		}
//
//
//	}
//}
//
//
