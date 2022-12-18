//
//  StringFuncEx.swift
//  CoinFolios
//
//  Created by Jono Jono on 12/11/2022.
//

import Foundation
import SwiftUI



extension Double {
	/// convert a double to 2 decimal places
	func toJust2Decimals() -> String {
		return String(format: "%.2f", self)
	}
	
	/// from the converted data from double to string and then add percentage sign to it
	/// ```
	/// convert Double to String with 2 decimal value and
	///	adding percentage sign
	/// ie. 2.00%
	/// ```
	
	func asPercentage() -> String {
		return toJust2Decimals() + "%"
	}
	
	func compareAndReturnColor() -> Color{
//		let priceChangeColor = Double ?? 0 > 0.0 ? Color.themeColor.greenChartColor : Color.themeColor.redChartColor, .self
		return self > 0.0 ? Color.themeColor.greenChartColor : Color.themeColor.redChartColor

	}
	
	
		// conver unix to Date
	func unixToDate() -> Date {
		var stringDate = ""
		var strDate : Date
		let date = Date(timeIntervalSince1970: self/1000)
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "YYYY MMM dd HH:mm" //Specify your format that you want
		stringDate = dateFormatter.string(from: date)
		strDate = dateFormatter.date(from: stringDate) ?? Date.now
		return strDate
	}
	
	



	
}


extension String {
		// format it to short like 1M/ 1B
	var abbreviated: String {
		let abbrev = "KMBTPE"
		return abbrev.enumerated().reversed().reduce(nil as String?) { accum, tuple in
			let factor = (Double(self) ?? 0.0) / pow(10, Double(tuple.0 + 1) * 3)
			let format = (factor.truncatingRemainder(dividingBy: 1)  == 0 ? "%.0f%@" : "%.1f%@")
			return accum ?? (factor > 1 ? String(format: format, factor, String(tuple.1)) : nil)
		} ?? String(self)
	}
	
		// formatting text for currency textField
	func currencyFormatting() -> String {
		if let value = Double(self) {
			let formatter = NumberFormatter()
			formatter.usesGroupingSeparator = true
			formatter.numberStyle = .currency
			formatter.maximumFractionDigits = 2
			formatter.minimumFractionDigits = 2
			if let str = formatter.string(for: value) {
				return str
			}
		}
		return "N/A"
	}
	
	
	func convertTodouble() -> Double {
		return Double(self) ?? 0.0
	}

}


extension Date {
	func nearestHour() -> Date? {
		var components = NSCalendar.current.dateComponents([.minute, .second, .nanosecond], from: self)
		let minute = components.minute ?? 0
		let second = components.second ?? 0
		let nanosecond = components.nanosecond ?? 0
		components.minute = minute >= 30 ? 60 - minute : -minute
		components.second = -second
		components.nanosecond = -nanosecond
		return Calendar.current.date(byAdding: components, to: self)
	}
}



