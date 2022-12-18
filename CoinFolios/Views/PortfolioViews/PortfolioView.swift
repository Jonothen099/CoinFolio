	//
	//  PortfolioView.swift
	//  CoinFolios
	//
	//  Created by Jono Jono on 3/11/2022.
	//

import SwiftUI
import Charts

struct PortfolioView: View {
	
	@EnvironmentObject var mvm: MasterViewModel
	@State var animationValue = 1.0
	@State private var showSelectionBar = false
	@State private var offsetX = 0.0
	@State private var offsetY = 0.0
	@State private var selectedAsset = ""
	@State private var selectedPrice: Double?
	


	
	var body: some View {
		ZStack{
			Color.themeColor.backgroundColor.ignoresSafeArea()
			
				ScrollView(showsIndicators: false){
					VStack{
						if !mvm.portfolioCoins.isEmpty{
							portfolioViews

						}
						else if mvm.isLoading{
							 LoadingView(loadingTitle: "Loading", loadingFrameHeight: 300, loadingColor: .red, loadingSize: 2)

						} else{
							EmptyPortfolioView()

						}

					}
					.task{
						mvm.portfolioService.getAllData()
						mvm.appendToHolding()
//
					}
					.navigationBarTitleDisplayMode(.inline)
					.navigationTitle("Portfolio")
//					.background(Color.themeColor.backgroundColor)
//					.scrollContentBackground(.hidden)
					
				}

			
			
		}
		.navigationViewStyle(StackNavigationViewStyle())
		.toolbar {
			ToolbarItem(placement: .navigationBarTrailing){
				NavigationLink(destination: PickAssetView()){
					Image(systemName:"plus.circle")
						.resizable()
						.frame(width: 20, height: 20)
						.foregroundColor(Color("AccentColor"))

				}
			}
		}

		
	}
}

struct PortfolioView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationStack{
			PortfolioView()
				.environmentObject(MasterViewModel())
		}
					
	}
}
extension PortfolioView{
	
//	private func findElement(location: CGPoint, proxy: ChartProxy, geometry: GeometryProxy) -> CoinData? {
//
//		let relativeXPosition = location.x - geometry[proxy.plotAreaFrame].origin.x
//		if let date = proxy.value(atX: relativeXPosition) as Date? {
//				// Find the closest date element.
//			var minDistance: TimeInterval = .infinity
//			var index: Int? = nil
//			for priceDataindex in mvm.coinData.indices {
////				let nthSalesDataDistance = mvm.unixConverter(unixTime: Double(mvm.coinData[priceDataindex].dateAndTime)).distance(to: date)
//				let nthSalesDataDistance = mvm.coinData[priceDataindex].dateAndTime?.distance(to: date)
//				if abs(nthSalesDataDistance ?? 0.0) < minDistance {
//					minDistance = abs(nthSalesDataDistance ?? 0.0)
//					index = priceDataindex
//				}
//			}
//			if let index {
//				return mvm.coinModel.data[index]
////				return mvm.masterChart[index]
//			}
//		}
//		return nil
//	}
	
	var portfolioHeadersLeft: some View {
		
		HStack{
			VStack(alignment: .leading){
				Text("Current Balance")
					.font(.title2.bold())

				Text(mvm.totalPortfolio.totalPortfolio.description.currencyFormatting())
					.font(.headline)
			}
			.padding()
			Spacer()
		}
	}
	
	var portfolioHeadersRight: some View {
		
		HStack{
			VStack(alignment: .trailing){
				
				Text("Profit & Loss")
					.font(.title2.bold())
					.padding(.bottom, -8)
			
				HStack {
//					Text(mvm.totalPortfolio.percentProfitLoss.asPercentage())
					PercentageNoBGView(priceChange: mvm.totalPortfolio.percentProfitLoss, priceChangeColor: mvm.totalPortfolio.percentProfitLoss.compareAndReturnColor(), priceChangePercentage: mvm.totalPortfolio.percentProfitLoss.asPercentage())
//						.offset(y: 20)
					let totalProfitOrLoss = mvm.totalPortfolio.totalPortfolio - mvm.totalPortfolio.totalBuyPrice
					Text(totalProfitOrLoss.description.currencyFormatting())
						.font(.headline)
//					ForEach(mvm.portfolioCoins, id: \.id) { item in
//						Text(item.profitLoss?.toJust2Decimals().currencyFormatting() ?? "N/A")
//							.font(.headline)
//
//					}

					
					
					
				}
				
			}
			.padding()
			
		}
	}
	
