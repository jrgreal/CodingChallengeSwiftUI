//
//  AppState.swift
//  CodingChallengeSwiftUI
//
//  Created by Reginald on 12/4/20.
//

import Foundation

struct AppState {
    static var lastVisitDate: Date? {
        get { UserDefaults.standard.object(forKey: Keys.lastVisitDateKey) as? Date }
        set { UserDefaults.standard.set(newValue, forKey: Keys.lastVisitDateKey) }
    }
    
    static var searchItems: [SearchItem] {
        get { decode(forKey: Keys.searchItems) ?? [] }
        set { encode(object: newValue, forKey: Keys.searchItems) }
    }
    
    private static func encode<T: Encodable>(object: T, forKey key: String) {
        let encoder = JSONEncoder()
        let encoded = try? encoder.encode(object)
        UserDefaults.standard.set(encoded, forKey: key)
    }
    
    private static func decode<T: Decodable>(forKey key: String) -> T? {
        guard let data = UserDefaults.standard.object(forKey: key) as? Data else {
            return nil
        }
        let decoder = JSONDecoder()
        let decoded = try? decoder.decode(T.self, from: data)
        return decoded
    }
}

extension AppState {
    struct Keys {
        static let lastVisitDateKey = "lastVisitDate"
        static let searchItems = "searchItems"
    }
}
