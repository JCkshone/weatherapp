//
//  HomeState.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 30/01/23.
//

import Foundation

enum HomeState {
    case neverLoaded
    case loadingWeatherInfo
    case loadedWeatherInfo(HomeModel)
    
    case loadingForecastInfo
    case loadedForecastInfo(ForecastDayModel)
    case withError(Error)
}
