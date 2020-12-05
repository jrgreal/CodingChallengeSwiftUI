//
//  SearchItemOverview.swift
//  CodingChallengeSwiftUI
//
//  Created by Reginald on 12/2/20.
//

import SwiftUI
import KingfisherSwiftUI

struct SearchItemOverview: View {
    let artworkUrl: URL?
    let trackName: String
    let genre: String
    let sdBuyPrice: String?
    let hdBuyPrice: String?
    let sdRentPrice: String?
    let hdRentPrice: String?
    let currency: String
    
    var body: some View {
        HStack(spacing: 16) {
            KFImage(artworkUrl).placeholder {
                Image("placeholder")
            }
            .aspectRatio(contentMode: .fill)
            .frame(width: 75, height: 100)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(trackName)
                    .font(.system(size: 16))
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                Text(genre)
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
                HStack {
                    Spacer()
                    PriceView(sdBuyPrice: sdBuyPrice, hdBuyPrice: hdBuyPrice, sdRentPrice: sdRentPrice, hdRentPrice: hdRentPrice, currency: currency)
                }
            }
        }
        .padding(.vertical, 8)
    }
}

extension SearchItemOverview {
    init(searchItem: SearchItem) {
        self.artworkUrl = searchItem.artwork
        self.trackName = searchItem.trackName ?? ""
        self.genre = searchItem.primaryGenre
        self.sdBuyPrice = searchItem.trackPrice.map({$0.description})
        self.hdBuyPrice = searchItem.trackHDPrice.map({$0.description})
        self.sdRentPrice = searchItem.trackRentalPrice.map({$0.description})
        self.hdRentPrice = searchItem.trackHDRentalPrice.map({$0.description})
        self.currency = searchItem.currency
    }
}

struct SearchItemOverview_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchItemOverview(searchItem: TestData.movies.first!)
            SearchItemOverview(searchItem: TestData.movies.last!)
        }
        .previewLayout(.sizeThatFits)
    }
}
