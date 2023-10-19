//
//  UserDefaultsValues.swift
//  Croaster Admin
//
//  Created by UKUR KREASI on 15/08/23.
//

import Foundation

private let defaults = UserDefaults.standard

protocol SavableObject {
    static func setObject<Object>(_ object: Object, forKey: UserDefaultValues.Keys) throws where Object: Encodable
    static func getObject<Object>(forKey: UserDefaultValues.Keys, castTo type: Object.Type) throws -> Object where Object: Decodable
}

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T

    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            (defaults.object(forKey: key) as? T) ?? defaultValue
        }

        set {
            defaults.set(newValue, forKey: key)
        }
    }
}

struct UserDefaultValues {
    enum Keys: String, CaseIterable {
        case settings
    }

    private init() {}

    static func clear() {
        Keys.allCases.forEach { key in
            defaults.removeObject(forKey: key.rawValue)
        }
    }

    static func deleteValue(forKey key: Keys) {
        defaults.removeObject(forKey: key.rawValue)
    }

    static func printsAllValues() {
        Keys.allCases.forEach { key in
            debugPrint(defaults.object(forKey: key.rawValue) as Any)
        }
    }
}

extension UserDefaultValues: SavableObject {
    static func setObject<Object>(_ object: Object, forKey: UserDefaultValues.Keys) throws where Object: Encodable {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            defaults.set(data, forKey: forKey.rawValue)
        } catch {
            throw ObjectSavableError.unableToEncode
        }
    }

    static func getObject<Object>(forKey: UserDefaultValues.Keys, castTo type: Object.Type) throws -> Object where Object: Decodable {
        guard let data = defaults.data(forKey: forKey.rawValue) else { throw ObjectSavableError.noValue }
        let decoder = JSONDecoder()
        do {
            let object = try decoder.decode(type, from: data)
            return object
        } catch {
            throw ObjectSavableError.unableToDecode
        }
    }
}

enum ObjectSavableError: String, LocalizedError {
    case unableToEncode = "Unable to encode object into data"
    case noValue = "No data object found for the given key"
    case unableToDecode = "Unable to decode object into given type"

    var errorDescription: String? {
        rawValue
    }
}
