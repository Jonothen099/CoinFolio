//
//  CoinChartView.swift
//  CoinFolios
//
//  Created by Jono Jono on 3/11/2022.
//

import SwiftUI
import Charts

struct CoinChartView: View {
	@EnvironmentObject var mvm: MasterViewModel
	@State private var selectedDate: Date?
	@State private var proxOffSet: CGFloat?


	var currentChartSelection: Bool
	var min : Double
	var max : Double
	var first: Double
	var last: Double
	@State private var selectedPrice: ChartManager.ObjectWillChangePublisher?
	@State private var selectedElement: ChartDetail?
	
	let greenGradient = LinearGradient(colors: [.green.opacity(0.5),Color.themeColor.greenChartColor.opacity(0.01) ], startPoint: .top, endPoint: .bottom)
	let redGradient = LinearGradient(colors: [.red.opacity(0.5),Color.themeColor.redChartColor.opacity(0.01) ], startPoint: .top, endPoint: .bottom)
	
	
	var body: some View{

		 if mvm.isLoading{
			LoadingView(loadingTitle: "Loading", loadingFrameHeight: 300, loadingColor: Color.themeColor.greenThemeColor, loadingSize: 2)
		 } else if mvm.masterChart.isEmpty{
			 EmptyChartView()
		 }
		else{
			switch currentChartSelection{
				case false:
					candleChartView
					volumeBarChart

				case true:
					lineChartView
					volumeAreaChart
			}
		}
	}

	
}

extension CoinChartView {
	
