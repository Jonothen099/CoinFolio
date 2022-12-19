//
//  Color.swift
//  CoinFolios
//
//  Created by Jono Jono on 11/11/2022.
//

import Foundation
import SwiftUI

extension Color {
	
	static let themeColor = ThemeColor()
	static let launchColor = LaunchColor()
}


struct ThemeColor {
	let accentColor = Color("AccentColor")
	let backgroundColor = Color("BackgroundColor")
	let greenChartColor = Color("ChartGreenColor")
	let redChartColor = Color("ChartRedColor")
	let greenThemeColor = Color("GreenTheme")
	let FaintLineColor = Color("FaintLineColor")
	
	
}

struct LaunchColor {
	
	let launchBG = Color("LaunchBgColor")
	let launchAccent = Color("LaunchAccentColor")
	
}
