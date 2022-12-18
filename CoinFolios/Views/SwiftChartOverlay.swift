	//
	//  SwiftChartOverlay.swift
	//  CoinFolios
	//
	//  Created by Jono Jono on 25/10/2022.
	//

import SwiftUI
import Charts

struct SwiftChartOverlay: View {
	@State var selectedDate: Date
	@State var selectedPrice: Double
	
	@State private var selectedElement: Sale? = SalesData.data[10]
	var data = SalesData.data
	
	
	
	var body: some View {
		List {
			Section {
				chart
			}
			
			Section {
				Text("**Hold and drag** over the chart to view and move the lollipop")
					.font(.callout)
			}
		}
	}
	
	private var chart: some View {
		Chart {
			ForEach(data, id: \.day) {
				LineMark(
					x: .value("Month", $0.day, unit: .day),
					y: .value("Sales", $0.sales)
				)
					//				.interpolationMethod(.catmullRom)
				AreaMark(
					x: .value("Month", $0.day, unit: .day),
					y: .value("Sales", $0.sales)
				)
				.foregroundStyle(.linearGradient(colors: [Color.green, Color.green.opacity(0.1)],startPoint: .top,
												 endPoint: .bottom))
				if $0.sales == 0  {
					RuleMark(y: .value("Zero revenue", 0))
						.annotation(position: .overlay, alignment: .center) {
							Text("No revenue this period")
								.font(.footnote)
								.padding()
								.background(Color(UIColor.systemBackground))
						}
				}
			}
				//			if let selectedDate = selectedDate {
				//				RuleMark(x: .value("Selected Date", selectedDate))
				//					.foregroundStyle(.red)
				//				if let selectedPrice = selectedPrice {
				//					PointMark(x: .value("selected Date", selectedDate),
				//							  y: .value("selected Price", selectedPrice))
				//					.foregroundStyle(.purple)
				//				}
				//			}
			
		}
		.frame(height: 300)
		.chartOverlay { proxy in
			GeometryReader { geo in
				Rectangle().fill(.clear).contentShape(Rectangle())
					.gesture(
						SpatialTapGesture()
							.onEnded { value in
								let element = findElement(location: value.location, proxy: proxy, geometry: geo)
								if selectedElement?.day == element?.day {
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
									}
							)
					)
			}
		}
		
		.chartBackground { proxy in
			ZStack(alignment: .topLeading) {
				GeometryReader { geo in
					if let selectedElement {
						let dateInterval = Calendar.current.dateInterval(of: .day, for: selectedElement.day)!
						let startPositionX1 = proxy.position(forX: dateInterval.start) ?? 0
						
						let lineX = startPositionX1 + geo[proxy.plotAreaFrame].origin.x
						let lineHeight = geo[proxy.plotAreaFrame].maxY
						let boxWidth: CGFloat = 100
						let boxOffset = max(0, min(geo.size.width - boxWidth, lineX - boxWidth / 2))
						
						Rectangle()
							.fill(.red)
							.frame(width: 2, height: lineHeight)
							.position(x: lineX, y: lineHeight / 2)
						
						VStack(alignment: .center) {
							Text("\(selectedElement.day, format: .dateTime.year().month().day())")
								.font(.callout)
								.foregroundStyle(.secondary)
							Text("\(selectedElement.sales, format: .number)")
								.font(.title2.bold())
								.foregroundColor(.primary)
						}
						.accessibilityElement(children: .combine)
						.frame(width: boxWidth, alignment: .leading)
							//						.background {
							//							ZStack {
							//								RoundedRectangle(cornerRadius: 8)
							//									.fill(.background)
							//								RoundedRectangle(cornerRadius: 8)
							//									.fill(.quaternary.opacity(0.7))
							//							}
							//							.padding(.horizontal, -8)
							//							.padding(.vertical, -4)
							//						}
						.offset(x: boxOffset)
					}
				}
			}
		}
		
		
	}
	
