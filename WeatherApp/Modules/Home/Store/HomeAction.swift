//
//  HomeAction.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 30/01/23.
//

import Foundation

enum HomeAction {
    case getCityWeather(lat: Double, lon: Double)
    case getCityWeatherSuccess(_ result: HomeModel)
    case getCityWeatherFailure(_ error: Error)
    
    case getForecastCity(lat: Double, lon: Double)
    case getForecastCitySuccess(_ result: ForecastDayModel)
    case getForecastCityFailure(_ error: Error)
}
