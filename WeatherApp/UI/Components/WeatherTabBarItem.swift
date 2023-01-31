//
//  WeatherTabBarItem.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 29/01/23.
//

import Foundation
import SwiftUI

//struct WeatherTabBarItem: Hashable {
//    let iconName: String
//    let title: String
//    let color: Color
//}

enum WeatherTabBarItem: Hashable {
    case weather
    case myCities
    case searchCities
    
    var iconName: String {
        switch self {
        case .weather: return "cloud.sun.rain.fill"
        case .myCities: return "list.bullet"
        case .searchCities: return "map.fill"
        }
    }
    
    var title: String {
        switch self {
        case .weather: return ""
        case .myCities: return ""
        case .searchCities: return ""
        }
    }
    
    var color: Color {
        switch self {
        case .weather: return WeatherColor.gray.color
        case .myCities: return WeatherColor.gray.color
        case .searchCities: return WeatherColor.gray.color
        }
    }
}
