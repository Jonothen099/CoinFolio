//
//  AssetPortfolioService.swift
//  CoinFolios
//
//  Created by Jono Jono on 13/11/2022.
//

import Foundation
import CoreData


class AssetPortfolioService: ObservableObject {
	
	let container = NSPersistentContainer(name: "CoreCoinDataModel")
	static let shared = AssetPortfolioService()
	
	
	
	init(){
		container.loadPersistentStores{ description, error in
			if let error = error {
				print("Failed to load core data: \(error.localizedDescription)")
				fatalError("Failed to load core data: \(error.localizedDescription)")

			}
			
		}
		
	}
	
	var viewContext: NSManagedObjectContext{
		return container.viewContext
	}
	
	
	
	
}
