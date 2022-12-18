//
//  CoreDataTaskViewModel.swift
//  CoinFolios
//
//  Created by Jono Jono on 10/11/2022.
//

import Foundation
import CoreData


class CoreDataAssetController: ObservableObject {

//	@Published var assetVM: [AssetViewModel] = []
	@Published var assetEntity: [Asset] = []
	@Published var portfolioData: [CoinData] = []
	@Published var loadingPortfolio = false
	
	
	



//	func mappedAssetData() {
//		assetVM = assetEntity.map(AssetViewModel.init)
//	}

//	func mappedFromCoreData() {
//		portfolioData = assetEntity.compactMap(CoinDetail.init)
//
//	}
	
	
	
	func updatePortfolio(coin: CoinData, amount: Double, price: Double, dateAndTime: Date,  transactionNotes: String){
		// checking if user input coinID already in portfolio
		if let assetEntity = assetEntity.first(where: { $0.id == coin.id }) {
			// if yes then do this
			// update the existing coin id
			if amount > 0 {
				updateAllData(assetEntity: assetEntity, amount: amount, price: price, dateAndTime: dateAndTime, transactionNotes: transactionNotes)
				
			// else if coinID enter with amount less than zero we don't wanna save this
			} else {
				deleteSelectedData(asset: assetEntity)
			}
			// if coinID not exist yet do this
			// we will add the coin to the portfolio
		}else {
			addCoinData(coin: coin, amount: amount, price: price, dateAndTime: dateAndTime, transactionNotes: transactionNotes)
			
		}
	}
	
		// add and saving the coin to portfolio
	func addCoinData(coin: CoinData, amount: Double, price: Double, dateAndTime: Date,  transactionNotes: String) {
			// assign all the user input from above vars to the coreDataAssest which is coreData Entity
			// and then call save func from CoreDataController to save it
		let coreDataAssest = Asset(context: AssetPortfolioService.shared.viewContext)
		coreDataAssest.id = coin.id
		coreDataAssest.amount = amount
		coreDataAssest.price = price
		coreDataAssest.dateAndTime = dateAndTime
		coreDataAssest.transactionNotes = transactionNotes
		applyChanges()
//		mappedAssetData()
	}
	
	// getting saved data and assign it to assetVM
	func getAllData() {
		loadingPortfolio.toggle()
		defer{
			loadingPortfolio.toggle()
		}
		
		let fetchRequest: NSFetchRequest<Asset> = Asset.fetchRequest()
		do {
			assetEntity = try AssetPortfolioService.shared.viewContext.fetch(fetchRequest)
//				.map(AssetViewModel.init)
		} catch {
			fatalError(error.localizedDescription)
		}
	}
	
	// perform update, this is for when coin id already in the portfolio
	func updateAllData(assetEntity: Asset, amount: Double, price: Double, dateAndTime: Date,  transactionNotes: String){
		assetEntity.amount = amount
		assetEntity.price = price
		assetEntity.dateAndTime = dateAndTime
		assetEntity.transactionNotes = transactionNotes
		applyChanges()
//		mappedAssetData()
	}
	
	// save and get all the data to ViewModel
	func applyChanges() {
		save()
		getAllData()
//		mappedAssetData()
	}
	
	func deleteSelectedData(asset: Asset){
		AssetPortfolioService.shared.viewContext.delete(asset)
		applyChanges()
//		mappedAssetData()
	}
	
		// saving coredata func
	func save() {
		do {
			try AssetPortfolioService.shared.viewContext.save()
		} catch {
			AssetPortfolioService.shared.viewContext.rollback()
			print(error.localizedDescription)
		}
	}
	
	
}

//struct AssetViewModel {
//	// getting core data model/Entity and here i am creating normal swift model so that it can be passed around in my Views
//	// Asset is my coreData Entity name
//	let coreDataAssest: Asset
//
//	var id: String {
//		coreDataAssest.id ?? "N/A"
//	}
////	var id: NSManagedObjectID {
////		coreDataAssest.objectID
////	}
//
//	var amount: Double {
//		coreDataAssest.amount
//	}
//	var price: Double {
//		coreDataAssest.price
//	}
//
//	var dateAndTime: Date {
//		coreDataAssest.dateAndTime ?? .now
//	}
//
//	var transactionNotes: String {
//		coreDataAssest.transactionNotes ?? "N/A"
//	}
//
//
//}
