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


















		// computed variable that return string
		// the switch case if based on the user's selection of the segmented control
//	struct ChartIntervals {
//		var selectedInterval: ChartIntervalData
//			//	var timeline = "m1, m5, m15, m30, h1, h2, h4, h8, h12, d1, w1"
//
//		var selectedChartInterval: String {
//			switch selectedInterval {
//				case .the24H:
//					return "h1"
//				case .the7D:
//					return "h8"
//				case .the30D:
//					return "d1"
//				case .the90D:
//					return "w1"
//			}
//		}
//
//
//
//		func lineChartInterval(isLineChart: Bool) -> String{
//			if isLineChart == true {
//				switch selectedInterval {
//					case .the24H:
//						return "m5"
//					case .the7D:
//						return "m15"
//					case .the30D:
//						return "h1"
//					case .the90D:
//						return "h4"
//				}
//
//			} else {
//				switch selectedInterval {
//					case .the24H:
//						return "h1"
//					case .the7D:
//						return "h8"
//					case .the30D:
//						return "d1"
//					case .the90D:
//						return "w1"
//				}
//
//			}
//		}
//
//		func selectedRange(isLineChart: Bool)-> Double {
//			if isLineChart{
//				switch lineChartInterval(isLineChart: isLineChart){
//					case "m5":
//						return -86400
//					case "m15":
//						return -604800
//					case "h4":
//						return -7776000
//					default:
//						return -2592000
//				}
//			} else{
//				switch lineChartInterval(isLineChart: isLineChart){
//					case "w1":
//						return -15552000
//					case "h8":
//						return -604800
//					case "h1":
//						return -86400
//					default:
//						return -2592000
//				}
//
//			}
//		}
//
//	}
//		// testing using old async not MVVM
//
//		//
//		//  ChartFunctionalities.swift
//		//  CoinFolios
//		//
//		//  Created by Jono Jono on 3/11/2022.
//		//
//
//		// getting values make an array out of it and get the max, min, first/start and last/ending close price to minipulate the chart's color
//	struct ChartFunctionsOld {
//			// getting max and min values for Xaxis of the candle chart so that it could be dynamic
//			// getting max value from each chartdata
//		func maxYRange(coin: ChartModel) -> Double{
//			var highPricesArr = [Double]()
//
//			for item in coin.data {
//					// getting max value
//				let high = Double(item.high) ?? 0
//				highPricesArr.append(high)
//			}
//			let hightoDouble = highPricesArr.max() ?? 0
//
//				//		print("this is highTodouble: \(hightoDouble)")
//
//			return hightoDouble
//
//		}
//			// getting min value from each chartdata
//		func minYRange(coin: ChartModel) -> Double{
//			var lowPricesArr = [Double]()
//			for item in coin.data {
//					// getting min value
//				let low = Double(item.low) ?? 0
//				lowPricesArr.append(low)
//
//			}
//			let lowToDouble = lowPricesArr.min() ?? 0
//
//				//		print("this is lowTodouble: \(lowToDouble)")
//
//			return lowToDouble
//
//		}
//
//
//
//
//
//			// getting  Line Chart start and end price to figure the color out.
//		func getFirstClose(coin: ChartModel) -> Double {
//
//			var pricesArr = [Double]()
//
//			for item in coin.data {
//					// getting max value
//				let priceClose = Double(item.close) ?? 0
//				pricesArr.append(priceClose)
//
//
//			}
//			let closePrice = pricesArr.first ?? 0
//				//		print(pricesArr)
//
//			return closePrice
//		}
//
//		func getLastClose(coin: ChartModel) -> Double {
//			var pricesArr = [Double]()
//
//			for item in coin.data {
//					// getting max value
//				let priceClose = Double(item.close) ?? 0
//				pricesArr.append(priceClose)
//
//
//			}
//			let lastClosePrice = pricesArr.last ?? 0
//				//		print(pricesArr)
//			return lastClosePrice
//
//		}
//
//
//
//
//	}
//
//



