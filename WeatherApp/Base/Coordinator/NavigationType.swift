//
//  NavigationType.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 25/01/23.
//

import Foundation
import UIKit

public enum NavigationType {
    case `default`
    case push
    case presentModally
    case presentFullscreen
}

extension NavigationType {
    var presentationStyle: UIModalPresentationStyle {
        switch self {
        case .push, .default:
            return .none
        case .presentModally:
            return .formSheet
        case .presentFullscreen:
            return .fullScreen
        }
    }
}
