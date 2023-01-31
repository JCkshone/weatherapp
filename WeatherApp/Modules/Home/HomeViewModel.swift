//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 30/01/23.
//

import Foundation

import Combine
import SwiftUI
import Resolver
import CoreLocation


enum HomeViewState {
    case showWeather
    case isLoading
}

struct ForecastToday {
    let time: String
    let temp: String
}

class HomeViewModel: ObservableObject {
    @Published var viewState: HomeViewState = .isLoading
    @Published var weatherInfo: HomeModel? = nil
    @Published var temp: String = ""
    @Published var forecastToday: [ForecastToday] = []
    
    @Injected var locationProvider: LocationProviderProtocol
    @Injected var store: Store<HomeState, HomeAction>
    
    private var cancellables = Set<AnyCancellable>()

    deinit {
        cancellables.removeAll()
    }
    func viewDidLoad() {
        suscribeStore()
        triggerWeather()
    }
}

extension HomeViewModel {
    
    // MARK: - Suscribe
    func suscribeStore() {
        store.$state.sink { [weak self] state in
            guard let self = self else { return }
            switch state {
            case let .loadedWeatherInfo(info):
                self.weatherInfo = info
                self.viewState = .showWeather
                self.convertToCelsius(info.main.temp ?? .zero)
            default:
                break
            }
        }.store(in: &cancellables)
        
    }
    
    func triggerWeather() {
        locationProvider.agent.loadLocation()
        locationProvider.agent.location.sink { [weak self] location in
            guard let self = self, let coordinate = location?.coordinate else { return }
            self.store.dispatch(.getCityWeather(lat: coordinate.latitude, lon: coordinate.longitude))
        }
        .store(in: &cancellables)
    }
    
    func updateWeather() {
        //store.dispatch(action: WeatherAction.loadLocation)
        locationProvider.agent.location.sink { location in
            
        }
        .store(in: &cancellables)
    }
    
    func convertToCelsius(_ value: Double) {
        let t = Measurement(value: value, unit: UnitTemperature.kelvin)
        temp = "\(round(t.converted(to: UnitTemperature.celsius).value))°C"
    }
}
