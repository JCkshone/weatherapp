//
//  WeatherApiEnums.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 30/01/23.
//

import Foundation

public enum HttpMethod: String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case delete = "DELETE"
}

enum WeatherError {
    enum Api: Error {
        case invalidUrl(url: String)
        case undefined
        case noInternet
        case invalidResponse
        case timeOut
        case invalidDecodableModel
    }
    enum CoreData: Error {
        case objectNotFound
    }
}
