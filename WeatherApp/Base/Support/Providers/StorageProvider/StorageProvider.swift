//
//  StorageProvider.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 30/01/23.
//

import Foundation

public protocol StorageProviderProtocol {
    var agent: StorageAgent { get }
}

public enum StorageStrategy {
    case userDefaults
}

public final class StorageProvider: StorageProviderProtocol {
    public let agent: StorageAgent

    public init(strategy: StorageStrategy) {
        switch strategy {
        case .userDefaults:
            agent = UserDefaultsAgent()
        }
    }
}
