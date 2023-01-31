//
//  FindCityViewModel.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 29/01/23.
//

import Foundation
import Combine
import MapKit
import Resolver

enum FindCityViewState {
    case showResults
    case isLoading
}

class FindCityViewModel: ObservableObject {
    @Published var response: FindCityModel?
    @Published var searchValue: String = ""
    @Published var viewState: HomeViewState = .showWeather
    @Published var showConfirmation: Bool = false
    
    @Injected var store: Store<FindCityState, FindCityAction>
    
    private var cancellables = Set<AnyCancellable>()

    deinit {
        cancellables.removeAll()
    }
    
    func viewDidLoad() {
        suscribeStore()
    }
}

extension FindCityViewModel {
    // MARK: - Suscribe
    func suscribeStore() {
        store.$state.sink { [weak self] state in
            guard let self = self else { return }
            switch state {
            case let .resultOfSearch(response):
                self.response = response
                self.viewState = .showWeather
            case .withError:
                self.viewState = .showWeather
            default: break
            }
        }.store(in: &cancellables)
        
    }
    
    func searchExecution() {
        viewState = .isLoading
        store.dispatch(.search(searchValue))
    }
    
    func saveCity(with info: WeatherResult) {
        print(info)
        showConfirmation = true
    }
}
