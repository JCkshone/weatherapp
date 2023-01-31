//
//  FindCityModel.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 31/01/23.
//

import Foundation

// MARK: - Welcome
struct FindCityModel: Decodable {
    let message, cod: String
    let count: Int
    let list: [WeatherResult]
}

// MARK: - List
struct WeatherResult: Decodable {
    let id: Int
    let name: String
    let coord: Coord
    let main: FindMain
    let dt: Int
    let wind: Wind
    let sys: Sys
    let clouds: Clouds
    let weather: [Weather]
}

// MARK: - Main
struct FindMain: Decodable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}
