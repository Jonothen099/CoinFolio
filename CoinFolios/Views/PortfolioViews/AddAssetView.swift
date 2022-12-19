	//
	//  AddAssetView.swift
	//  CoinFolios
	//
	//  Created by Jono Jono on 4/11/2022.
	//

import SwiftUI

struct AddAssetView: View {
	let coinModels: CoinData

	@Environment(\.presentationMode) var presentation
	@EnvironmentObject var mvm: MasterViewModel

	@State private var amount: String = ""
	@State private var price: String = ""
	@State private var dateAndTime = Date.now
	@State private var transactionNotes: String = ""
	@State private var errorMessages: [String] = []
	
	
	func validateForm() -> Bool{
		errorMessages = []
		if amount.isEmpty {
			errorMessages.append("Amount is required")
		}
		if price.isEmpty {
			errorMessages.append("Buying price is required")
		}
		
		return errorMessages.count == 0
	}
	
	var isValid: Bool{
		!amount.isEmpty && !price.isEmpty
	}
		
	
	var body: some View {
		
		ZStack {
			Color.themeColor.backgroundColor
				.ignoresSafeArea()
			VStack{
							
				VStack {
					Form(){
						Group{
							HStack {
								FormDescription(description: "Asset ID: ")
								Text(coinModels.id)
									.padding(.bottom)
									.foregroundColor(.gray)
									.padding(.leading, 5)
								
							}
							HStack {
								FormDescription(description: "Amount: ")
								TextField("Amount Bought ex 1.2", text: $amount)
									.keyboardType(.decimalPad)
									.textFieldStyle(.roundedBorder)
									.padding(.bottom)
							}
							
							
							
							HStack {
								FormDescription(description: "Price: ")
								TextField("Current Price: \(coinModels.priceUsd.currencyFormatting())", text: $price)
									.keyboardType(.decimalPad)
									.textFieldStyle(.roundedBorder)
									.padding(.bottom)

							}
							
							DatePicker("Date & Time:", selection: $dateAndTime)
								.textFieldStyle(.roundedBorder)
							HStack{
								FormDescription(description: "Notes:")
								TextField("Transaction Notes", text: $transactionNotes)
									.textFieldStyle(.roundedBorder)
									.lineLimit(4)
									.padding(.bottom)
							}
							
							HStack {
								Spacer()
								Button {
									print("save button clicked")
									mvm.updatePortfolioInCoreData(coin: coinModels, amount: amount.convertTodouble(), price: price.convertTodouble(), dateAndTime: dateAndTime, transactionNotes: transactionNotes)
									mvm.showAlert.toggle()
									
								}
								
							label: {
								Text("Save Transaction")
							}
							.disabled(!isValid)
							.foregroundColor(isValid ?  .secondary.opacity(2) : Color.secondary)
							.padding(10)
							.background(isValid ? Color.themeColor.greenThemeColor : Color.secondary.opacity(0.1))
							.cornerRadius(8)
									// by adding borderless button style. it will allow button to works within a form
							.buttonStyle(.borderless)
								Spacer()
									.alert(isPresented: $mvm.showAlert, content: {
										getAlert()
										
									})
							}
						}
						.listRowBackground(Color.themeColor.greenThemeColor.opacity(0.02))
						
					}

					.onAppear { // ADD THESE
						UITableView.appearance().backgroundColor = .clear
					}
					.onDisappear {
						UITableView.appearance().backgroundColor = .systemGroupedBackground
					}
					.scrollContentBackground(.hidden)
					.formStyle(.automatic)
					.accentColor(Color("AccentColor"))
						// hiding keyboard
					.onTapGesture {
						hideKeyboard()
					}
					.padding(-20)

		
				}

			}
			
			.navigationTitle("Add Asset")
			.navigationBarTitleDisplayMode(.inline)
			.navigationViewStyle(.stack)
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing){
					HStack{
						Text(coinModels.name)
						CoinLogoView(coin: coinModels)
					}
				}
		}
		}
		
		
	}
	
	func getAlert() -> Alert{
		return Alert(title: Text("✅ Succesfully saved the asset to your portfolio"),
					 message: Text("Would you like to add more asset?"),
					 primaryButton: .default(Text("No"), action: {
					// pop to root when clicked
					mvm.portfolioRootViewId = UUID()
		}),
					 secondaryButton: .default(Text("Yes"), action: {
					// go back one level from current nav view
					presentation.wrappedValue.dismiss()

		}))
	
	}
}

struct AddAssetView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationStack{
			AddAssetView(coinModels: DummyPreview.instance.justDetail)
				.environmentObject(MasterViewModel())
		}
	}
}



	// dismisses keyboard when tap other part of screen
#if canImport(UIKit)
extension View {
	
	func hideKeyboard() {
		UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
	}
	
}
#endif

struct FormDescription: View {
	let description: String
	var body: some View {
		Text(description)
			.padding(.bottom)
			.frame(width: 95, alignment: .leading)
	}
}