	var candleChartView: some View {
		Chart{
			ForEach(mvm.masterChart, id: \.self) { chartData in
					//						let datew = unixConverter(unixTime: Double(chartData.period))
				let date = mvm.unixConverter(unixTime: chartData.period)
				RectangleMark(x: .value("Time", date),
							  yStart: .value("Low Price", chartData.low.convertTodouble()),
							  yEnd: .value("High Price", chartData.high.convertTodouble()), width: 1)
				.foregroundStyle(chartData.close.convertTodouble() < chartData.open.convertTodouble() ? Color.themeColor.redChartColor : Color.themeColor.greenChartColor)
				
				
				RectangleMark(x: .value("Time", date)
							  , yStart: .value("Open Price ", chartData.open.convertTodouble()),
							  yEnd: .value("Close Price", chartData.close.convertTodouble()), width: 6)
				.foregroundStyle(chartData.close.convertTodouble() < chartData.open.convertTodouble() ? Color.themeColor.redChartColor : Color.themeColor.greenChartColor)
			}
		}
		.frame(height: 300)
		.chartYScale(domain: min...max)
		.chartXAxis {
		}
		
		.chartOverlay { proxy in
			GeometryReader { geo in
				Rectangle().fill(.clear).contentShape(Rectangle())
					.gesture(
						SpatialTapGesture()
							.onEnded { value in
								let element = findElement(location: value.location, proxy: proxy, geometry: geo)
								if selectedElement?.period == element?.period {
										// If tapping the same element, clear the selection.
									selectedElement = nil
								} else {
									selectedElement = element
								}
							}
							.exclusively(
								before: DragGesture()
									.onChanged { value in
										selectedElement = findElement(location: value.location, proxy: proxy, geometry: geo)
										HapticFeedbackManager.instance.hapticImpact(style: .soft)
										
									}
							)
					)
			}
		}
		.chartBackground { proxy in
			ZStack(alignment: .topLeading) {
				GeometryReader { geo in
					if let selectedElement {
						let periodIntToDate = mvm.unixConverter(unixTime: Double(selectedElement.period))
						let closePriceToDouble = Double(selectedElement.close)
						let openPriceToDouble = Double(selectedElement.open)
						
						let dateInterval = Calendar.current.dateInterval(of: .hour, for: periodIntToDate)!
						let startPositionX1 = proxy.position(forX: dateInterval.start) ?? 0
						
						let lineX = startPositionX1 + geo[proxy.plotAreaFrame].origin.x
						let lineHeight = geo[proxy.plotAreaFrame].maxY
						let boxWidth: CGFloat = 100
						let boxOffset = Swift.max(0, Swift.min(geo.size.width - boxWidth, lineX - boxWidth / 2))
						
						
						Rectangle()
							.stroke(style: StrokeStyle(lineWidth: 1, dash: [3]))
							.foregroundStyle(Color.gray)
							.frame(width: 1, height: lineHeight)
							.position(x: lineX, y: lineHeight / 2)
						
						VStack(alignment: .center) {
							Text("\(periodIntToDate, format: .dateTime.year().month().day())")
								.font(.caption)
								.foregroundStyle(.secondary)
								//							Text("\(selectedElement.close, format: "f1%" )")
							Text(String(format: "$%.2f", closePriceToDouble!))
							
								.font(.caption)
								.foregroundColor(closePriceToDouble! > openPriceToDouble! ? .green :  .red)
						}
						.frame(width: boxWidth, alignment: .center)
						.background {
							ZStack {
								RoundedRectangle(cornerRadius: 8)
									.fill(.background)
								RoundedRectangle(cornerRadius: 8)
									.fill(.quaternary.opacity(0.1))
							}
							.padding(.horizontal, -8)
							.padding(.vertical, -4)
						}
						.offset(x: CGFloat(boxOffset))
					}
				}
			}
		}
		
		
	}
	var lineChartView: some View{
		Chart {
			ForEach(mvm.masterChart, id: \.self) { lineChart in
				let date = mvm.unixConverter(unixTime: Double(lineChart.period))
				
				let price = Double(lineChart.close)
				
				
				LineMark(x: .value("Date",date ),
						 y: .value("Price", price ?? 0.0))
					//.interpolationMethod(InterpolationMethod.catmullRom)
				.lineStyle(StrokeStyle(lineWidth: 1.5))
				.foregroundStyle(last > first ? Color.themeColor.greenChartColor : Color.themeColor.redChartColor)
				
				AreaMark(
					x: .value("date", date),
					yStart: .value("amount", lineChart.close.convertTodouble()),
					// get the max close value or adjust to your use case
					yEnd: .value("amountEnd", min)
				)
				.foregroundStyle(last > first ? greenGradient : redGradient)
			}
			
			if let selectedElement, let lineChart = mvm.masterChart.first(where: { $0.period.unixToDate() == selectedElement.period.unixToDate()})?.close.convertTodouble(){
				
				PointMark(x: .value("Time", selectedElement.period.unixToDate()),
						  y: .value("Price", lineChart))
				.symbolSize(CGSize(width: 10, height: 10))
				.foregroundStyle(.primary)
				
			}
			
			
		}
		.frame(height: 300)
		.chartYScale(domain: min...max)
		.chartXAxis {
			AxisMarks(position: .bottom) { _ in
				AxisGridLine()
				AxisTick()
			}
		}
			//		.chartOverlay{ proxy in
			//			GeometryReader{ g in
			//				Rectangle().fill(.clear).contentShape(Rectangle())
			//					.gesture(
			//						DragGesture(minimumDistance: 0)
			//							.onChanged{ value in
			//								let x = value.location.x - g[proxy.plotAreaFrame].origin.x
			//								if let date: Date = proxy.value(atX: x), let roundedHour = date.nearestHour(){
			//									self.selectedDate = roundedHour
			//								}
			//							}
			//							.onEnded{ value in
			//								self.selectedDate = nil
			//							}
			//
			//					)
			//			}
			//
			//		}
			//		.chartBackground{proxy in
			//			GeometryReader{ geo in
			//			if let selectedDate {
			//				let dateInterval = Calendar.current.dateInterval(of: .minute, for: selectedDate)!
			//				let startPositionX1 = proxy.position(forX: dateInterval.start) ?? 0
			//
			//				let lineX = startPositionX1 + geo[proxy.plotAreaFrame].origin.x
			//				let boxWidth: CGFloat = 100
			//				let boxOffSet = Swift.max(0, Swift.min(geo.size.width - boxWidth, lineX - boxWidth / 2))
			//
			//				ZStack(alignment: .topLeading) {
			//					VStack{
			//						Text("\(selectedDate , format: .dateTime.year().month().day())")
			//						let lineChart = mvm.masterChart.first(where: { $0.period.unixToDate() == selectedDate})?.close.convertTodouble()
			//						let lineIs = String(lineChart ?? 0.0)
			//						Text("\(lineIs)")
			//					}
			//					.background {
			//						ZStack {
			//							RoundedRectangle(cornerRadius: 8)
			//								.fill(.background)
			//							RoundedRectangle(cornerRadius: 8)
			//								.fill(.quaternary.opacity(0.7))
			//						}
			//						.padding(.horizontal, -8)
			//						.padding(.vertical, -4)
			//					}
			//					.offset(x: boxOffSet)
			//				}
			//			}
			//		}
			//
			//		}
		
		.chartOverlay { proxy in
			GeometryReader { geo in
				Rectangle().fill(.clear).contentShape(Rectangle())
					.gesture(
						DragGesture()
							.onEnded { value in
								selectedElement = nil
							}
						
							.onChanged { value in
								selectedElement = findElement(location: value.location, proxy: proxy, geometry: geo)
								HapticFeedbackManager.instance.hapticImpact(style: .light)
							}
						
					)
			}
		}
		.chartBackground { proxy in
			ZStack(alignment: .topLeading) {
				GeometryReader { geo in
					if let selectedElement {
						let periodIntToDate = mvm.unixConverter(unixTime: Double(selectedElement.period))
						let closePriceToDouble = Double(selectedElement.close)
						let openPriceToDouble = Double(selectedElement.open)
						
						let dateInterval = Calendar.current.dateInterval(of: .minute, for: periodIntToDate)!
						let startPositionX1 = proxy.position(forX: dateInterval.start) ?? 0
						
						let lineX = startPositionX1 + geo[proxy.plotAreaFrame].origin.x
						let lineHeight = geo[proxy.plotAreaFrame].maxY
						let boxWidth: CGFloat = 100
						let boxOffset = Swift.max(0, Swift.min(geo.size.width - boxWidth, lineX - boxWidth / 2))
						
						Rectangle()
							.stroke(style: StrokeStyle(lineWidth: 1, dash: [3]))
							.foregroundStyle(Color.gray)
							.frame(width: 1, height: lineHeight)
							.position(x: lineX, y: lineHeight / 2)
						
						VStack(alignment: .center) {
							Text("\(periodIntToDate, format: .dateTime.year().month().day().hour())")
								.font(.caption)
								.foregroundStyle(.secondary)
								//							Text("\(selectedElement.close, format: "f1%" )")
							Text(String(format: "$%.2f", closePriceToDouble!))
							
								.font(.caption)
								.foregroundColor(closePriceToDouble! > openPriceToDouble! ? .green :  .red)
						}
						.frame(width: boxWidth, alignment: .center)
						.background {
							ZStack {
								RoundedRectangle(cornerRadius: 8)
									.fill(.background)
								RoundedRectangle(cornerRadius: 8)
									.fill(.quaternary.opacity(0.1))
							}
							.padding(.horizontal, -8)
							.padding(.vertical, -4)
						}
						.offset(x: CGFloat(boxOffset))
					}
				}
			}
		}
		
		
		
	}
	var volumeBarChart: some View{
		Chart{
			ForEach(mvm.masterChart, id: \.self) { barData in
				let date = mvm.unixConverter(unixTime: barData.period)
				BarMark(x: .value("Time", date),
						y: .value("Volume", barData.volume.convertTodouble()), width: 8, height: 15)
				.foregroundStyle(Color.secondary.opacity(0.2))
			}
		}
		.frame(height: 30)
		.chartXAxis {
			AxisMarks(preset: .aligned) { _ in
				AxisValueLabel()
			}
		}
		.chartYAxis(.hidden)
		.offset(x: -45)
		
	}
	var volumeAreaChart: some View{
		Chart{
			ForEach(mvm.masterChart, id: \.self) { barData in
				let date = mvm.unixConverter(unixTime: barData.period)
				AreaMark(x: .value("Time", date),
						 y: .value("Volume", barData.volume.convertTodouble()))
				.foregroundStyle(Color.secondary.opacity(0.2))
			}
		}
		.frame(height: 45)
		.chartXAxis {
			AxisMarks(preset: .aligned) { _ in
				AxisValueLabel()
			}
		}
		.chartYAxis(.hidden)
		.offset(x: -45)
		
		
	}
	
