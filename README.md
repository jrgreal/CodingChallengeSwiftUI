
# CodingChallengeSwiftUI
An application that lists all items retrieved from the iTunes Search API given some predefined parameters, 
and capable of showing a detailed view of each item.

Below are some explanations to the choices I made in implementing the features of this app.

## Persistence

### UserDefaults
I opted to use UserDefaults because of its simplicity and straghtforward use. It is used in storing last visit date and 
the latest search items fetched from the API. In the case of the search items, it is encoded using JSONEncoder
before storing it in UserDefaults as Data.

```
    static var searchItems: [SearchItem] {
        get { decode(forKey: Keys.searchItems) ?? [] }
        set { encode(object: newValue, forKey: Keys.searchItems) }
    }
    
    ...
    
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
```

### SceneStorage
Apple has already provided state preservation and restoration in SwiftUI via the @SceneStorage property wrapper. It will
be used to store the state of the user interface which will be set on relaunch.



## Architecture

### Model-View-ViewModel (MVVM)
In SwiftUI, we can take advantage of MVVM because of the built in property wrappers. SearchListViewModel conforms to the ObservableObject
protocol, and whenever its Published properties are updated, it notifies the observers of the changes. In the case of searchItems property,
it is updated when new data is fetched from the API. SearchListView will then update its views to reflect the changes.

### Decorator
Extensions are, in a way, decorators because they additional behavior and functionalities to classes, structs and enums.
An example if this is the Date type that I extendend to add a computed property of its string representation in a given format.

```
extension Date {
    /// A string representation of the date
    var dateText: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        let formatted = formatter.string(from: self)
        return formatted
    }
}
```

