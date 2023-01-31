//
//  FindCityState.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 31/01/23.
//

import Foundation

enum FindCityState {
    case neverLoaded
    case searching
    case resultOfSearch(FindCityModel)
    case withError(Error)
}
