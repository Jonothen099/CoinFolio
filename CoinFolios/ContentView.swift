////
////  ContentView.swift
////  CoinFolios
////
////  Created by Jono Jono on 23/10/2022.
////
//
//import SwiftUI
//import Charts
//
//struct ContentView: View {
//	@EnvironmentObject var mvm: MasterViewModel
//	
//		// this will grab the coinData from Contentview when using the navlink where this View will be called and asked to pass in coinModel so we can use the data here
//		//	let coinModel: CoinModel
//	
//	
//	let coinModels: CoinData
//    var body: some View {
//        VStack {
//			Chart{
//				ForEach(mvm.masterChart, id: \.self) { candleData in
//					let date = mvm.unixConverter(unixTime: Double(candleData.period))
//					RectangleMark(x: .value("Time", date, unit: .hour),
//								  yStart: .value("Low Price", candleData.low.convertTodouble()),
//								  yEnd: .value("High Price", candleData.high.convertTodouble()), width: 1)
//					RectangleMark(x: .value("Time", date, unit: .hour),
//								  yStart: .value("Open Price", candleData.open.convertTodouble()),
//								  yEnd: .value("Close Price", candleData.close.convertTodouble()), width: 6)
//				}
//			}
//			.frame(height: 300)
//
//		
//        }
//		.task {
//			await mvm.getChartData(id: "bitcoin")
//		}
//        .padding()
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(coinModels: DummyPreview.instance.justDetail )
//			.environmentObject(MasterViewModel())
//
//    }
//}
