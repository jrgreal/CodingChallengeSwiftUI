//
//  TestData.swift
//  CodingChallengeSwiftUI
//
//  Created by Reginald on 12/2/20.
//

import Foundation

struct TestData {
    static var movies: [SearchItem] = {
        let url = Bundle.main.url(forResource: "Movies", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        let searchResult = try! decoder.decode(SearchResult.self, from: data)
        let movies = searchResult.results
        return movies
    }()
}
