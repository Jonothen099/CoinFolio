	//
	//  CoinChart.swift
	//  CoinFolios
	//
	//  Created by Jono Jono on 23/10/2022.
	//

import SwiftUI
import Charts
struct DetailView: View {
	@EnvironmentObject var mvm: MasterViewModel
	// this will grab the coinData from Contentview when using the navlink where this View will be called and asked to pass in coinModel so we can use the data here
	//	let coinModel: CoinModel
	let coinModels: CoinData
	// these 2 for the geo reader to tap on chart
	@State private var selectedPrice: ChartManager.ObjectWillChangePublisher?
	@State private var selectedElement: ChartDetail?
	// this one for YAxis range
	@State var maxRangeValue: Double
	@State var minRangeValue: Double
	@State var firstPrice: Double
	@State var lastPrice: Double

	let chartsTypes: CoinChartView
	
	func task(){
			mvm.masterChartValue()
			maxRangeValue = NewChartIntervalStruct(chartInterval: mvm.chartInterval).maxValue(chartData: mvm.masterChart)
			minRangeValue = NewChartIntervalStruct(chartInterval: mvm.chartInterval).minValue(chartData: mvm.masterChart)
			firstPrice = NewChartIntervalStruct(chartInterval: mvm.chartInterval).getFirstClose(chartData: mvm.masterChart)
			lastPrice = NewChartIntervalStruct(chartInterval: mvm.chartInterval).getLastClose(chartData: mvm.masterChart)
		
	}
	var body: some View {
		ScrollView(showsIndicators: false){
			VStack {
				VStack{
					
					HStack{
						Text(coinModels.priceUsd.currencyFormatting())
							.frame(maxWidth: 400, alignment: .leading)
							.lineLimit(1)
							.font(.title).bold()
							.padding(.leading, 20)
						VStack(alignment: .leading){
							Text("24h change")
								.frame(width: 120, alignment: .leading)
								.font(.subheadline)
							
							PercentageChangeView(priceChange: coinModels.changePercent24Hr?.convertTodouble(), priceChangeColor: coinModels.changePercent24Hr?.convertTodouble().compareAndReturnColor() ?? .red, priceChangePercentage: coinModels.changePercent24Hr?.convertTodouble().asPercentage() ?? "")
								.padding(.leading, 10)
						}.frame(width: 70, alignment: .leading)
							.padding(.trailing, 30)
					}
					
					HStack {
						Picker("", selection: $mvm.chartInterval) {
							ForEach(ChartIntervalData.allCases, id: \.self) {
								Text($0.rawValue)
							}
						}
						.pickerStyle(.segmented)
						.padding(.leading)
						VStack{
							Button{
								print("switch chart type")
								withAnimation {
									mvm.chartTypeIsTap.toggle()
								}
							} label: {
								switch mvm.chartTypeIsTap{
									case true:
										Images(last: lastPrice, first: firstPrice, imageTitle: ChartType.candle.rawValue)
									case false:
										Images(last: lastPrice, first: firstPrice, imageTitle: ChartType.line.rawValue)
								}
							}
						}.frame(width: 60, height: 31)
							.background(.gray.opacity(0.2))
							.cornerRadius(8)
							.padding(.trailing, 15)
					}

				}
				VStack{
						CoinChartView(currentChartSelection: mvm.chartTypeIsTap, min: minRangeValue, max: maxRangeValue, first: firstPrice, last: lastPrice)
					
				}
			
										
					VStack{
						CoinDetailVGridView(coin: coinModels)
					}.padding(.top, 10)
					
				.onChange(of: mvm.chartInterval) { newValue in
//					print("Name changed to \(mvm.chartInterval)!")
					// do this when currentChartTab value changed
					task()
				}
				.onChange(of: mvm.chartTypeIsTap) { newValue in
					task()
//					print("Changed chart type")
				}
			}
		}
		.navigationTitle(coinModels.name)
		.navigationBarTitleDisplayMode(.inline)
		.background(Color.themeColor.backgroundColor)
		.scrollContentBackground(.hidden)
		// this will hide the TabBar, attach this to anyview you do not wish to see the tabBar
		.toolbar(.hidden, for: .tabBar)
		.toolbar {
			ToolbarItem(placement: .navigationBarTrailing){
				HStack{
					Text(coinModels.symbol)
						.font(.subheadline)
						// coin icon
					CoinLogoView(coin: coinModels)
				}
				
			}
			
		}
		.task {
			await mvm.getChartData(id: coinModels.id)
//			maxRangeValue = NewChartIntervalStruct(chartInterval: mvm.chartInterval).maxValue(chartData: mvm.masterChart)
//			minRangeValue = NewChartIntervalStruct(chartInterval: mvm.chartInterval).minValue(chartData: mvm.masterChart)
//			print("max:\(maxRangeValue) min: \(minRangeValue)")
//			firstPrice = NewChartIntervalStruct(chartInterval: mvm.chartInterval).getFirstClose(chartData: mvm.masterChart)
//			lastPrice = NewChartIntervalStruct(chartInterval: mvm.chartInterval).getLastClose(chartData: mvm.masterChart)
//			print("first:\(firstPrice) last: \(lastPrice)")
			task()
		}
			
	}
}



struct DetailView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			DetailView(coinModels: DummyPreview.instance.justDetail , maxRangeValue: 0, minRangeValue: 0, firstPrice: 0, lastPrice: 0, chartsTypes: CoinChartView(currentChartSelection: true, min: 0.0, max: 0.0, first: 0.0, last: 0.0))
				.environmentObject(MasterViewModel())

			
		}
	}
}



