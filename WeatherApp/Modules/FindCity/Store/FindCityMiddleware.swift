//
//  FindCityMiddleware.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 31/01/23.
//

import Foundation
import Combine
import Resolver

enum FindCityMiddleware {
    @Injected private static var searchCityUseCase: SearchCityUseCaseProtocol
    
    static func executeGetWeatherInfo() -> Middleware<FindCityState, FindCityAction> {
        { _, action in
            guard case let .search(value) = action else { return Empty().eraseToAnyPublisher() }

            return searchCityUseCase
                .execute(for: value)
                .map { .searchCitySuccess($0.response) }
                .catch { log(error: $0, dispatch: .searchCityFailure($0)) }
                .eraseToAnyPublisher()
        }
    }
}

extension FindCityMiddleware {
    private static func log(error: Error, dispatch: FindCityAction) -> AnyPublisher<FindCityAction, Never> {
        debugPrint("[\(String(describing: self))] Causal: \(error)")
        return Just(dispatch).setFailureType(to: Never.self).eraseToAnyPublisher()
    }
}
