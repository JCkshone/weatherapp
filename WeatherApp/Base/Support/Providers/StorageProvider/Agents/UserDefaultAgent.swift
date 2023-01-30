//
//  UserDefaultAgent.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 30/01/23.
//

import Foundation

final class UserDefaultsAgent: StorageAgent {
    private let userDefaults: UserDefaults

    init() {
        userDefaults = UserDefaults.standard
    }

    func set(_ value: Int, forKey key: String) {
        userDefaults.set(value, forKey: key)
    }

    func set(_ value: Bool, forKey key: String) {
        userDefaults.set(value, forKey: key)
    }

    func set(_ value: Double, forKey key: String) {
        userDefaults.set(value, forKey: key)
    }

    func set(_ value: String, forKey key: String) {
        userDefaults.set(value, forKey: key)
    }

    func set<T>(_ object: T, forKey key: String) where T: Encodable {
        if let encodedData = try? JSONEncoder().encode(object) {
            userDefaults.set(encodedData, forKey: key)
        } else {
            debugPrint("[UserDefaultsAgent] Failed to encode key \(key)")
        }
    }

    func integer(forKey key: String) -> Int? {
        isKeyExist(key: key) ? userDefaults.integer(forKey: key) : .none
    }

    func bool(forKey key: String) -> Bool {
        isKeyExist(key: key) ? userDefaults.bool(forKey: key) : false
    }

    func double(forKey key: String) -> Double? {
        isKeyExist(key: key) ? userDefaults.double(forKey: key) : .none
    }

    func string(forKey key: String) -> String? {
        isKeyExist(key: key) ? userDefaults.string(forKey: key) : .none
    }

    func object<T>(type: T.Type, forKey key: String) -> T? where T: Decodable {
        guard let decodedData = userDefaults.data(forKey: key) else { return nil }
        if let object = try? JSONDecoder().decode(type, from: decodedData) {
            return object
        } else {
            debugPrint("[UserDefaultsAgent] Failed to decode key \(key)")
            return nil
        }
    }

    func hasValue(forKey key: String) -> Bool {
        isKeyExist(key: key)
    }

    func remove(key: String) {
        userDefaults.removeObject(forKey: key)
    }

    func removeAllKeys() {
        guard let domain = Bundle.main.bundleIdentifier else { return }
        userDefaults.removePersistentDomain(forName: domain)
        userDefaults.synchronize()
    }
}

private extension UserDefaultsAgent {
    func isKeyExist(key: String) -> Bool {
        UserDefaults.standard.object(forKey: key) != nil
    }
}
