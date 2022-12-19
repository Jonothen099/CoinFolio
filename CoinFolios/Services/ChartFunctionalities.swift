//
//  ChartFunctionalities.swift
//  CoinFolios
//
//  Created by Jono Jono on 3/11/2022.
//

import Foundation
// getting values make an array out of it and get the max, min, first/start and last/ending close price to minipulate the chart's color
struct NewChartIntervalStruct {
	var chartInterval: ChartIntervalData

	
		// for the new chart async let data
	func chartTypeSelected(isLineChart: Bool) -> Int{
		if isLineChart == false {
			switch chartInterval {
				case .the24H:
					return 3
				case .the7D:
					return 2
				case .the30D:
					return 1
				case .the90D:
					return 0
			}
			
		}
			// if candle
		else {
			switch chartInterval {
				case .the24H:
					return 7
				case .the7D:
					return 6
				case .the30D:
					return 5
				case .the90D:
					return 4
			}
		}
	}
	
	func maxValue(chartData: [ChartDetail]) -> Double{
		
		var highPricesArr = [Double]()
		
		for item in chartData {
				// getting max value
			let high = Double(item.high) ?? 0
			highPricesArr.append(high)
		}
		let hightoDouble = highPricesArr.max() ?? 0
		
			//		print("this is highTodouble: \(hightoDouble)")
		
		return hightoDouble
		
	}
	func minValue(chartData: [ChartDetail]) -> Double{
		
		var lowPricesArr = [Double]()
		
		for item in chartData {
				// getting max value
			let low = Double(item.low) ?? 0
			lowPricesArr.append(low)
		}
		let lowtoDouble = lowPricesArr.min() ?? 0
			//		print("this is highTodouble: \(hightoDouble)")
		return lowtoDouble
		
	}
	
	
// getting  Line Chart start and end price to figure the color out.
	func getFirstClose(chartData: [ChartDetail]) -> Double {
		
		var pricesArr = [Double]()
		
		for item in  chartData{
				// getting max value
			let priceClose = Double(item.close) ?? 0
			pricesArr.append(priceClose)
			
			
		}
		let closePrice = pricesArr.first ?? 0
			//		print(pricesArr)
		
		return closePrice
	}
	
	func getLastClose(chartData: [ChartDetail]) -> Double {
		var pricesArr = [Double]()
		
		for item in chartData {
				// getting max value
			let priceClose = Double(item.close) ?? 0
			pricesArr.append(priceClose)
			
			
		}
		let lastClosePrice = pricesArr.last ?? 0
			//		print(pricesArr)
		return lastClosePrice
		
	}
	
	
}

	
// enum for the Chart type segmented control
enum ChartIntervalData: String,  CaseIterable, Equatable {
		case the24H = "24h"
		case the7D = "7d"
		case the30D = "30d"
		case the90D = "6m"
	}



















