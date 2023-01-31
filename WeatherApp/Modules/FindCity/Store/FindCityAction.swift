//
//  FindCityAction.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 31/01/23.
//

import Foundation

enum FindCityAction {
    case search(String)
    case searchCitySuccess(_ findResponse: FindCityModel)
    case searchCityFailure(_ error: Error)
}
