//
//  PortfolioDetailView.swift
//  CoinFolios
//
//  Created by Jono Jono on 11/12/2022.
//

import SwiftUI

struct PortfolioDetailView: View {
	@EnvironmentObject var mvm: MasterViewModel
	var asset: CoinData
	@State var animationValue: Double = 1.0

	var body: some View {
		
		ZStack{
			Color.themeColor.backgroundColor
				.ignoresSafeArea()
			VStack {
				HStack {
						VStack(alignment: .leading){
							
							HStack{
								CoinLogoView(coin: asset)
								
								Text(asset.name)
								Text("(\(asset.symbol))")
									.font(.subheadline)
									.padding(.leading, -10)
								
								
							}
							
							
							Text(asset.priceUsd.currencyFormatting())
								.font(.title2.bold())
								//					Text(asset.profitLoss?.description.currencyFormatting() ?? "0.0")
								
							
							
						}
						.padding(.leading, 20)
							Spacer()

						
						VStack(alignment: .trailing){
							Text("Total Holding")
								.padding(EdgeInsets(top: 1, leading: 0, bottom: 1, trailing: 15))
							
							Text(String(asset.amount ?? 0.0))
								.font(.title2.bold())
								.padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 15))


							
						}

						

						
					
				}
				Divider()
				
				
				VStack {
					HStack {
						PortfolioStatView(imageTitle: asset.priceUsd.convertTodouble() > asset.price ?? 0.0 ? "chart.line.uptrend.xyaxis.circle.fill" : "chart.line.downtrend.xyaxis.circle.fill", imageColor: asset.priceUsd.convertTodouble() > asset.price ?? 0.0 ? .themeColor.greenThemeColor: .themeColor.redChartColor, boxTitle: "Profit / Loss", boxTopic: ((asset.profitLoss ?? 0.0) * (asset.amount ?? 0.0)).toJust2Decimals().currencyFormatting(), priceChange: asset.profitLossPercent, percentColor: asset.profitLossPercent?.compareAndReturnColor() ?? .themeColor.greenThemeColor , percentChange: asset.profitLossPercent?.asPercentage() ?? "N/A" )
							
						
						
						PortfolioStatView(imageTitle: "dollarsign.circle.fill", imageColor: .secondary, boxTitle: "Average Buy Price", boxTopic: asset.price?.description.currencyFormatting() ?? "0.0", priceChange: 0.0, percentColor: .secondary.opacity(0), percentChange: "" )
						
						
								
					}
					
					Rectangle()
						.frame(width: 400, height: 110)
						.cornerRadius(10)
						.foregroundColor(Color.themeColor.greenThemeColor.opacity(0.05))
						.shadow(radius: 20)
						.padding(8)
						.overlay {
							HStack{
								
								VStack(alignment: .leading){
									Text("Note:")
										.font(.subheadline.bold())
										.padding(EdgeInsets(top: 0, leading:15, bottom: -15, trailing: 0))
									Image(systemName: "note.text")
										.resizable()
										.frame(width: 20, height: 40, alignment: .leading)
										.padding()
										.foregroundColor(.themeColor.greenThemeColor)
									
								}
								
								
									
									Text(asset.transactionNotes ?? "N/A  ")
										.lineLimit(4)
										.font(.caption.bold())
										.foregroundColor(.themeColor.greenThemeColor)
										.frame(maxWidth: 120, alignment: .leading)
									
								
								VStack(alignment: .leading) {
									HStack {
										VStack{
											Text("Date:")
												.font(.subheadline.bold())
//												.padding(.bottom, -15)
												.padding(EdgeInsets(top: 0, leading:12, bottom: -15, trailing: 0))

											Image(systemName: "calendar.badge.clock")
												.resizable()
												.frame(width: 20, height: 40, alignment: .leading)
												.padding()
												.foregroundColor(.themeColor.greenThemeColor)
											
										}
										
										VStack(alignment: .leading){
											Text(asset.dateAndTime ?? .now, style: .date)
												.font(.caption.bold())
												.frame(width: 125, alignment: .leading)
												.foregroundColor(.themeColor.greenThemeColor)
											Text(asset.dateAndTime ?? .now, style: .time)
												.font(.caption.bold())
												.frame(width: 125, alignment: .leading)
												.foregroundColor(.themeColor.greenThemeColor)
												
										}
									}
									.padding(.leading, 20)

									
								}
							}
							
						}
					
					
				}
				
				NavigationLink(destination: DetailView(coinModels: asset, maxRangeValue: 0, minRangeValue: 0,firstPrice: 0, lastPrice: 0, chartsTypes: CoinChartView(currentChartSelection: true, min: 0.0, max: 0.0, first: 0.0, last: 0.0))){
					WideButtonComponentView(buttonTitle: "See Coin Details")
						.opacity(0.3)

				}

					
				
				
				
							 Spacer()

			}

		
	}
		.toolbar {
			ToolbarItem(placement: .navigationBarTrailing){
				NavigationLink( destination: AddAssetView(coinModels: asset)){
//				NavigationLink(destination: PickAssetView()){
					Image(systemName:"plus.circle")
						.resizable()
						.frame(width: 20, height: 20)
						.foregroundColor(Color("AccentColor"))
						.overlay {
							Circle()
								.stroke(Color.themeColor.greenThemeColor)
								.scaleEffect(animationValue)
								.opacity(2 - animationValue)
								.shadow(color: .themeColor.greenThemeColor, radius: animationValue)
								.animation(
									.easeOut(duration: 1)
									.repeatForever(autoreverses: true), value: animationValue
								)
							
						}
						.onAppear{
								animationValue = 1.5
							
						}
					
					
				}
			}
		}
			
	}
}

struct PortfolioDetailView_Previews: PreviewProvider {
    static var previews: some View {
		NavigationStack{
			PortfolioDetailView(asset: DummyPreview.instance.justDetail)

		}
    }
}

struct PortfolioStatView: View {
	var imageTitle: String
	var imageColor: Color
	var boxTitle: String
	var boxTopic: String
	var priceChange: Double?
	var percentColor: Color
	var percentChange: String
	var body: some View {
		Rectangle()
			.frame(width: 190, height: 150)
			.cornerRadius(10)
			.foregroundColor(Color.themeColor.greenThemeColor.opacity(0.05))
			.shadow(radius: 20)
			.padding(8)
			.overlay {
				VStack(alignment: .leading){
					HStack{
						Image(systemName: imageTitle)
							.resizable()
							.frame(width: 50, height: 50, alignment: .leading)
							.foregroundColor(imageColor)
							.rotationEffect(Angle(degrees: 0))
							.padding(.bottom,10)
						PercentageNoBGView(priceChange: priceChange, priceChangeColor: percentColor, priceChangePercentage: percentChange)
							.padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 0))

					}
					
					VStack(alignment: .leading){
						Text(boxTitle)
							.frame(width: 170, alignment: .leading)
						HStack{
							Text(boxTopic)
								.font(.title2.bold())
						
							
						}
					}
					

					
					
					
				}
//				.padding(.trailing, 40)
				
			}
	}
}
