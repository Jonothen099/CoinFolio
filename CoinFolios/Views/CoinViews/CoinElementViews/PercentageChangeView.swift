//
//  PercentageChageView.swift
//  CoinFolios
//
//  Created by Jono Jono on 4/11/2022.
//

import SwiftUI

struct PercentageChangeView: View {
	let priceChange: Double?
	let priceChangeColor: Color
	let priceChangePercentage: String
	
	var body: some View {
		HStack{
			let arrowIcon = priceChange ?? 0 > 0.0 ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill"
			Image(systemName: arrowIcon)
				.resizable()
				.foregroundColor(priceChangeColor)
				.frame(width: 7, height: 6, alignment: .trailing)
			
			Text(priceChangePercentage)
				.frame(width: 50, height: 25, alignment: .leading)
				.foregroundColor(priceChangeColor)
				.font(.subheadline)
				.lineLimit(1)
				.minimumScaleFactor(0.5)

		}
		.background(priceChangeColor.opacity(0.2))
		.cornerRadius(8)
		.frame(alignment: .leading)
	}
}


struct PercentageNoBGView: View {
	let priceChange: Double?
	let priceChangeColor: Color
	let priceChangePercentage: String
	
	var body: some View {
		HStack{
			let arrowIcon = priceChange ?? 0 > 0.0 ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill"
			Image(systemName: arrowIcon)
				.resizable()
				.foregroundColor(priceChangeColor)
				.frame(width: 5, height: 5, alignment: .trailing)
			
			Text(priceChangePercentage)
//				.frame(width: 40, height: 20, alignment: .leading)
				.foregroundColor(priceChangeColor)
				.font(.subheadline)
				.lineLimit(1)
				.minimumScaleFactor(0.5)
		}
		.cornerRadius(8)
		.frame(alignment: .leading)
	}
}
