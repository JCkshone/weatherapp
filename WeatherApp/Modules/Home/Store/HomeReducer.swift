//
//  HomeReducer.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 30/01/23.
//

import Foundation

enum HomeReducer {
    static func reduce(state: inout HomeState, action: HomeAction) {
        switch action {
        case .getCityWeather:
            state = .loadingWeatherInfo
        
        case let .getCityWeatherSuccess(info):
            state = .loadedWeatherInfo(info)
            
        case let .getCityWeatherFailure(error):
            state = .withError(error)
            
        case .getForecastCity:
            state = .loadingForecastInfo
            
        case let .getForecastCitySuccess(info):
            state = .loadedForecastInfo(info)
            
        case let .getForecastCityFailure(error):
            state = .withError(error)
        }
    }
}
