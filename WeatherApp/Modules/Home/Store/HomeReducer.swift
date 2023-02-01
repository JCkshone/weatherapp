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
        case .getCityWeather, .getCityWeatherWithActive:
            state = .loadingWeatherInfo
        
        case let .getCityWeatherSuccess(info, forecast):
            state = .loadedWeatherInfo(info, forecast)
            
        case let .getCityWeatherFailure(error):
            state = .withError(error)
        }
    }
}
