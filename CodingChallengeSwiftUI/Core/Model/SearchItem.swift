//
//  SearchItem.swift
//  CodingChallengeSwiftUI
//
//  Created by Reginald on 12/1/20.
//

import Foundation
import UIKit

struct SearchItem: Identifiable {
    var id: Int { trackId }
    
    let wrapperType: String
    let trackId: Int
    let trackName: String?
    let kind: String?
    let artistName: String?
    let collectionName: String?
    let trackPrice: Double?
    let trackRentalPrice: Double?
    let trackHDPrice: Double?
    let trackHDRentalPrice: Double?
    let currency: String
    let primaryGenre: String
    let longDescription: String
    let artwork: URL?
}

extension SearchItem: Codable {
    enum CodingKeys: String, CodingKey {
        case wrapperType
        case trackId
        case trackName
        case kind
        case artistName
        case collectionName
        case trackPrice
        case trackRentalPrice
        case trackHDPrice = "trackHdPrice"
        case trackHDRentalPrice = "trackHdRentalPrice"
        case currency
        case primaryGenre = "primaryGenreName"
        case longDescription
        case artwork = "artworkUrl100"
    }
}

struct SimpleStruct {
    let id: Int
    let name: String
}
