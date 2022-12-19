//
//  ChartManager.swift
//  CoinFolios
//
//  Created by Jono Jono on 23/10/2022.
//

import Foundation


protocol ChartDataService {
	func fetchChartData() async throws -> ChartModel
	func getChartDataGroupTask(id: String) async  throws -> [ChartModel]
}


class ChartManager: ObservableObject {
	@Published var chartData: ChartModel
//	@Published var chartPrices: ChartPricesModel
	
	init(chartData: ChartModel){
		self.chartData = chartData
	}


//	func loadChartData(id: String, chartIntervalValue: String, selectedRange: Double) async{
//		await MainActor.run(body: {
//		loadingState = true
//		})
//
//		let startInUnix = Date.now.addingTimeInterval(selectedRange).timeIntervalSince1970*1000
//		let endingInUnix = Date.now.timeIntervalSince1970*1000
//		print("start: \(startInUnix)end: \(endingInUnix)")
//		let plainUrl = "https://api.coincap.io/v2/candles?exchange=binance&interval=\(chartIntervalValue)&baseId=\(id)&quoteId=tether&start=\(startInUnix)&end=\(endingInUnix)"
//		guard let url = URL(string: plainUrl) else{
//			print("Invalid URl")
//			return
//		}
//		do{
//			let (data, _) = try await URLSession.shared.data(from: url)
//			print("Data Task Done, now we need to decode for chart data")
//			if let decodedData = try? JSONDecoder().decode(ChartModel.self, from: data){
//				// run
//				await MainActor.run(body: {
//					chartData = decodedData
//					print(type(of: chartData))
//					print(chartData)
//
////					print(Thread.current)
////					print("this is thread priority \(Thread.current.threadPriority)")
//					loadingState = false
//				})
//
//			}
//		}catch{
//			print(error)
//			print(error.localizedDescription)
//		}
//	}
//
	func getChartDataGroupTask(id: String) async  throws -> [ChartModel]{
		
		let endingInUnix = Date.now.timeIntervalSince1970*1000
		let start = Date.now.addingTimeInterval(-15552000).timeIntervalSince1970*1000
		print("start: \(start) and ending: \(endingInUnix)")
		// candle
		async let the6MonthsCandle = fetchChartData(id: id, baseUrl: "https://api.coincap.io/v2/candles?exchange=binance&interval=w1&baseId=\(id)&quoteId=tether&start=\(Date.now.addingTimeInterval(-15552000).timeIntervalSince1970*1000)&end=\(endingInUnix)")
		async let the30DaysCandle = fetchChartData(id: id, baseUrl: "https://api.coincap.io/v2/candles?exchange=binance&interval=d1&baseId=\(id)&quoteId=tether&start=\(Date.now.addingTimeInterval(-2592000).timeIntervalSince1970*1000)&end=\(endingInUnix)")
		async let the7DaysCandle = fetchChartData(id: id, baseUrl: "https://api.coincap.io/v2/candles?exchange=binance&interval=h8&baseId=\(id)&quoteId=tether&start=\(Date.now.addingTimeInterval(-604800).timeIntervalSince1970*1000)&end=\(endingInUnix)")
		async let the24HoursCandle = fetchChartData(id: id, baseUrl: "https://api.coincap.io/v2/candles?exchange=binance&interval=h1&baseId=\(id)&quoteId=tether&start=\(Date.now.addingTimeInterval(-86400).timeIntervalSince1970*1000)&end=\(endingInUnix)")
		
		// line chart
		async let the6MonthsLine = fetchChartData(id: id, baseUrl: "https://api.coincap.io/v2/candles?exchange=binance&interval=h4&baseId=\(id)&quoteId=tether&start=\(Date.now.addingTimeInterval(-7776000).timeIntervalSince1970*1000)&end=\(endingInUnix)")
		async let the30DaysLine = fetchChartData(id: id, baseUrl: "https://api.coincap.io/v2/candles?exchange=binance&interval=h1&baseId=\(id)&quoteId=tether&start=\(Date.now.addingTimeInterval(-2592000).timeIntervalSince1970*1000)&end=\(endingInUnix)")
		async let the7DaysLine = fetchChartData(id: id, baseUrl: "https://api.coincap.io/v2/candles?exchange=binance&interval=m15&baseId=\(id)&quoteId=tether&start=\(Date.now.addingTimeInterval(-604800).timeIntervalSince1970*1000)&end=\(endingInUnix)")
		async let the24HoursLine = fetchChartData(id: id, baseUrl: "https://api.coincap.io/v2/candles?exchange=binance&interval=m5&baseId=\(id)&quoteId=tether&start=\(Date.now.addingTimeInterval(-86400).timeIntervalSince1970*1000)&end=\(endingInUnix)")
			// candle chart
		let(candleChart6M, candleChart30D, candleChart7D, candleChart24H) = await(try the6MonthsCandle, try the30DaysCandle, try the7DaysCandle, try the24HoursCandle)
			// line chart

		let(lineChart6M, lineChart30D, lineChart7D, lineChart24H) = await(try the6MonthsLine, try the30DaysLine, try the7DaysLine, try the24HoursLine)

		return [ candleChart6M, candleChart30D, candleChart7D, candleChart24H, lineChart6M, lineChart30D, lineChart7D, lineChart24H ]
		
		
	}
	
	func fetchChartData(id: String, baseUrl: String) async throws -> ChartModel{
		guard let url = URL(string: baseUrl) else{
			print("Invalid URl")
//			fatalError("Invalid Chart URL: \(NSURLErrorBadURL)")
			throw URLError(.badURL)
		}
		do {
			let (data, _) = try await URLSession.shared.data(from: url)
			print(url)

			print("Data Task Done, now we need to decode for chart data")
			if let decodedData = try? JSONDecoder().decode(ChartModel.self, from: data){
				return decodedData
			} else{
				throw URLError(.badURL)
			}
		} catch  {
			throw error
		}
			}


// convert unix to Date
	func unixConverter(unixTime: Double) -> Date {
		var stringDate = ""
		var strDate : Date
		let date = Date(timeIntervalSince1970: unixTime/1000)
		let dateFormatter = DateFormatter()
		let timezone = TimeZone.current.abbreviation() ?? "UTC"  // get current TimeZone abbreviation or set to CET
		dateFormatter.timeZone = TimeZone(abbreviation: timezone) //Set timezone that you want
		dateFormatter.locale = NSLocale.current
		dateFormatter.dateFormat = "YYYY MMM dd HH:mm" //Specify your format that you want
		stringDate = dateFormatter.string(from: date)
		strDate = dateFormatter.date(from: stringDate) ?? Date.now
		return strDate
	}
	
	
	
} // end of closing class bracket
