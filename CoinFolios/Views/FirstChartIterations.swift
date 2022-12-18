//private var coinChart: some View {
//	Chart{
//		ForEach(chartManager.chartData.data, id: \.self) { chartData in
//			let date = chartManager.unixConverter(unixTime: Double(chartData.period))
//			let lowPrice = Double(chartData.low)
//			let highPrice = Double(chartData.high)
//			let openPrice = Double(chartData.open)
//			let closePrice = Double(chartData.close)
//			RectangleMark(x: .value("Time", date, unit: .hour),
//						  yStart: .value("Low Price", lowPrice!),
//						  yEnd: .value("High Price", highPrice!), width: 1)
//			.foregroundStyle(closePrice! < openPrice! ? .red : .green)
//
//			RectangleMark(x: .value("Time", date, unit: .hour),
//						  yStart: .value("Open Price", openPrice!),
//						  yEnd: .value("Close Price", closePrice!), width: 6)
//			.foregroundStyle(closePrice! < openPrice! ? Color("ChartRedColor") : Color("ChartGreenColor"))
//
//
//
//		}
//	}
//	.chartOverlay { proxy in
//		GeometryReader { geo in
//			Rectangle().fill(.clear).contentShape(Rectangle())
//				.gesture(
//					SpatialTapGesture()
//						.onEnded { value in
//							let element = findElement(location: value.location, proxy: proxy, geometry: geo)
//							if selectedElement?.period == element?.period {
//									// If tapping the same element, clear the selection.
//								selectedElement = nil
//							} else {
//								selectedElement = element
//							}
//						}
//						.exclusively(
//							before: DragGesture()
//								.onChanged { value in
//									selectedElement = findElement(location: value.location, proxy: proxy, geometry: geo)
//								}
//						)
//				)
//		}
//	}
//
//	.chartBackground { proxy in
//		ZStack(alignment: .topLeading) {
//			GeometryReader { geo in
//				if let selectedElement {
//					let periodIntToDate = chartManager.unixConverter(unixTime: Double(selectedElement.period))
//					let closePriceToDouble = Double(selectedElement.close)
//					let openPriceToDouble = Double(selectedElement.open)
//
//					let dateInterval = Calendar.current.dateInterval(of: .day, for: periodIntToDate)!
//					let startPositionX1 = proxy.position(forX: dateInterval.start) ?? 0
//
//					let lineX = startPositionX1 + geo[proxy.plotAreaFrame].origin.x
//					let lineHeight = geo[proxy.plotAreaFrame].maxY
//					let boxWidth: CGFloat = 100
//					let boxOffset = max(0, min(geo.size.width - boxWidth, lineX - boxWidth / 2))
//
//					Rectangle()
//						.foregroundStyle(Color.gray)
//						//							.fill(.red)
//						.frame(width: 2, height: lineHeight)
//						.position(x: lineX, y: lineHeight / 2)
//
//					VStack(alignment: .center) {
//						Text("\(periodIntToDate, format: .dateTime.year().month().day())")
//							.font(.caption)
//							.foregroundStyle(.secondary)
//							//							Text("\(selectedElement.close, format: "f1%" )")
//						Text(String(format: "$%.2f", closePriceToDouble!))
//
//							.font(.caption)
//							.foregroundColor(closePriceToDouble! > openPriceToDouble! ? .green :  .red)
//					}
//					.frame(width: boxWidth, alignment: .leading)
//					.background {
//						ZStack {
//							RoundedRectangle(cornerRadius: 8)
//								.fill(.background)
//							RoundedRectangle(cornerRadius: 8)
//								.fill(.quaternary.opacity(0.1))
//						}
//						.padding(.horizontal, -8)
//						.padding(.vertical, -4)
//					}
//					.offset(x: boxOffset)
//				}
//			}
//		}
//	}
//	.chartYScale(domain: minRangeValue...maxRangeValue)
//	.chartXAxis {
//		AxisMarks(position: .bottom) { _ in
//			AxisGridLine().foregroundStyle(.clear)
//			AxisTick().foregroundStyle(.clear)
//			AxisValueLabel()
//
//		}
//	}
//	.frame(height: 300)
//
//}
//
//private var coinLineChart: some View {
//	Chart {
//		ForEach(chartManager.chartData.data, id: \.self) { lineChart in
//			let date = chartManager.unixConverter(unixTime: Double(lineChart.period))
//			let price = Double(lineChart.close)
//			LineMark(x: .value("Date",date ),
//					 y: .value("Price", price!))
//				//				.interpolationMethod(InterpolationMethod.catmullRom)
//			.lineStyle(StrokeStyle(lineWidth: 1))
//
//
//		}
//	}
//	.frame(height: 300)
//	.chartXAxis {
//		AxisMarks(position: .bottom) { _ in
//			AxisGridLine().foregroundStyle(.clear)
//			AxisTick().foregroundStyle(.clear)
//			AxisValueLabel()
//
//		}
//	}
//	.chartYScale(domain: minRangeValue...maxRangeValue)
//
//
//}
//
//private func findElement(location: CGPoint, proxy: ChartProxy, geometry: GeometryProxy) -> ChartDetail? {
//
//	let relativeXPosition = location.x - geometry[proxy.plotAreaFrame].origin.x
//	if let date = proxy.value(atX: relativeXPosition) as Date? {
//			// Find the closest date element.
//		var minDistance: TimeInterval = .infinity
//		var index: Int? = nil
//		for priceDataindex in chartManager.chartData.data.indices {
//			let nthSalesDataDistance = chartManager.unixConverter(unixTime: Double(chartManager.chartData.data[priceDataindex].period)).distance(to: date)
//			if abs(nthSalesDataDistance) < minDistance {
//				minDistance = abs(nthSalesDataDistance)
//				index = priceDataindex
//			}
//		}
//		if let index {
//			return chartManager.chartData.data[index]
//		}
//	}
//	return nil
//}
//}