	private var portfolioViews: some View{
		VStack{
			VStack{
				HStack{
					portfolioHeadersLeft
					portfolioHeadersRight
				}
				
			}
			VStack{
				if mvm.portfolioCoins.isEmpty{
					
					EmptyChartView()
				}else{
					Chart{
						ForEach(mvm.portfolioCoins, id: \.id) { asset in
							BarMark(x: .value("time", asset.symbol),
									y: .value("Amount", asset.holdingCurrentValue ?? 0.0 ))
						}
					}
					.chartOverlay{ pr in
						GeometryReader{ geoProxy in
							Rectangle().foregroundStyle(Color.orange.gradient)
								.frame(width: 2, height: geoProxy.size.height * 0.95)
								.opacity(showSelectionBar ? 1.0 : 0.0)
								.offset(x: offsetX)
							
							
							Capsule()
								.foregroundStyle(.orange.gradient)
								.frame(width: 100, height: 50)
								.overlay {
									VStack {
										Text("\(selectedAsset)")
										Text(selectedPrice?.toJust2Decimals().currencyFormatting() ?? "n/a")
											.font(.title2)
									}
									.foregroundStyle(.white.gradient)
								}
								.opacity(showSelectionBar ? 1.0 : 0.0)
								.offset(x: offsetX - 50)
							
							
							Rectangle().fill(.clear).contentShape(Rectangle())
								.gesture(DragGesture().onChanged { value in
									if !showSelectionBar {
										showSelectionBar = true
									}
									let origin = geoProxy[pr.plotAreaFrame].origin
									let location = CGPoint(
										x: value.location.x - origin.x,
										y: value.location.y - origin.y
									)
									offsetX = location.x
									offsetY = location.y
									
									let (asset, _) = pr.value(at: location, as: (String, Int).self) ?? ("-", 0)
//									let price = mvm.coinData.map { $0.priceUsd.convertTodouble()}
									
									let price = mvm.portfolioCoins.first { $0.id == $0.id}?.price
									selectedAsset = asset
									selectedPrice = price
								}
									.onEnded({ _ in
										showSelectionBar = false
									}))
							
						}
					}
//					.chartOverlay{ proxy in
//						GeometryReader { geo in
//							Rectangle().fill(.clear).contentShape(Rectangle())
//								.gesture(
//									SpatialTapGesture()
//										.onEnded { value in
////											let element = findElement(location: value.location, proxy: proxy, geometry: geo)
//													// If tapping the same element, clear the selection.
//												selectedElement = nil
//
//										}
//										.exclusively(
//											before: DragGesture()
//												.onChanged { value in
//													selectedElement = findElement(location: value.location, proxy: proxy, geometry: geo)
//													HapticFeedbackManager.instance.hapticImpact(style: .soft)
//
//												}
//										)
//								)
//						}
//
//					}
//					.chartBackground { proxy in
//						ZStack(alignment: .topLeading) {
//							GeometryReader { geo in
//								if let selectedElement {
////									let periodIntToDate = mvm.unixConverter(unixTime: Double(selectedElement.period))
//									let periodIntToDate = selectedElement.dateAndTime ?? .now
//									let percentInPortfolio = ((selectedElement.holdingCurrentValue ?? 0.0)/mvm.totalPortfolio.totalPortfolio) * 100
//									let holdingValue = selectedElement.holdingCurrentValue
////									let closePriceToDouble = Double(selectedElement.close)
////									let openPriceToDouble = Double(selectedElement.open)
////
//									let dateInterval = Calendar.current.dateInterval(of: .hour, for: periodIntToDate )
//									let startPositionX1 = proxy.position(forX: dateInterval?.start ?? .now) ?? 0
//
//									let lineX = startPositionX1 + geo[proxy.plotAreaFrame].origin.x
//									let lineHeight = geo[proxy.plotAreaFrame].maxY
//									let boxWidth: CGFloat = 100
//									let boxOffset = Swift.max(0, Swift.min(geo.size.width - boxWidth, lineX - boxWidth / 2))
//
//
//									Rectangle()
//										.stroke(style: StrokeStyle(lineWidth: 1, dash: [3]))
//										.foregroundStyle(Color.gray)
//										.frame(width: 1, height: lineHeight)
//										.position(x: lineX, y: lineHeight / 2)
//
//									VStack(alignment: .center) {
//										Text("\(periodIntToDate, format: .dateTime.year().month().day())")
//											.font(.caption)
//											.foregroundStyle(.secondary)
//											//							Text("\(selectedElement.close, format: "f1%" )")
////										Text(String(format: "$%.2f", closePriceToDouble!))
//										Text(percentInPortfolio.asPercentage())
//										Text(holdingValue?.toJust2Decimals().currencyFormatting() ?? "")
//
//											.font(.caption)
//
//									}
//									.frame(width: boxWidth, alignment: .center)
//									.background {
//										ZStack {
//											RoundedRectangle(cornerRadius: 8)
//												.fill(.background)
//											RoundedRectangle(cornerRadius: 8)
//												.fill(.quaternary.opacity(0.1))
//										}
//										.padding(.horizontal, -8)
//										.padding(.vertical, -4)
//									}
//									.offset(x: CGFloat(boxOffset))
//								}
//							}
//						}
//					}
//
//
						//									Chart{
						//										ForEach(mvm.totalHoldings) { item in
						//											LineMark(x: .value("time", item.date),
						//													 y: .value("Amount", item.totalHolding ))
						//
						//										}
						//									}
						//								.chartYScale(domain: min...max)
					.frame(height: 300)
					.onChange(of: mvm.portfolioCoins ) { newValue in
						print("portfolio value changed to \(mvm.portfolioCoins)!")
							// do this when chart value changed
						mvm.portfolioService.getAllData()
						mvm.appendToHolding()
					}
					
					
				}
			}
			HStack{
				Text("Your Assets")
					.font(.title)
					.padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 0))
				Spacer()
				
			}
			Divider()
			List{
				ForEach(mvm.portfolioCoins, id: \.id) { asset in
					
					NavigationLink(destination: PortfolioDetailView(asset: asset)) {
						VStack{
							ElementPortfolioViews(asset: asset)
						}
					}
					

					
				}
				.onDelete(perform: { indexSet in
					indexSet.forEach { index in
						let asset = mvm.portfolioService.assetEntity[index]
						mvm.portfolioService.deleteSelectedData(asset: asset)
						mvm.portfolioService.applyChanges()
					}
				})
				.listRowInsets(.init(top: 15, leading: 10, bottom: 15, trailing: -20))
				.listRowBackground(Color.themeColor.backgroundColor)
				
			}
			.frame(height: 500)
			.listStyle(.plain)
			.background(Color.themeColor.backgroundColor)
			.environment(\.defaultMinListRowHeight, 20)
			
		}
		
		
	}
	
}
