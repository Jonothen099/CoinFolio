//
//  TestingVMApiCall.swift
//  CoinFolios
//
//  Created by Jono Jono on 13/11/2022.
//

import SwiftUI
import Charts

struct MoreInfoView: View {
	@EnvironmentObject private var mvm: MasterViewModel
	@State var showDescriptionSwiftUI: Bool = false
	@State var showDescriptionSwiftCharts: Bool = false
	@State var showDescriptionCoreData: Bool = false
	
	let coinCapURL = URL(string: "https://coincap.io/")!
	let coingeckoURL = URL(string: "https://www.coingecko.com/")!
	let devLinkedInURL = URL(string: "https://www.linkedin.com/in/jonoiosdev/")!
	let gitHubURL = URL(string: "https://github.com/Jonothen099")!


	
	var body: some View {
		
//		ZStack{
//			Color.themeColor.backgroundColor.ignoresSafeArea()
			
			VStack{
				List{
					appSection
						.listRowBackground(Color.themeColor.backgroundColor)
					developerSection
						.listRowBackground(Color.themeColor.backgroundColor)
					coinDataSection
						.listRowBackground(Color.themeColor.backgroundColor)
					usedTechSection
						.listRowBackground(Color.themeColor.backgroundColor)
					
				}

				.listStyle(.grouped)
			}
			.background(Color.themeColor.backgroundColor)
			.scrollContentBackground(.hidden)
			.navigationBarTitleDisplayMode(.inline)
			.navigationTitle("App Information ")
//		}
		
		
		
	}
}

struct MoreInfoView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView{
			MoreInfoView()
				.environmentObject(MasterViewModel())

		}

	}
}


extension MoreInfoView {
	private var appSection: some View {
		Section("The Application"){
			HStack{
				Image("appLogo")
					.resizable()
					.frame(width:90, height: 90)
					.aspectRatio(1, contentMode: .fill)
					.clipShape(RoundedRectangle(cornerRadius: 30))
				Text("Cryptocurrencies Tracker/Portfolio App")
					.padding(.leading, 20)

				
			}
			
			
			Text("This app is semi-clone of CoinMarketCap app, it capable of displaying top coin's prices, interactive financial candle and line charts.\nFurthermore our portfolio feature allows user to visualise their total asset")
			
				//			Text("This app is semi-clone of CoinMarketCap app, it capable of displaying top coin's prices, 24 hour changes, and its correspond logo in the main page. \n\nUpon clicking on particular coin, it will navigate to a view showing details of the coin and more importantly it displays beautiful financial candle charts and line charts, which is interactive and real time.")
		}
	}
	
	
	private var developerSection: some View {
		Section("The Developer"){
			HStack{
				Image("jonoPFP")
					.resizable()
					.frame(width:90, height: 90, alignment: .leading)
					.aspectRatio(1, contentMode: .fill)
					.clipShape(RoundedRectangle(cornerRadius: 30))
				
				
				VStack(){
					HStack{
						ProfileDecs(question: "Dev Name:", answer: "Education:")
							.padding(.leading, 20)

						Divider()
							.frame(height: 80)
						ProfileDecs(question: "Jono", answer: "Bachelor of IT")
						

					}

				}
			}
			
			
			Text("I am the sole developer of this app, it developed using SwiftUI and is written in 100% Swift code")
			HStack{
				Text("Reach me on:")
				
					Link(destination: devLinkedInURL) {
						Image("linkedInIcon")
							.resizable()
							.frame(width:40, height: 40, alignment: .leading)
							.aspectRatio(1, contentMode: .fill)
							.padding(.leading, 10)
					}
					Link(destination: gitHubURL) {
						Image("githubIcon")
							.resizable()
							.frame(width:45, height: 45, alignment: .leading)
							.aspectRatio(1, contentMode: .fill)
							.padding(.leading, 10)
					}
				
			
				
					
				
				
				
			}

		}
	}
	
	
	private var usedTechSection: some View {
		Section("Technologies Used"){
			HStack(alignment: .top){
				TechnologyIconView(iconName: "swiftUiLogo")
				VStack(alignment: .leading){
					Text("Utilising Apple's latest User Interface Framework, it lets us to design this app in declarative and intuitive way ")
						.lineLimit(showDescriptionSwiftUI ? nil: 2)
					
					Button {
						withAnimation(.linear){
							showDescriptionSwiftUI.toggle()
						}
							
					} label: {
						Text("Read More...")
							.font(.caption2.bold())
					}

					
				}

			}
			HStack(alignment: .top){
				TechnologyIconView(iconName: "swiftChartsIcon2")
				VStack(alignment: .leading) {
					Text("Swift Charts launched in June 2022 WWDC, this is one of Apple newest frameworks, It is concise and packed with full of features. it allows us to build effective and customisable charts with as less code as possible. \nIt is declarative and designed to work with SwiftUI, there are many ways of communicating the pattern using Swift Charts, here in our app we utilised Line and Candle Charts.")
						.lineLimit(showDescriptionSwiftCharts ? nil: 2)
					
					Button {
						withAnimation(.linear){
							showDescriptionSwiftCharts.toggle()
						}
						
					} label: {
						Text("Read More...")
							.font(.caption2.bold())
					}
				}
					
			}
		
			HStack(alignment: .top){
				TechnologyIconView(iconName: "coreDataIcon1")
				VStack(alignment: .leading) {
					Text( "To persist all user assets saved within the app, i make use of the CoreData framework, It essentially save our application's permanent data for offline use")
						.lineLimit(showDescriptionCoreData ? nil: 2)
					
					Button {
						withAnimation(.linear){
							showDescriptionCoreData.toggle()
						}
					} label: {
						Text(showDescriptionCoreData ? "Less": "Read More...")
							.font(.caption2.bold())
					}
				}
			}
			

		}
	}
	
