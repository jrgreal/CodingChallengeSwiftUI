//
//  SearchListViewModel.swift
//  CodingChallengeSwiftUI
//
//  Created by Reginald on 12/1/20.
//

import SwiftUI


class SearchListViewModel: ObservableObject {
    let networkController: NetworkController = AFNetworkController()
    @Published var searchItems: [SearchItem] = []
    let lastVisitDate: Date?
    
    init() {
        lastVisitDate = AppState.lastVisitDate
        AppState.lastVisitDate = Date()
        searchItems = AppState.searchItems
        if searchItems.isEmpty {
            fetch()
        }
    }
    
    func fetch() {
        let url = APIEndpoint.searchMoviesURL
        networkController.fetchValue(for: url) { (result: Result<SearchResult>) in
            guard let searchItems = try? result.get().results else {
                return
            }
            self.searchItems = searchItems
            AppState.searchItems = searchItems
        }
    }
}
