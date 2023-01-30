//
//  SplashMiddleware.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 30/01/23.
//

import Foundation

class WeatherMiddleware {
    static func middleware() -> Middleware<WeatherState> {
        return { state, action, dispatch in
            guard let action = action as? WeatherAction else { return }
            
            switch action {
//            case .loadWeather:
//                return
            case .loadLocation:
                return dispatch(WeatherAction.loadLocation)
//            case let .searchLocation(location):
//                return
//            case let .findCity(city):
//                return
//            case .saveCity:
//                return
//            case .removeCity:
//                return
            }
        }
    }
}
