//	//
//	//  CoinChart.swift
//	//  CoinFolios
//	//
//	//  Created by Jono Jono on 23/10/2022.
//	//
//
//import SwiftUI
//import Charts
//struct FirstChartView: View {
//	@ObservedObject var chartManager: ChartManager
//
//	var body: some View {
//
////		VStack {
//			Chart{
//				ForEach(chartManager.chartData.data, id: \.self) { chartData in
//					let date = chartManager.unixConverter(unixTime: Double(chartData.period))
//					let lowPrice = Double(chartData.low)
//					let highPrice = Double(chartData.high)
//					let openPrice = Double(chartData.open)
//					let closePrice = Double(chartData.close)
//					RectangleMark(x: .value("Time", date, unit: .hour),
//								  yStart: .value("Low Price", lowPrice!),
//								  yEnd: .value("High Price", highPrice!), width: 1)
//					.foregroundStyle(closePrice! < openPrice! ? .red : .green)
//
//					RectangleMark(x: .value("Time", date, unit: .hour),
//								  yStart: .value("Open Price", openPrice!),
//								  yEnd: .value("Close Price", closePrice!), width: 6)
//					.foregroundStyle(closePrice! < openPrice! ? .red : .green)
//
//				}
//			}
////			.chartYScale(domain: 18000...21000)
//			.chartXAxis {
//				AxisMarks(position: .bottom) { _ in
//					AxisGridLine().foregroundStyle(.clear)
//					AxisTick().foregroundStyle(.clear)
//					AxisValueLabel()
//
//				}
//			}
//
//			.frame(height: 300)
//
//			Text(String(chartManager.chartData.data.count))
//			List{
//				ForEach(chartManager.chartData.data, id: \.self) { content in
//					let dates = Date(timeIntervalSince1970: Double(content.period))
//					Text(dates, format: .dateTime.day().month().year())
//					Text(Date.now, format: .dateTime.day().month().year())
//
//				}
//
//			}
//
//		}
//		.task {
////			await chartManager.loadChartData(id: chartManager.chartData.data.id)
//		}
//	}
//}
//
//struct CoinChart_Previews: PreviewProvider {
//	static var previews: some View {
//		FirstChartView(chartManager: ChartManager(chartData: ChartModel.chartExample, chartPrices: ChartPricesModel.chartPricesExample))
//	}
//}
