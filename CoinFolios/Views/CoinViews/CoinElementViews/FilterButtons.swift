//
//  FilterButtons.swift
//  CoinFolios
//
//  Created by Jono Jono on 16/11/2022.
//

import SwiftUI

// Filter buttons used to sort the coins according to selected metric
struct FilteredButtons: View {
	@EnvironmentObject var mvm: MasterViewModel
	var body: some View{
		HStack{
			HStack {
				Text("Market Cap")
					.font(.callout)
					.foregroundColor((mvm.sortBy == .rank || mvm.sortBy == .reversedRank) ? Color.themeColor.greenThemeColor: Color.primary)

				UpperButton()
					.foregroundColor((mvm.sortBy == .rank || mvm.sortBy == .reversedRank) ? Color.themeColor.greenThemeColor: Color.secondary.opacity(0.1))
					.rotationEffect(Angle(degrees: mvm.sortBy == .rank ? 0: 180))
			}
			.frame(width: 110, alignment: .leading)
			.padding(.leading, 45)
			.onTapGesture {
				withAnimation(.default){
					mvm.sortBy = mvm.sortBy == .rank ? .reversedRank: .rank
				}
			}
			
			HStack {
				Text("Price")
					.font(.callout)
					.foregroundColor((mvm.sortBy == .price || mvm.sortBy == .reversedPrice) ? Color.themeColor.greenThemeColor: Color.primary)

				UpperButton()
					.foregroundColor((mvm.sortBy == .price || mvm.sortBy == .reversedPrice) ? Color.themeColor.greenThemeColor: Color.secondary.opacity(0.1))
					.rotationEffect(Angle(degrees: mvm.sortBy == .price ? 0: 180))

			}
			.frame(width: 110, alignment: .leading)
			.padding(.leading, 60)
			.onTapGesture {
				withAnimation(.default){
					mvm.sortBy = mvm.sortBy == .price ? .reversedPrice: .price

				}
			}

			
			
			HStack {
				Text("24%")
					.font(.callout)
					.foregroundColor((mvm.sortBy == .percentChanged || mvm.sortBy == .reversedPercentChanged) ? Color.themeColor.greenThemeColor: Color.primary)

				UpperButton()
					.foregroundColor((mvm.sortBy == .percentChanged || mvm.sortBy == .reversedPercentChanged) ? Color.themeColor.greenThemeColor: Color.secondary.opacity(0.1))
					.rotationEffect(Angle(degrees: mvm.sortBy == .percentChanged ? 0: 180))


			}
			.frame(width: 110, alignment: .leading)
			.padding(.leading, 25)
			.onTapGesture {
				withAnimation(.default){
					mvm.sortBy = mvm.sortBy == .percentChanged ? .reversedPercentChanged: .percentChanged

				}
			}
		}
		// when onTapGesture tap on any of the button then mvm.sortBy will change and we recall the func here
		.onChange(of: mvm.sortBy) { newValue in
			print("Value of sort is now \(mvm.sortBy)")
			mvm.reSortCoins()
		}
	}
	
}

struct UpperButton: View {
	
	let arrowIcon = "arrowtriangle.down.fill"
	
	var body: some View {
		
			Image(systemName: arrowIcon)
				.resizable()
				.cornerRadius(5)
				.frame(width: 10, height: 7)
			
		
	}
}

struct FilterButtons_Previews: PreviewProvider {
    static var previews: some View {
		UpperButton()
			.environmentObject(MasterViewModel())

    }
}
