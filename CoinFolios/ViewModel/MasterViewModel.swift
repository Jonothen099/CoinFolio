//
//  MasterViewModel.swift
//  CoinFolios
//
//  Created by Jono Jono on 11/11/2022.
//

import Foundation
import Combine

@MainActor
class MasterViewModel: ObservableObject {
	
	@Published var coinModel: CoinModel
	@Published var globalMarketDataModel: GlobalMarketData
	@Published var coinData: [CoinData] = []
	@Published var chartModelDataGroup: [ChartModel] = []
	@Published var masterChart: [ChartDetail] = []
	@Published var portfolioCoins: [CoinData] = []
	@Published var totalHoldings: [TotalHolding] = []
	@Published var totalPortfolio: TotalPortfolio
	@Published var chartModel: ChartModel
	
	@Published var showAlert: Bool = false
	@Published var portfolioRootViewId = UUID()
	@Published var homeCoinRootViewId = UUID()
	private var cancellables = Set<AnyCancellable>()
	private var coinService = CoinDataNM()
	private let globalMarketDataService = GlobalMarketDataNM()
	var chartService = ChartManager(chartData: ChartModel.chartExample, chartPrices: ChartPricesModel.chartPricesExample)
	let portfolioService = CoreDataAssetController()
	// for chart type and chartInterval value( line or candle)(30d or 90d)
	@Published var chartInterval: ChartIntervalData = .the90D
	@Published var chartTypeIsTap: Bool = false
	@Published var isLoading: Bool = false
	@Published var portfolioLoading: Bool = false
	@Published var sortBy : SortBy = .rank
	
	init() {
		coinModel = CoinModel(data: CoinData.newcoinDetailExample2, timestamp: 0)
		globalMarketDataModel = DummyPreview.instance.globalData
		chartModel = ChartModel.chartExample
//		masterChart = chartIntervalValue
		totalPortfolio = TotalPortfolio(totalPortfolio: 0.0, totalBuyPrice: 0.0)
		addSubscribers()
//		appendToHolding()
		self.coinData = sortCoins(sort: sortBy, coins: coinModel)
	}
	
	
	enum SortBy{
		case rank, reversedRank, price, reversedPrice, percentChanged, reversedPercentChanged
	}
	
	
	// getting Coin list data
	func getCoins() async {
		
		do {
			self.coinModel = try await coinService.fetchCoinData()
			self.coinData = sortCoins(sort: sortBy, coins: coinModel)
		} catch  {
			print(error.localizedDescription)
		}
	}
	
//	 getting Global Market Data
	func getGlobalData() async {
		do {
			self.globalMarketDataModel = try await globalMarketDataService.fetchGlobalData()
		} catch  {
			print(error.localizedDescription)
		}
	}
	
		
	//	 getting Chart Data
	func getChartData(id: String) async {
		isLoading.toggle()
		defer{
			isLoading.toggle()
		}
		do {
			let arrayOfCharts = try await chartService.getChartDataGroupTask(id: id)
			self.chartModelDataGroup = arrayOfCharts

		} catch  {
			return
		}
		masterChart = chartModelDataGroup[NewChartIntervalStruct(chartInterval: chartInterval).chartTypeSelected(isLineChart: chartTypeIsTap)].data.map{$0}
		print("this is master chart1 first value: \(masterChart)")
		
	}
	// this func will be called, when chart tab or chart type changed it will re-evaluate the data in masterChart
	func masterChartValue(){
		masterChart = chartModelDataGroup[NewChartIntervalStruct(chartInterval: chartInterval).chartTypeSelected(isLineChart: chartTypeIsTap)].data.map{$0}
		print("this is master chart1 first value: \(masterChart)")
		
	}
	
	
	
