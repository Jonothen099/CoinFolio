	//
	//  CoinCapTesting.swift
	//  CoinFolios
	//
	//  Created by Jono Jono on 30/10/2022.
	//


import SwiftUI

struct CoinListView: View {
//	@EnvironmentObject var coinData: CoinDataNetworkManager
	@EnvironmentObject var mvm: MasterViewModel
	
//	@State private var tabBar: UITabBar! = nil
	
	var body: some View {
		NavigationView{

			VStack {
				globalStatsViews
				
				// filter buttons element
				FilteredButtons()
					if mvm.coinModel.data.isEmpty {
						VStack(spacing: 300) {
							ProgressView()
							Text("Loading Coin Data")
						}
					} else {
						
						List(mvm.coinData, id: \.id){ coin in
//							ZStack(alignment: .leading) {
									// by adding ZStack
									// and putting nav link inside the ZStack and add EmptyView() and add 0.0 opacity to the navlink will hide the closure indicator
							NavigationLink(destination: DetailView(coinModels: coin, maxRangeValue: 0, minRangeValue: 0,firstPrice: 0, lastPrice: 0, chartsTypes: CoinChartView(currentChartSelection: true, min: 0.0, max: 0.0, first: 0.0, last: 0.0))){
								CoinRowView(coin: coin)

							}
//								{
//									EmptyView()
//										.frame(width: 0)
//								}.opacity(0.0)
								
								// coin row view

//							}
							.listRowInsets(.init(top: 8, leading: 15, bottom: 10, trailing: -20))
							//list line separator color
							.listRowSeparatorTint(Color.themeColor.FaintLineColor)
							// list row height
							.frame(height: 40)
							// changing color of the each row
							.listRowBackground(Color.themeColor.backgroundColor)
						}
						.listStyle(.plain)
						// this and the frame above this will change the height of each row in the list
						.environment(\.defaultMinListRowHeight, 20)
	
					}
				
				

			}
				// changing color of the bg
			.background(Color.themeColor.backgroundColor)
			.scrollContentBackground(.hidden)
//			.navigationTitle("Market")
			.toolbar {
									ToolbarItem(placement: .navigation) {
											// this sets the screen title in the navigation bar, when the screen is visible
										Text("Market")
											.font(.title .bold())

									}


			}
			
		}
		.navigationViewStyle(StackNavigationViewStyle())
		.task {
			await mvm.getCoins()
			await mvm.getGlobalData()
		}
			// when pull down from list
			// it will refresh the list view from api call
		.refreshable {
			await mvm.getCoins()
			await mvm.getGlobalData()

		}
	}
}

struct CoinListView_Previews: PreviewProvider {
	static var previews: some View {
		CoinListView()
			.environmentObject(MasterViewModel())
			//			.environmentObject(CoinDataNetworkManager(coinData: CoinData.coinCapExample))
		
	}
}


extension CoinListView{
	private var rectangleGlobalStat: some View {
		RoundedRectangle(cornerRadius: 20)
			.frame(width: 150, height: 60)
			.foregroundColor(Color.themeColor.backgroundColor.opacity(0.9))
			.shadow(color: Color.themeColor.greenThemeColor.opacity(0.1), radius: 10)
			.padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 15))
	}
	
	private var globalStatsViews: some View {
		HStack{
			ScrollView(.horizontal,showsIndicators: false) {
				
				HStack{
					ZStack{
						rectangleGlobalStat
						
						VStack(alignment: .leading){
							Text("Total Market Cap")
								.font(.caption2.bold().smallCaps())
								.foregroundColor(.secondary)
							HStack{
								Text("$\(mvm.globalMarketDataModel.data.marketCapTotal.abbreviated)")
									.font(.subheadline.bold())
									.padding(.trailing)
								PercentageNoBGView(priceChange: mvm.globalMarketDataModel.data.marketCapChangePercentage24HUsd, priceChangeColor: mvm.globalMarketDataModel.data.marketCapChangePercentage24HUsd > 0 ? Color.themeColor.greenChartColor : Color.themeColor.redChartColor, priceChangePercentage: "\(mvm.globalMarketDataModel.data.marketCapChangePercentage24HUsd.asPercentage())")
									.background(.opacity(0))
							}
						}
						
					}
					ZStack{
						rectangleGlobalStat
						VStack(alignment: .leading){
							Text("Total 24H Volume")
								.font(.caption2.bold().smallCaps())
								.foregroundColor(.secondary)
								.padding(.bottom, 1)
							
							HStack{
								Text("$\(mvm.globalMarketDataModel.data.volumeTotal.abbreviated)")
									.font(.subheadline.bold())
									.padding(.trailing)
								
							}
						}
						.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 22))
						
						
					}
					
					ZStack{
						rectangleGlobalStat
						VStack(alignment: .leading){
							Text("Total Active Coins")
								.font(.caption2.bold().smallCaps())
								.foregroundColor(.secondary)
								.padding(.bottom, 1)
							HStack{
								Text("\(mvm.globalMarketDataModel.data.activeCryptocurrencies)")
									.font(.subheadline.bold())
									.padding(.trailing)
								
							}
						}
						.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 22))
						
						
						
					}
				}
				
				
				
			}
		}
		.frame(maxHeight: 65)
		
		
	}
	
}

struct GlobalStatsView: View {
	var statTitle: String
	var statValue: String
	
	var body: some View {
		VStack(alignment: .leading){
			Text(statTitle)
				.font(.caption2.bold().smallCaps())
				.foregroundColor(.secondary)
			
			Text("\(statValue)")
				.font(.subheadline.bold())
				.padding(.trailing)
			
			
			
			
			
		}
		
	}
}
