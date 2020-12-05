//
//  CodingChallengeSwiftUIApp.swift
//  CodingChallengeSwiftUI
//
//  Created by Reginald on 11/30/20.
//

import SwiftUI

@main
struct CodingChallengeSwiftUIApp: App {
    private var searchListModel = SearchListViewModel()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(searchListModel)
        }
    }
}
