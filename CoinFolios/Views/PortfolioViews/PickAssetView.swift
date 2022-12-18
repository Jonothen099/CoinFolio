//
//  TestingNV.swift
//  CoinFolios
//
//  Created by Jono Jono on 2/11/2022.
//


import SwiftUI

struct PickAssetView: View {
	@EnvironmentObject var mvm: MasterViewModel
	@State var searchAssest = ""

	
	var body: some View {
		VStack{
			List(searchResults, id: \.self){ coin in
				NavigationLink( destination: AddAssetView(coinModels: coin)){
					HStack{
						AsyncImage(url: URL(string: "\(ImageForLogos().coinImage)\(coin.symbol.lowercased())\(ImageForLogos().imageFormat)")) { image in
							image.resizable()
						} placeholder: {
							ProgressView()
						}
						.aspectRatio(1,contentMode: .fit)
						.frame(width:40,height:40)
						.clipShape(Circle())
						VStack{
							Text(coin.symbol)
								.frame(width: 70, alignment: .leading)
								.padding(.trailing, 92)
								.padding(.bottom, 0.1)
							Text(coin.name)
								.frame(width: 170, alignment: .leading)
								.font(.caption2)
								.padding(.leading, 10)
								.foregroundColor(Color("GreenTheme"))
						}
					}
				}
				.listRowBackground(Color.themeColor.backgroundColor.opacity(0.9))

		
			}
			// important
			// if this search bar meant to search the list, then this modifier has to be outside of the
			// list closure otherwise the keyboard will dismissed everytime you type 2 characters
			.searchable(text: $searchAssest){
			}
		
		}
		.background(Color.themeColor.backgroundColor)
		.scrollContentBackground(.hidden)
		.navigationTitle("Select Assest")
    }
	// computed var for search bar
	var searchResults: [CoinData]{
		if searchAssest.isEmpty {
			return mvm.coinModel.data
		} else {
			let coin = mvm.coinModel.data
			return coin.filter { $0.id.localizedCaseInsensitiveContains(searchAssest) }
		}
	}
}

struct PickAssetView_Previews: PreviewProvider {
    static var previews: some View {
		PickAssetView( )
			.environmentObject(MasterViewModel())

    }
}


