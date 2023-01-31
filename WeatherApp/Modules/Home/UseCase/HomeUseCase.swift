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



enum HomeRoute {
    case getWeatherInfo(lat: Double, long: Double)
}

protocol HomeRouteable: WeatherRoutable {
    var route: HomeRoute { get set }
}

extension HomeRouteable {
    
    var queryParams: HttpQueryParams {
        switch route {
        case let .getWeatherInfo(lat, long):
            return [
                "appid": "050bfe64cd43a9d0d9f4dd747100ddd4",
                "lat": "\(lat)",
                "lon": "\(long)"
            ]
        }
    }
    
    var path: String {
        switch route {
        case .getWeatherInfo:
            return "/data/2.5/weather"
        }
    }
    
    var method: HttpMethod {
        switch route {
        case .getWeatherInfo:
            return .get
        }
    }
}

struct HomeRouter: HomeRouteable {
    var route: HomeRoute
}