	private func findElement(location: CGPoint, proxy: ChartProxy, geometry: GeometryProxy) -> Sale? {
		let relativeXPosition = location.x - geometry[proxy.plotAreaFrame].origin.x
		if let date = proxy.value(atX: relativeXPosition) as Date? {
				// Find the closest date element.
			var minDistance: TimeInterval = .infinity
			var index: Int? = nil
			for salesDataIndex in data.indices {
				let nthSalesDataDistance = data[salesDataIndex].day.distance(to: date)
				if abs(nthSalesDataDistance) < minDistance {
					minDistance = abs(nthSalesDataDistance)
					index = salesDataIndex
				}
			}
			if let index {
				return data[index]
			}
		}
		return nil
	}
	
	
		//		.chartOverlay { proxy in
		//			GeometryReader { geometry in
		//				Rectangle().fill(.clear).contentShape(Rectangle())
		//					.gesture(
		//						DragGesture()
		//						.onChanged { value in
		//								// Convert the gesture location to the coordinate space of the plot area.
		//							let origin = geometry[proxy.plotAreaFrame].origin
		//							let location = CGPoint(
		//								x: value.location.x - origin.x,
		//								y: value.location.y - origin.y
		//							)
		//								// Get the x (date) and y (price) value from the location.
		//							if let (date, price) = proxy.value(at: location, as: (Date, Double).self) {
		//								let calendar = Calendar.current
		//								let hour = calendar.component(.month, from: date)
		////								print(hour)
		////								print(price)
		//								if let currentItem = data.first(where: { item in
		//									calendar.component(.day, from: item.day) == hour
		//								}){
		//									print(currentItem.sales)
		//								}
		//
		//
		//								selectedDate = date
		//								selectedPrice = price
		//
		////								print("Location: \(date), price: \(price)")
		//
		//							}
		//						}
		//					)
		//			}
		//		}
	
	enum SalesData {
		static let data = [
			(day: date(year: 2022, month: 5, day: 8), sales: 168),
			(day: date(year: 2022, month: 5, day: 9), sales: 117),
			(day: date(year: 2022, month: 5, day: 10), sales: 106),
			(day: date(year: 2022, month: 5, day: 11), sales: 119),
			(day: date(year: 2022, month: 5, day: 12), sales: 109),
			(day: date(year: 2022, month: 5, day: 13), sales: 104),
			(day: date(year: 2022, month: 5, day: 14), sales: 196),
			(day: date(year: 2022, month: 5, day: 15), sales: 172),
			(day: date(year: 2022, month: 5, day: 16), sales: 122),
			(day: date(year: 2022, month: 5, day: 17), sales: 115),
			(day: date(year: 2022, month: 5, day: 18), sales: 138),
			(day: date(year: 2022, month: 5, day: 19), sales: 110),
			(day: date(year: 2022, month: 5, day: 20), sales: 106),
			(day: date(year: 2022, month: 5, day: 21), sales: 187),
			(day: date(year: 2022, month: 5, day: 22), sales: 187),
			(day: date(year: 2022, month: 5, day: 23), sales: 119),
			(day: date(year: 2022, month: 5, day: 24), sales: 160),
			(day: date(year: 2022, month: 5, day: 25), sales: 144),
			(day: date(year: 2022, month: 5, day: 26), sales: 152),
			(day: date(year: 2022, month: 5, day: 27), sales: 148),
			(day: date(year: 2022, month: 5, day: 28), sales: 240),
			(day: date(year: 2022, month: 5, day: 29), sales: 242),
			(day: date(year: 2022, month: 5, day: 30), sales: 173),
			(day: date(year: 2022, month: 5, day: 31), sales: 143),
			(day: date(year: 2022, month: 6, day: 1), sales: 137),
			(day: date(year: 2022, month: 6, day: 2), sales: 123),
			(day: date(year: 2022, month: 6, day: 3), sales: 146),
			(day: date(year: 2022, month: 6, day: 4), sales: 214),
			(day: date(year: 2022, month: 6, day: 5), sales: 250),
			(day: date(year: 2022, month: 6, day: 6), sales: 146)
		].map { Sale(day: $0.day, sales: $0.sales)}
	}
}

struct Sale {
	let day: Date
	var sales: Int
}
func date(year: Int, month: Int, day: Int = 1) -> Date {
	Calendar.current.date(from: DateComponents(year: year, month: month, day: day)) ?? Date()
}
struct SwiftChartOverlay_Previews: PreviewProvider {
	static var previews: some View {
		SwiftChartOverlay(selectedDate: Date.now, selectedPrice: 69.9)
	}
}
