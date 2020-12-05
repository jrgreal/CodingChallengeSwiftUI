//
//  RootView.swift
//  CodingChallengeSwiftUI
//
//  Created by Reginald on 12/1/20.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        NavigationView {
            SearchListView()
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
