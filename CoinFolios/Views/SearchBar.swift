//
//  SearchBar.swift
//  CoinFolios
//
//  Created by Jono Jono on 6/11/2022.
//

import SwiftUI

struct Message: Identifiable, Codable {
	let id: Int
	var user: String
	var text: String
}

enum SearchScope: String, CaseIterable {
	case inbox, favorites
}

struct SearchBarView: View {
	@State private var messages = [Message]()
	
	@State private var searchText = ""
	@State private var searchScope = SearchScope.inbox
	
	var body: some View {
		NavigationView {
			Text("")
			.searchable(text: $searchText) {
				ForEach(SearchScope.allCases, id: \.self) { scope in
					Text(scope.rawValue.capitalized)
				}
			}
			List {
				ForEach(filteredMessages) { message in
					VStack(alignment: .leading) {
						Text(message.user)
							.font(.headline)
						Text(message.text)
					}
				}
			}
			.navigationTitle("Messages")
		}
		.onSubmit(of: .search, runSearch)
		.onChange(of: searchScope) { _ in runSearch() }
	}
	
	var filteredMessages: [Message] {
		if searchText.isEmpty {
			return messages
		} else {
			return messages.filter { $0.text.localizedCaseInsensitiveContains(searchText) }
		}
	}
	
	func runSearch() {
		Task {
			guard let url = URL(string: "https://hws.dev/\(searchScope.rawValue).json") else { return }
			
			let (data, _) = try await URLSession.shared.data(from: url)
			messages = try JSONDecoder().decode([Message].self, from: data)
		}
	}
}








struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView()
    }
}
