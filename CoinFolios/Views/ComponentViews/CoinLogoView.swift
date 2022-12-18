//
//  CoinLogoView.swift
//  CoinFolios
//
//  Created by Jono Jono on 16/11/2022.
//

import SwiftUI

struct CoinLogoView: View {
	let coin: CoinData
    var body: some View {
		AsyncImage(url: URL(string: "\(ImageForLogos().coinImage)\(coin.symbol.lowercased())\(ImageForLogos().imageFormat)")) { image in
			image.resizable()
		}  placeholder: {
			ProgressView()
		}
		.aspectRatio(1,contentMode: .fit)
		.frame(width:20,height:20)
		.clipShape(Circle())
    }
}

struct BigCoinLogoView: View {
	let coin: CoinData
    var body: some View {
		AsyncImage(url: URL(string: "\(ImageForLogos().coinImage)\(coin.symbol.lowercased())\(ImageForLogos().imageFormat)")) { image in
			image.resizable()
		}  placeholder: {
			ProgressView()
		}
		.aspectRatio(1,contentMode: .fit)
		.frame(width:40,height:40)
		.clipShape(Circle())
    }
}

struct CoinLogoView_Previews: PreviewProvider {
    static var previews: some View {
		CoinLogoView(coin: DummyPreview.instance.justDetail)
			
    }
}
