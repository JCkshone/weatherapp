//
//  HomeUseCase.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 30/01/23.
//

import Foundation
import Combine
import Resolver

final class GetWeatherInfoUseCase: GetWeatherInfoUseCaseProtocol {
    @Injected var network: NetworkProviderProtocol
    
    func execute(lat: Double, long: Double) -> AnyPublisher<ApiResponse<HomeModel>, WeatherError.Api> {
        network.agent.run(
            HomeRouter(
                route: .getWeatherInfo(lat: lat, long: long)
            )
        )
    }
}

final class GetForecastInfoUseCase: GetForecastInfoUseCaseProtocol {
    @Injected var network: NetworkProviderProtocol
    
    func execute(lat: Double, long: Double) -> AnyPublisher<ApiResponse<ForecastDayModel>, WeatherError.Api> {
        network.agent.run(
            HomeRouter(
                route: .getForecastInfo(lat: lat, long: long)
            )
        )
    }
}



enum HomeRoute {
    case getWeatherInfo(lat: Double, long: Double)
    case getForecastInfo(lat: Double, long: Double)
}

protocol HomeRouteable: WeatherRoutable {
    var route: HomeRoute { get set }
}

extension HomeRouteable {
    
    var queryParams: HttpQueryParams {
        var params = ["appid": "050bfe64cd43a9d0d9f4dd747100ddd4"]
        
        switch route {
        case let .getWeatherInfo(lat, long):
            params["lat"] = "\(lat)"
            params["lon"] = "\(long)"
        case let .getForecastInfo(lat, long):
            params["lat"] = "\(lat)"
            params["lon"] = "\(long)"
        }
        
        return params
    }
    
    var path: String {
        switch route {
        case .getWeatherInfo:
            return "/data/2.5/weather"
        case .getForecastInfo:
            return "/data/3.0/onecall"
        }
    }
    
    var method: HttpMethod {
        switch route {
        case .getWeatherInfo, .getForecastInfo:
            return .get
        }
    }
}

struct HomeRouter: HomeRouteable {
    var route: HomeRoute
}
