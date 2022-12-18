//
//  ElementPortfolioViews.swift
//  CoinFolios
//
//  Created by Jono Jono on 17/11/2022.
//

import SwiftUI

struct ElementPortfolioViews: View {
	let asset: CoinData
    var body: some View {
		HStack{
			BigCoinLogoView(coin: asset)
				.frame(alignment: .leading)
			
			VStack(alignment: .leading){
				Text(asset.name)
					.frame(width: 120, alignment: .leading)
					.frame(maxWidth: .infinity, alignment: .leading)
					.lineLimit(1)
					.padding(.bottom, 1)
				
				
				Text(asset.symbol)
					.font(.caption)
					.frame(width: 120, alignment: .leading)
					.frame(maxWidth: .infinity, alignment: .leading)
				
			}
			.frame(maxWidth: 120)
			
				//									Spacer()
			VStack(alignment: .trailing, spacing: 0.0){
				Text(asset.priceUsd.currencyFormatting())
					.frame(width: 110, alignment: .leading)
					.frame(maxWidth: .infinity, alignment: .leading)
				
				Text(asset.changePercent24Hr?.convertTodouble().asPercentage() ?? "")
					.foregroundColor(asset.changePercent24Hr?.convertTodouble() ?? 0.0 > 0 ? Color.themeColor.greenChartColor: Color.themeColor.redChartColor)
					.frame(width: 110, alignment: .leading)
					.frame(maxWidth: .infinity, alignment: .leading)
					//											.background(.red)
				
			}
			.frame(maxWidth: 110)
				//									Spacer()
				//
			VStack(alignment: .trailing){
				Text(String(asset.holdingCurrentValue?.toJust2Decimals().currencyFormatting() ?? "0.0"))
					.frame(width: 100, alignment: .trailing)
					.frame(maxWidth: .infinity, alignment: .trailing)
					.padding(.bottom, 1)
//				Text((asset.dateAndTime ?? .now), style: .time)

				
				HStack{
					Text(String(asset.amount ?? 0.0))
						.font(.caption)
					
					Text(asset.symbol)
						.font(.caption)

					
				}
				.frame(width: 100, alignment: .trailing)
				.frame(maxWidth: .infinity, alignment: .trailing)
				
				
			}
			.frame(maxWidth: 110)
			
		}
    }
}

struct ElementPortfolioViews_Previews: PreviewProvider {
    static var previews: some View {
		ElementPortfolioViews(asset: DummyPreview.instance.justDetail)
    }
}
