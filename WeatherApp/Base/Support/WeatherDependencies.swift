//
//  WeatherDependencies.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 30/01/23.
//

import Foundation
import Resolver

public enum WeatherDependencies {
    public static func bindComponents() {
        
//        // MARK: - General class
//
        Resolver.register { LocationProvider(strategy: .coreLocation) as LocationProviderProtocol }

//        // MARK: - Environment
//        Resolver.register(name: .lulo) { EnvProvider(strategy: .lulo) as EnvProviderProtocol }
//        Resolver.register { EnvConfiguration() as ConfigurationProtocol }.scope(.cached)
        
//        // MARK: - Storage
        Resolver.register(name: .userDefaults) { StorageProvider(strategy: .userDefaults) as StorageProviderProtocol }.scope(.application)
        
        // MARK: - Store
        Resolver.register {
            Store(
                reducer: WeatherReducer.reducer,
                state: WeatherState.neverLoaded,
                middlewares: [
                    WeatherMiddleware.middleware()
                ]
            )
        }.scope(.cached)
    }
}

public extension Resolver.Name {
    static let userDefaults = Self("UserDefaults")
    static let coreData = Self("UserDefaults")
}
