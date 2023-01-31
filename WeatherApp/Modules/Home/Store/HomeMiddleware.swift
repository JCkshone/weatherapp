//
//  HomeMiddleware.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 30/01/23.
//

import Foundation

import Combine
import Resolver

enum HomeMiddleware {
    @Injected private static var getWeatherInfoUseCase: GetWeatherInfoUseCaseProtocol
    
    static func executeGetWeatherInfo() -> Middleware<HomeState, HomeAction> {
        { _, action in
            guard case let HomeAction.getCityWeather(lat, lon) = action else { return Empty().eraseToAnyPublisher() }

            return getWeatherInfoUseCase
                .execute(lat: lat, long: lon)
                .map { .getCityWeatherSuccess($0.response) }
                .catch { log(error: $0, dispatch: .getCityWeatherFailure($0)) }
                .eraseToAnyPublisher()
        }
    }
}

extension HomeMiddleware {
    private static func log(error: Error, dispatch: HomeAction) -> AnyPublisher<HomeAction, Never> {
        debugPrint("[\(String(describing: self))] Causal: \(error)")
        return Just(dispatch).setFailureType(to: Never.self).eraseToAnyPublisher()
    }
}
