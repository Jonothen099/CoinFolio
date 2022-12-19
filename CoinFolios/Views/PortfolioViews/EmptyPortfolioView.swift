//
//  EmptyPortfolioView.swift
//  CoinFolios
//
//  Created by Jono Jono on 8/12/2022.
//

import SwiftUI

struct EmptyPortfolioView: View {
	@State var animationValue = 10.0
	@State var animationValue2 = 1.0
	var body: some View {
		ZStack{
			Color.themeColor.backgroundColor
				.ignoresSafeArea()
		
		VStack{
			Image(systemName: "list.bullet.clipboard")
				.resizable()
				.frame(width: 100, height: 150)
				.foregroundColor(Color.themeColor.greenThemeColor.opacity(0.5))
				.rotationEffect(Angle(degrees: animationValue))
				.animation(
					.easeInOut(duration: 0.4)
					.repeatCount(3,autoreverses: true), value: animationValue
				)
				.padding(EdgeInsets(top: 100, leading: 0, bottom: 30, trailing: 0))
			
			
			VStack(alignment: .center){
				Text("Your portfolio is still empty")
					.font(.title.bold())
					.foregroundColor(.themeColor.greenThemeColor)
					.padding(.bottom)
				Text("Start building your portfolio today! \nBy clicking the add asset button.")
					.frame(alignment: .center)
			}
			.frame(width: 350)
			Spacer()
				
			VStack{
					//working on Portfolio
					// button to pick coin to add to portfolio
				NavigationLink(destination: PickAssetView()){
					WideButtonComponentView(buttonTitle: "Add New Asset")
						.scaleEffect(animationValue2)
						.opacity(2  - animationValue2)
						.animation(
							.easeOut(duration: 1)
							.repeatForever(autoreverses: true), value: animationValue
						)
					
					
						.onAppear{
							animationValue2 = 1.03
							
						}

					
				}
				.padding(.top, 300)
			}
		
			
		}
	}
		.onAppear{
			animationValue += 15
		}
		.onDisappear{
			animationValue -= 15
		}
       
    }
}

struct EmptyPortfolioView_Previews: PreviewProvider {
		static var previews: some View {
			NavigationStack{

			EmptyPortfolioView()

		}

	}
}


