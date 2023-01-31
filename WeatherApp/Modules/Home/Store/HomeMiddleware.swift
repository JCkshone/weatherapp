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
    @Injected private static var getForeCastInfoUseCase: GetForecastInfoUseCaseProtocol
    
    static func executeGetWeatherInfo() -> Middleware<HomeState, HomeAction> {
        { _, action in
            guard case let .getCityWeather(lat, lon) = action else { return Empty().eraseToAnyPublisher() }

            return getWeatherInfoUseCase
                .execute(lat: lat, long: lon)
                .map { weather -> AnyPublisher<(HomeModel, ForecastDayModel), WeatherError.Api> in
                    return executeGetForecastInfo(lat: lat, lon: lon)
                        .map { (weather.response, $0.response)}
                        .eraseToAnyPublisher()
                }
                .switchToLatest()
                .map { .getCityWeatherSuccess($0, $1) }
                .catch { log(error: $0, dispatch: .getCityWeatherFailure($0)) }
                .eraseToAnyPublisher()
        }
    }
    
    static func executeGetForecastInfo(lat: Double, lon: Double) -> AnyPublisher<ApiResponse<ForecastDayModel>, WeatherError.Api> {
        getForeCastInfoUseCase.execute(lat: lat, long: lon)
            .eraseToAnyPublisher()
    }
}

extension HomeMiddleware {
    private static func log(error: Error, dispatch: HomeAction) -> AnyPublisher<HomeAction, Never> {
        debugPrint("[\(String(describing: self))] Causal: \(error)")
        return Just(dispatch).setFailureType(to: Never.self).eraseToAnyPublisher()
    }
}
