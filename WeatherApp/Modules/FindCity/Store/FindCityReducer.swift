//
//  FindCityReducer.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 31/01/23.
//

import Foundation

enum FindCityReducer {
    static func reduce(
        state: inout FindCityState,
        action: FindCityAction
    ) {
        switch action {
        case .search:
            state = .searching
        case let .searchCitySuccess(response):
            state = .resultOfSearch(response)
        case let .searchCityFailure(error):
            state = .withError(error)
        }
    }
}
