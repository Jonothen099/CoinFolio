//
//  HapticFeedbackManager.swift
//  CoinFolios
//
//  Created by Jono Jono on 4/12/2022.
//

import Foundation
import SwiftUI
 

class HapticFeedbackManager {
	static let instance = HapticFeedbackManager() // Sigleton
	
	func notification(type: UINotificationFeedbackGenerator.FeedbackType){
		let generator = UINotificationFeedbackGenerator()
		generator.notificationOccurred(type)
	}
	
	func hapticImpact(style: UIImpactFeedbackGenerator.FeedbackStyle){
		let generator = UIImpactFeedbackGenerator(style: style)
		generator.impactOccurred()
	}
	
}
