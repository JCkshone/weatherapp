//
//  WeatherUseCase.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 30/01/23.
//

import Combine

// MARK: - Home Use Cases

protocol GetWeatherInfoUseCaseProtocol: AnyObject {
    func execute(lat: Double, long: Double) -> AnyPublisher<ApiResponse<HomeModel>, WeatherError.Api>
}
