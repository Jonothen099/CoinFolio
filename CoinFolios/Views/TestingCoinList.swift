////
////  TestingCoinList.swift
////  CoinFolios
////
////  Created by Jono Jono on 6/11/2022.
//
//import SwiftUI
//
//struct TestingCoinList: View {
//	@EnvironmentObject var coinData: CoinDataNetworkManager
//	let gradient = LinearGradient(colors: [.orange, .green],
//								  startPoint: .topLeading,
//								  endPoint: .bottomTrailing)
//	var body: some View {
//		ZStack{
//
//				// TabView background
////			VStack {
////				Spacer()
////
////				Color.gray
////					.frame(height: 90)
////					.opacity(0.4)
////			}
////			.ignoresSafeArea(edges: .bottom)
//////
////
//
//			VStack(spacing: 0){
////				Text("Background colors can be seen behind the TabView")
////					.padding()
////					.frame(maxHeight: .infinity)
//									List(1..<20){ item in
//										Text("text \(item)")
//											.listRowBackground(Color(.green))
//
//									}
//									.listStyle(.plain)
//
//
//			}
//		}
//			.background(Color.black)
//			.scrollContentBackground(.hidden)
//
//	}
//
//	struct TestingCoinList_Previews: PreviewProvider {
//		static var previews: some View {
//			TestingCoinList()
//				.environmentObject(CoinDataNetworkManager(coinData: CoinData.coinCapExample))
//
//		}
//	}
//
//
//
//}
//
//
