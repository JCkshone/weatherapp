//
//  HomeAction.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 30/01/23.
//

import Foundation

enum HomeAction {
    case getCityWeather(lat: Double, lon: Double)
    case getCityWeatherWithActive(lat: Double, lon: Double)
    case getCityWeatherSuccess(_ result: HomeModel, _ foreCast: ForecastDayModel)
    case getCityWeatherFailure(_ error: Error)
}
