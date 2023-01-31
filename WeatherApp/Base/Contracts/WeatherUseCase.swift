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

protocol GetForecastInfoUseCaseProtocol: AnyObject {
    func execute(lat: Double, long: Double) -> AnyPublisher<ApiResponse<ForecastDayModel>, WeatherError.Api>
}


// MARK: - Find City Use Cases
protocol SearchCityUseCaseProtocol: AnyObject {
    func execute(for search: String) -> AnyPublisher<ApiResponse<FindCityModel>, WeatherError.Api>
}
