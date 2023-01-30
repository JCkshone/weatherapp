//
//  WeatherState.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 30/01/23.
//

import Foundation

enum WeatherState: ReduxState {
    case neverLoaded
    case loadSuccessLocation(location: Location)
    case loadErrorLocation
    case saveSuccessCity
    case saveErrorCity
    case loadSuccessWeather
    case loadErrorWeather
}
