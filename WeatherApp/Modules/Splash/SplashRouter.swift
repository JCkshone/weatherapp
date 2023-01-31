//
//  SplashRouter.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 26/01/23.
//

import SwiftUI

enum SplashRouter: Router {
    case splash
    case home
    case airCondition(with: AirConditionWithWeather)
    
    public var transition: NavigationType {
        switch self {
        case .splash:
            return .push
        case .home:
            return .push
        case .airCondition:
            return .default
        }
    }
    
    @ViewBuilder
    public func view() -> some View {
        
        switch self {
        case .splash:
            SplashScreenView()
        case .home:
            HomeScreenView()
            
        case let .airCondition(info):
            AirConditionScreenView(
                airCondition: info
            )
        }
    }
}
