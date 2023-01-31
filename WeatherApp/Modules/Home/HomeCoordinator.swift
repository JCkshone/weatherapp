//
//  HomeCoordinator.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 26/01/23.
//

import SwiftUI

enum HomeCoordinator: Router {
    case airConditions(AirConditionWithWeather)
    
    public var transition: NavigationType {
        switch self {
        case .airConditions:
            return .push
        }
    }
    
    @ViewBuilder
    public func view() -> some View {
        switch self {
        case let .airConditions(info):
            AirConditionScreenView(airCondition: info)
        }
    }
}
