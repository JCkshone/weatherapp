//
//  StorageAgent.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 30/01/23.
//

import Foundation

public protocol StorageAgent: AnyObject {
    func set(_ value: Int, forKey key: String)
    func set(_ value: Bool, forKey key: String)
    func set(_ value: Double, forKey key: String)
    func set(_ value: String, forKey key: String)
    func set<T: Encodable>(_ object: T, forKey key: String)

    func integer(forKey key: String) -> Int?
    func bool(forKey key: String) -> Bool
    func double(forKey key: String) -> Double?
    func string(forKey key: String) -> String?
    func object<T: Decodable>(type: T.Type, forKey key: String) -> T?

    func hasValue(forKey key: String) -> Bool
    func remove(key: String)
    func removeAllKeys()
}
