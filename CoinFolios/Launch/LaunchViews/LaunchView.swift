//
//  LaunchView.swift
//  CoinFolios
//
//  Created by Jono Jono on 12/12/2022.
//

import SwiftUI

struct LaunchView: View {
	
	@State private var appIconText: [String] = "CoinFolio".map{String($0)}
	@State private var showText: Bool = false
	@State private var counter = 0
	@State private var loopCount = 0
	@Binding var showLaunchView: Bool
	let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
	var body: some View {
		ZStack{
			Color.launchColor.launchBG
				.ignoresSafeArea()
			
				Image("appLogoC")
					.resizable()
					.frame(width: 100, height: 100)
			
			ZStack{
				if showText{
					HStack(spacing: 5){
						ForEach(appIconText.indices) { index in
							Text(appIconText[index])
								.font(.headline)
								.fontWeight(.heavy)
								.foregroundColor(.launchColor.launchAccent)
								.offset(y: counter == index ? -7 : 0)
						}
					}
					.transition(.scale.animation(.easeIn(duration: 0)))

						
				}
				
			}.offset(y: 50)
				.onAppear{
					showText.toggle()
				}
				.onReceive(timer) { _ in
					withAnimation(.spring()){
						if counter == appIconText.count - 1{
							counter = 0
							loopCount += 1
							if loopCount >= 2 {
								showLaunchView = false

							}
						} else{
							counter += 1
						}
					}
				}
		}
		
		
		
	}
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
		LaunchView(showLaunchView: .constant(true))
    }
}
