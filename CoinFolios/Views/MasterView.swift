	//
	//  MasterView.swift
	//  CoinFolios
	//
	//  Created by Jono Jono on 2/11/2022.
	//

import SwiftUI




struct MasterView: View {
	@EnvironmentObject var mvm: MasterViewModel
	
	var body: some View {
		
		TabView{
				CoinListView()
					.id(mvm.homeCoinRootViewId)
			
			.tabItem {
				Label("Markets", systemImage: "chart.line.uptrend.xyaxis.circle")
			}
			NavigationView {
				PortfolioView()
					.id(mvm.portfolioRootViewId)
			}
			.tabItem {
				Label("Portfolio", systemImage: "chart.pie")
			}
			NavigationView {
				
				MoreInfoView()
			}
			.tabItem {
				Label("More", systemImage: "list.bullet")
			}
				
		}
		// get rid of this if tab bar is invisible
		.tint(.themeColor.greenThemeColor.opacity(0.7))
		.onAppear {
			let appearance = UITabBarAppearance()
			appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
			appearance.backgroundColor = UIColor(Color.themeColor.backgroundColor.opacity(1))
				// Use this appearance when scrolling behind the TabView:
			UITabBar.appearance().standardAppearance = appearance
				// Use this appearance when scrolled all the way up:
			UITabBar.appearance().scrollEdgeAppearance = appearance
		}
		
	}
}

struct MasterView_Previews: PreviewProvider {
	static var previews: some View {
		MasterView()
			.environmentObject(MasterViewModel())
		
		
	}
}




