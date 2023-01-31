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
        
        // MARK: - General class

        Resolver.register { LocationProvider(strategy: .coreLocation) as LocationProviderProtocol }
        
        // MARK: - Network
        Resolver.register { NetworkProvider() as NetworkProviderProtocol }

        // MARK: - Use Cases
        Resolver.register { GetWeatherInfoUseCase() as GetWeatherInfoUseCaseProtocol }
        Resolver.register { GetForecastInfoUseCase() as GetForecastInfoUseCaseProtocol }

        
        // MARK: - Storage
        Resolver.register(name: .userDefaults) { StorageProvider(strategy: .userDefaults) as StorageProviderProtocol }.scope(.application)
        
        // MARK: - Stores
        
        Resolver.register {
            Store<HomeState, HomeAction>(
                state: .neverLoaded,
                reducer: HomeReducer.reduce(state:action:),
                middlewares: [
                    HomeMiddleware.executeGetWeatherInfo(),
                ]
            )
        }.scope(.cached)
    }
}

public extension Resolver.Name {
    static let userDefaults = Self("UserDefaults")
    static let coreData = Self("UserDefaults")
}
