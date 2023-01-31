//
//  LocationProvider.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 30/01/23.
//

import Foundation

public protocol LocationProviderProtocol {
    var agent: LocationAgent { get }
}

public enum LocationStrategy {
    case coreLocation
}

public final class LocationProvider: LocationProviderProtocol {
    public let agent: LocationAgent

    public init(strategy: LocationStrategy) {
        switch strategy {
        case .coreLocation:
            agent = CLLocationAgent()
        }
    }
}