	private func findElement(location: CGPoint, proxy: ChartProxy, geometry: GeometryProxy) -> ChartDetail? {
		
		let relativeXPosition = location.x - geometry[proxy.plotAreaFrame].origin.x
		if let date = proxy.value(atX: relativeXPosition) as Date? {
				// Find the closest date element.
			var minDistance: TimeInterval = .infinity
			var index: Int? = nil
			for priceDataindex in mvm.masterChart.indices {
				let nthSalesDataDistance = mvm.unixConverter(unixTime: Double(mvm.masterChart[priceDataindex].period)).distance(to: date)
				if abs(nthSalesDataDistance) < minDistance {
					minDistance = abs(nthSalesDataDistance)
					index = priceDataindex
				}
			}
			if let index {
				return mvm.masterChart[index]
			}
		}
		return nil
	}
	
	private func getBoxSizes(startX: CGFloat, lineX: CGFloat, boxWidth: CGFloat, geo: GeometryProxy) -> CGFloat{
		
		return Swift.max(0, Swift.min(geo.size.width - boxWidth, lineX - boxWidth / 2))
	}

}



struct CoinChartView_Previews: PreviewProvider {
    static var previews: some View {
		CoinChartView(currentChartSelection: true, min: 0.0, max: 0.0, first: 0.0, last: 0.0)
			.environmentObject(MasterViewModel())

    }
}


enum ChartType: String {
	case line = "chart.line.uptrend.xyaxis"
	case candle = "chart.bar.xaxis"
}

// chart type line or candle sf symbol
struct Images: View {
	let last: Double
	let first: Double
	var imageTitle: String
	var body: some View {
		Image(systemName: imageTitle)
			.resizable()
			.aspectRatio(contentMode: .fit)
			.frame(width:20,height:20)
			.padding(3)
			.foregroundStyle(last > first ? Color.themeColor.greenChartColor : Color.themeColor.redChartColor)

	}
	
}