	private var coinDataSection: some View {
		Section("The API supports"){
			HStack{
				Image("coinCapLogo1")
					.resizable()
					.frame(width:90, height: 90, alignment: .leading)
					.aspectRatio(1, contentMode: .fill)
					.clipShape(RoundedRectangle(cornerRadius: 30))
					.padding(.trailing, 30)
				VStack(alignment: .leading){
					Link("Visit CoinCap.io", destination: coinCapURL)
				

				}
				
				
				
			}

			Text("The live coins data of this app is made possible by free API from CoinCap.io")
			
			HStack{
				Image("coinGeckoBrand")
					.resizable()
					.frame(width:190, height: 70, alignment: .leading)
					.aspectRatio(1, contentMode: .fill)
					.clipShape(RoundedRectangle(cornerRadius: 30))
					.padding(.trailing, 30)
				VStack(alignment: .leading){
					Link("Visit Coingecko.com", destination: coinCapURL)
					
					
				}
				
				
				
			}
			
			Text("The live market data is powered by CoinGecko.com")
			
			
			
		}
	}
	
	
	
}

struct ProfileDecs: View {
	var question: String
	var answer: String
	var body: some View {
		VStack{
			Text(question)
				.font(.headline)
				.frame(width: 90, alignment: .leading)
				.padding(.bottom, 10 )
				.padding(.trailing, 30)
			
				
			Text(answer)
				.font(.headline)
				.frame(width: 120, alignment: .leading)

		}
		.frame(maxWidth: .infinity, alignment: .leading)
	}
}

struct TechnologyIconView: View {
	let iconName: String
	var body: some View {
				Image(iconName)
					.resizable()
					.frame(width:40, height: 40)
					.aspectRatio(1, contentMode: .fit)
					.clipShape(RoundedRectangle(cornerRadius: 10))
					.padding(EdgeInsets(top: 0, leading: 5, bottom: 10, trailing: 10))
	
	}
}
