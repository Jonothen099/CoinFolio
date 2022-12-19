//
//  EmptyChartView.swift
//  CoinFolios
//
//  Created by Jono Jono on 18/12/2022.
//

import SwiftUI
import Charts

struct EmptyChartView: View{
	
	var body: some View{
		
		VStack {
			Chart{
				BarMark(x: .value("", 0), y: .value("No Data to show", 0))
					.annotation {
						VStack(alignment: .center){
							Text("No data available for this asset")
								.font(.footnote)
								.padding(.bottom)
							ProgressView()
								.scaleEffect(2)
						}
						
					}
			}
			.frame(height: 300)
			
			
		}
		
	}
}

struct EmptyChartView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyChartView()
    }
}
