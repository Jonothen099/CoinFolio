//
//  ChartPricesModel.swift
//  CoinFolios
//
//  Created by Jono Jono on 28/10/2022.
//

import Foundation


struct ChartPricesModel{
	
	let open: Double
	let close: Double
	let high: Double
	let low: Double
	let volume: Double
	let period: Double
	 
	
	static let chartPricesExample = ChartPricesModel(open: 19204.29,
													close: 9164.37,
													high: 9250.00,
													low: 9250.00,
													volume: 62634.403,
													period: 666310400000)

	
}
