//
//  CoinRowView.swift
//  CoinFolios
//
//  Created by Jono Jono on 16/11/2022.
//

import SwiftUI

struct CoinRowView: View {
	let coin: CoinData
	var body: some View {
		HStack{
			Text(String(coin.rank))
				.font(.subheadline)
				.frame(width:27)
				.frame(alignment: .trailing)
			// coinLogo
			CoinLogoView(coin: coin)
			
			Text(coin.symbol)
				.font(.subheadline)
				.textCase(.uppercase)
				.frame(width: 110, alignment: .leading)
			
			
			PriceViews(price: coin.priceUsd.currencyFormatting())
			
			PercentageChangeView(priceChange: coin.changePercent24Hr?.convertTodouble(), priceChangeColor: coin.changePercent24Hr?.convertTodouble().compareAndReturnColor() ?? .red, priceChangePercentage: coin.changePercent24Hr?.convertTodouble().asPercentage() ?? "")
				.padding(.leading, 5)
				.frame(width: UIScreen.main.bounds.width / 80 ,alignment: .trailing)
			
			
		}
		
	}
	
	
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
		CoinRowView(coin: DummyPreview.instance.justDetail)
			.previewLayout(.sizeThatFits)

    }
}

	// price text view
struct PriceViews: View {
	var price: String
	var body: some View {
		Text(price)
			.frame(width: 200, alignment: .leading)
			.lineLimit(1)
	}
}

