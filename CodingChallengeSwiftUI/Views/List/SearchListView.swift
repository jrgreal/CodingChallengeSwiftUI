//
//  SearchListView.swift
//  CodingChallengeSwiftUI
//
//  Created by Reginald on 12/1/20.
//

import SwiftUI


enum SceneStorageKeys: String {
    case isSearchItemDetailActive
    case selectedItem
}

struct SearchListView: View {
    let title = "iTunes Search"
    @EnvironmentObject var searchListModel: SearchListViewModel
    @State var isDetailActive: Bool = false
    
    @SceneStorage(SceneStorageKeys.selectedItem.rawValue) var selectedItem: Int?
    @SceneStorage(SceneStorageKeys.isSearchItemDetailActive.rawValue) var detailShown: Bool = false
    
    var body: some View {
        List {
            Section(header: header) {
                ForEach(searchListModel.searchItems) { searchItem in
                    SearchItemOverview(searchItem: searchItem)
                        .background(Color.white)
                        .onTapGesture(perform: {
                            selectedItem = searchItem.id
                            detailShown = true
                        })
                }
            }
        }
        .background(navigationLinks)
        .navigationTitle(title)
        .onAppear(perform: searchListModel.fetch)
        .onContinueUserActivity(SearchItemDetailView.searchItemUserActivityType) { userActivity in
            if let searchItem = try? userActivity.typedPayload(SearchItem.self) {
                selectedItem = searchItem.id
            }
        }
    }
    
    private var navigationLinks: some View {
        Group {
            if let searchItem =  searchListModel.searchItems.first(where: { $0.id == selectedItem }) {
                NavigationLink(destination: SearchItemDetailView(searchItem: searchItem,
                                                                 selectedItem: $selectedItem),
                               isActive: $detailShown,
                               label: { EmptyView() })
            }
            
        }
        .hidden()
        .disabled(true)
    }
    
    private var header: some View {
        searchListModel.lastVisitDate.map({
            Text("Last visit: " + $0.dateText)
                .font(.system(size: 12))
        })
    }
    
}

extension SearchListView {
    init(searchItems: [SearchItem]) {
        self.searchListModel.searchItems = searchItems
    }
}

struct SearchListView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            ForEach(TestData.movies) { searchItem in
                SearchItemOverview(searchItem: searchItem)
            }
        }
    }
}
