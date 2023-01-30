//
//  WeatherReducer.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 30/01/23.
//

import Foundation

class WeatherReducer {
    static func reducer(_ state: WeatherState, _ action: Action) -> WeatherState {
        guard let action = action as? WeatherAction else { return .neverLoaded }
        var state = state
        switch action {
        case .loadLocation:
            state = .loadSuccessLocation(location: Location(latitude: .zero, longitude: .zero))
        }
        return state
    }
}
