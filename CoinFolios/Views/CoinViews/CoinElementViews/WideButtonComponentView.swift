//
//  WideButtonComponentView.swift
//  CoinFolios
//
//  Created by Jono Jono on 11/12/2022.
//

import SwiftUI



struct WideButtonComponentView: View {
	var buttonTitle: String
	var body: some View {
		Text(buttonTitle)
			.fontWeight(.bold)
			.font(.headline)
			.frame(width: 370, height: 15)
			.padding()
			.foregroundColor(.themeColor.accentColor)
			.background(Color.themeColor.greenThemeColor.opacity(0.7))
			.cornerRadius(10)
			.padding(.bottom, 10)
	}
}

struct WideButtonComponentView_Previews: PreviewProvider {
	static var previews: some View {
		WideButtonComponentView(buttonTitle: "Wide Button")
		.previewLayout(.sizeThatFits)

    }
}
