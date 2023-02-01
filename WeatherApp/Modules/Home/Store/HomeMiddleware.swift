//
//  HomeMiddleware.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 30/01/23.
//

import Foundation

import Combine
import Resolver
import CoreData

enum HomeMiddleware {
    @Injected private static var getWeatherInfoUseCase: GetWeatherInfoUseCaseProtocol
    @Injected private static var getForeCastInfoUseCase: GetForecastInfoUseCaseProtocol
    @Injected private static var coreData: CoreDataAgent<WeatherCityCore>
    @Injected(name: .userDefaults) private static var userPreferences: StorageProviderProtocol
    
    static func executeGetWeatherInfo() -> Middleware<HomeState, HomeAction> {
        { _, action in
            guard case let .getCityWeather(lat, lon) = action else { return Empty().eraseToAnyPublisher() }

            return getWeatherInfoUseCase
                .execute(lat: lat, long: lon)
                .flatMap { weather -> AnyPublisher<HomeModel, WeatherError.Api> in
                    userPreferences.agent.set(true, forKey: "active")
                    return coreData.add { model in
                        model.lat = weather.response.coord.lat
                        model.long = weather.response.coord.lon
                        model.name = weather.response.name
                        model.active = false
                        model.temp = convertToCelsius(weather.response.main.temp) + "°"
                        model.canDelete = false
                    }.map { _ in
                        return weather.response
                    }.eraseToAnyPublisher()
                }
                .map { weather -> AnyPublisher<(HomeModel, ForecastDayModel), WeatherError.Api> in
                    return executeGetForecastInfo(lat: lat, lon: lon)
                        .map { (weather, $0.response) }
                        .eraseToAnyPublisher()
                }
                .switchToLatest()
                .map { .getCityWeatherSuccess($0, $1) }
                .catch { log(error: $0, dispatch: .getCityWeatherFailure($0)) }
                .eraseToAnyPublisher()
        }
    }
    
    static func executeGetWeatherActiveInfo() -> Middleware<HomeState, HomeAction> {
        { _, action in
            guard case let .getCityWeatherWithActive(lat, lon) = action else { return Empty().eraseToAnyPublisher() }

            return getWeatherInfoUseCase
                .execute(lat: lat, long: lon)
                .map { weather -> AnyPublisher<(HomeModel, ForecastDayModel), WeatherError.Api> in
                    return executeGetForecastInfo(lat: lat, lon: lon)
                        .map { (weather.response, $0.response) }
                        .eraseToAnyPublisher()
                }
                .switchToLatest()
                .map { .getCityWeatherSuccess($0, $1) }
                .catch { log(error: $0, dispatch: .getCityWeatherFailure($0)) }
                .eraseToAnyPublisher()
        }
    }
    
    private static func executeGetForecastInfo(lat: Double, lon: Double) -> AnyPublisher<ApiResponse<ForecastDayModel>, WeatherError.Api> {
        getForeCastInfoUseCase.execute(lat: lat, long: lon)
            .eraseToAnyPublisher()
    }
    private static func convertToCelsius(_ value: Double) -> String {
        let t = Measurement(value: value, unit: UnitTemperature.kelvin)
        return "\(round(t.converted(to: UnitTemperature.celsius).value))".components(separatedBy: ".").first ?? .empty
    }
}

extension HomeMiddleware {
    private static func log(error: Error, dispatch: HomeAction) -> AnyPublisher<HomeAction, Never> {
        debugPrint("[\(String(describing: self))] Causal: \(error)")
        return Just(dispatch).setFailureType(to: Never.self).eraseToAnyPublisher()
    }
}