	func addSubscribers() {
		
		$coinModel
			.combineLatest(portfolioService.$assetEntity)
			.map { coinData, assetEntity -> [CoinData] in
				coinData.data
					.compactMap { (coin) -> CoinData? in
						guard let entity = assetEntity.first(where: { $0.id == coin.id}) else {
							return nil
						}
						return coin.updatePortfolioHodling(amount: entity.amount, price: entity.price, dateAndTime: entity.dateAndTime ?? .now, transactionNotes: entity.transactionNotes ?? "N/A", holdingCurrentValue: entity.amount * coin.priceUsd.convertTodouble())
					}
			}
			.sink{[weak self] (returnValue) in
				self?.portfolioCoins = returnValue
			}
			.store(in: &cancellables)
		
	
	}
		func updatePortfolioInCoreData(coin: CoinData, amount: Double, price: Double, dateAndTime: Date, transactionNotes: String){
		portfolioService.updatePortfolio(coin: coin, amount: amount, price: price, dateAndTime: dateAndTime, transactionNotes: transactionNotes)
	}
	// this will append the only value of portfolio coin and sort it according to old one first and add the value of prev to the next one
	func appendToHolding(){
		portfolioLoading.toggle()
		defer{
			portfolioLoading.toggle()
		}
		var totals: [TotalHolding] = []
		var total = 0.0
		var date: Date = .now
		var id: String = ""
		var totalBuy = 0.0
		
		var totalPortfolioValue: Double? = 0.0
		var totalBuyPrice: Double? = 0.0
		for item in portfolioCoins.reversed() {
				totalPortfolioValue = item.holdingCurrentValue.map{ value -> Double in total += value; return total }
				totalBuyPrice = item.boughtValue.map{value -> Double in totalBuy += value;
					return totalBuy
				}
			
//			totalPortfolioValue = item.amount.map{ value -> Double in total += value; return total }
			
//			totals.append(contentsOf: totals)
			
			date = item.dateAndTime ?? .now
			id = item.id
			
			totals = [TotalHolding(id: id, date: date, totalHolding: totalPortfolioValue ?? 0.0)]
		}
		
		totalPortfolio = TotalPortfolio(totalPortfolio: totalPortfolioValue ?? 0.0, totalBuyPrice: totalBuyPrice ?? 0.0)
	

		print("this is totals\(totals)")
		print("this is total buy price\(String(describing: totalBuyPrice))")
		print("this is sorted one: \(totalHoldings)")
//
	}
	// func to sort the coin data
	private func sortCoins(sort: SortBy, coins: CoinModel) -> [CoinData]{
		switch sort{
			case .rank:
				return coins.data.sorted(by:{ $0.rank.convertTodouble() < $1.rank.convertTodouble() })
			case .reversedRank:
				return coins.data.sorted(by:{ $0.rank.convertTodouble() > $1.rank.convertTodouble() })
			case .price:
				return coins.data.sorted(by:{ $0.priceUsd.convertTodouble() > $1.priceUsd.convertTodouble() })
			case .reversedPrice:
				return coins.data.sorted(by:{ $0.priceUsd.convertTodouble() < $1.priceUsd.convertTodouble() })

			case .percentChanged:
				return coins.data.sorted(by:{ $0.changePercent24Hr?.convertTodouble() ?? 0 > $1.changePercent24Hr?.convertTodouble() ?? 0 })

			case .reversedPercentChanged:
				return coins.data.sorted(by:{ $0.changePercent24Hr?.convertTodouble() ?? 0 < $1.changePercent24Hr?.convertTodouble() ?? 0 })
		}
	}
	// when value of SortBy enum changed, we will call this func from where this change is triggered
	func reSortCoins(){
		self.coinData = sortCoins(sort: sortBy, coins: coinModel)
	}

	
	func spillOut() {
//		print("this is asset entity\(portfolioService.assetEntity)")
//		print("this is combined data\(portfolioCoins)")
//		print("this is Individual viewModel data\(portfolioService.assetVM)")
//		print("this is coindata that fetched\(newCoinsData.data)")
		
	}
	
	
		// conver unix to Date
	func unixConverter(unixTime: Double) -> Date {
		var stringDate = ""
		var strDate : Date
		let date = Date(timeIntervalSince1970: unixTime/1000)
		let dateFormatter = DateFormatter()
		let timezone = TimeZone.current.abbreviation() ?? "UTC"  // get current TimeZone abbreviation or set to CET
		dateFormatter.timeZone = TimeZone(abbreviation: timezone) //Set timezone that you want
		dateFormatter.locale = NSLocale.current
		dateFormatter.dateFormat = "YYYY MMM dd HH:mm" //Specify your format that you want
		stringDate = dateFormatter.string(from: date)
		strDate = dateFormatter.date(from: stringDate) ?? Date.now
		return strDate
	}

	

	
}
  
