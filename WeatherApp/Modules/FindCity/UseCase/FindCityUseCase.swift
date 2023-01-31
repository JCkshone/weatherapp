//
//  FindCityUseCase.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 31/01/23.
//

import Foundation
import Combine
import Resolver

final class SearchCityUseCase: SearchCityUseCaseProtocol {
    @Injected var network: NetworkProviderProtocol
    
    func execute(for search: String) -> AnyPublisher<ApiResponse<FindCityModel>, WeatherError.Api> {
        network.agent.run(
            FindCityRouter(
                route: .search(search)
            )
        )
    }
}


enum FindCityRoute {
    case search(String)
}

protocol FindCityRouteable: WeatherRoutable {
    var route: FindCityRoute { get set }
}

extension FindCityRouteable {
    var baseUrl: URL {
        guard let url = URL(string: "https://openweathermap.org") else { fatalError("Base url could not be configured.") }
        return url
    }
    
    var queryParams: HttpQueryParams {
        var params = ["appid": "439d4b804bc8187953eb36d2a8c26a02"]
        
        switch route {
        case let .search(forSearch):
            params["q"] = "\(forSearch)"
        }
        
        return params
    }
    
    var path: String {
        switch route {
        case .search:
            return "/data/2.5/find"
        }
    }
    
    var method: HttpMethod {
        switch route {
        case .search:
            return .get
        }
    }
}

struct FindCityRouter: FindCityRouteable {
    var route: FindCityRoute
}
