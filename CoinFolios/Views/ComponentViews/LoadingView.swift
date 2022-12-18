	//
	//  LoadingView.swift
	//  CoinFolios
	//
	//  Created by Jono Jono on 20/11/2022.
	//

import SwiftUI

struct LoadingView: View{
	let loadingTitle: String
	let loadingFrameHeight: CGFloat
	let loadingColor: Color
	let loadingSize: CGFloat
	
	var body: some View{
		
		VStack(alignment: .center){
			
			ProgressView()
				.progressViewStyle(CircularProgressViewStyle(tint: loadingColor))
				.scaleEffect(loadingSize)
			Text(loadingTitle)
				.font(.footnote)
				.padding(.top)
		}
		.background(Color.themeColor.backgroundColor.opacity(0.001))
		.frame(height: loadingFrameHeight)
		
	}
}

struct LoadingView_Previews: PreviewProvider {
	static var previews: some View {
		LoadingView(loadingTitle: "Loading", loadingFrameHeight: 300, loadingColor: .red, loadingSize: 3)
	}
}
