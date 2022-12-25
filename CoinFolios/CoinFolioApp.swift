//
//  CoinFoliosApp.swift
//  CoinFolios
//
//  Created by Jono Jono on 23/10/2022.
//

import SwiftUI

@main
struct CoinFolioApp: App {
	@StateObject private var mvm = MasterViewModel()
	@State private var showLaunchView: Bool = true

    var body: some Scene {
        WindowGroup {
			ZStack{
				MasterView()
					.environmentObject(mvm)
				ZStack{
					if showLaunchView{
						LaunchView(showLaunchView: $showLaunchView)
							.transition(.move(edge: .trailing))

					}

				}
				.zIndex(2.0)
			}
			

        }
    }
}
