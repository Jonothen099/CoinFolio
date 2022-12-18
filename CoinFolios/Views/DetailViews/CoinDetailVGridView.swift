	//
	//  TestingNVbackbutton.swift
	//  CoinFolios
	//
	//  Created by Jono Jono on 4/11/2022.
	//

import SwiftUI

struct CoinDetailVGridView: View {
	let coin: CoinData
	
	let columns = [
		GridItem(.flexible()),
		GridItem(.flexible()),
	]
	private let spacing: CGFloat = 30
	let nA = "N/A"
	
	
	var body: some View {
		
		ScrollView {
			VStack{
					VStack{
						SectionTitle(titleValue: "Market Data Overview")
						Divider()
						
						LazyVGrid(columns: columns,
								  alignment: .leading,
								  spacing: spacing,
								  pinnedViews: []) {
							EachVgridView(title: "Market Cap" , value: "$\(coin.marketCapUsd?.abbreviated ?? nA)" )
							EachVgridView(title: "Rank", value: "#\(coin.rank)")
							EachVgridView(title: "Volume(24h)", value: "$\(coin.volumeUsd24Hr.abbreviated)")
							EachVgridView(title: "Circulating Supply",value: "$\(coin.supply?.abbreviated ?? nA)")
							
							
							
						}
								  .padding(.horizontal)
						
					}
					VStack{
						SectionTitle(titleValue: "Asset Details")
						Divider()
						LazyVGrid(columns: columns,
								  alignment: .leading,
								  spacing: spacing,
								  pinnedViews: []) {
							EachVgridView(title: "Average Price(Volume Weighted)" , value: "$\(coin.vwap24Hr?.abbreviated ?? nA)")
							EachVgridView(title: "Maximum Supply", value: "$\(coin.maxSupply?.currencyFormatting() ?? nA)")
							VStack{
								
								Text("Assest Blockchain info")
									.font(.caption)
									.foregroundColor(.gray)
									.frame(maxWidth: .infinity, alignment: .leading)
									.padding(.bottom, 1)
								Link("Visit Blockchain explorer", destination: URL(string: coin.explorer ?? nA)!)
									.lineLimit(1)
									.font(.subheadline)
									.frame(maxWidth: .infinity, alignment: .leading)
									.foregroundColor(.blue)
								
								
								
							}

						}
								  .padding(.horizontal)
						
					}
			}
		}
			
		
		
	}
}



struct CoinDetailVGridView_Previews: PreviewProvider {
	static var previews: some View {
		CoinDetailVGridView(coin: DummyPreview.instance.justDetail)
//			.environmentObject(CoinDataNetworkManager(coinData: CoinData.coinCapExample))
		
	}
}



struct EachVgridView: View {
	let title: String
	let value: String
	var body: some View {
		VStack{
			Text(title)
				.font(.caption)
				.foregroundColor(.gray)
				.frame(maxWidth: .infinity, alignment: .leading)
				.padding(.bottom, 1)
			
			Text(value)
				.font(.headline)
				.frame(maxWidth: .infinity, alignment: .leading)
		}
	}
}




struct SectionTitle: View {
	var titleValue: String
	var body: some View {
		Text(titleValue)
			.font(.title).bold()
			.foregroundColor(Color("AccentColor"))
			.frame(maxWidth: .infinity, alignment: .leading)
			.padding()
	}
}
