//
//  SearchItemDetailView.swift
//  CodingChallengeSwiftUI
//
//  Created by Reginald on 12/2/20.
//

import SwiftUI

struct SearchItemDetailView: View {
    static let searchItemUserActivityType = "com.appetiser.coding-challenge-swiftui.staterestore.searchitem"
    let searchItem: SearchItem
    @Binding var selectedItem: Int?
    @EnvironmentObject var searchListModel: SearchListViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                SearchItemOverview(
                    artworkUrl: searchItem.artwork,
                    trackName: searchItem.trackName ?? "",
                    genre: searchItem.primaryGenre,
                    sdBuyPrice: searchItem.trackPrice?.description,
                    hdBuyPrice: searchItem.trackHDPrice?.description,
                    sdRentPrice: searchItem.trackRentalPrice?.description,
                    hdRentPrice: searchItem.trackHDRentalPrice?.description,
                    currency: searchItem.currency)
                Group {
                    Divider()
                    Text(String.description)
                        .fontWeight(.semibold)
                        .font(.system(size: 16))
                    Text(searchItem.longDescription)
                        .font(.system(size: 14))
                }
            }
            .padding(20)
        }
        .navigationTitle(searchItem.trackName ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .userActivity(SearchItemDetailView.searchItemUserActivityType,
                      isActive: searchItem.id == selectedItem) { userActivity in
            describeUserActivity(userActivity)
        }
    }
    
    func describeUserActivity(_ userActivity: NSUserActivity) {
        let localizedString =
            NSLocalizedString("ShowSearchItemTitle", comment: "Activity title with search item name")
        userActivity.title = String(format: localizedString, searchItem.trackName ?? searchItem.id)
        userActivity.isEligibleForHandoff = true
        userActivity.isEligibleForSearch = true
        userActivity.targetContentIdentifier = searchItem.id.description
        try? userActivity.setTypedPayload(searchItem)
    }
}

struct SearchItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SearchItemDetailView(searchItem: TestData.movies[4], selectedItem: .constant(nil))
    }
}
