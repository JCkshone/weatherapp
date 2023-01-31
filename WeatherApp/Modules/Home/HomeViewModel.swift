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
            case let .loadedWeatherInfo(info, forecast):
                self.forecastToday = forecast.hourly.map {
                    ForecastToday(time: "\($0.dt)", temp: self.convertToCelsius($0.temp))
                }
                self.weatherInfo = info
                self.temp = self.convertToCelsius(info.main.temp)
                self.viewState = .showWeather
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
        locationProvider.agent.location.sink { location in
            
        }
        .store(in: &cancellables)
    }
    
    func convertToCelsius(_ value: Double) -> String {
        let t = Measurement(value: value, unit: UnitTemperature.kelvin)
        return "\(round(t.converted(to: UnitTemperature.celsius).value))°C"
    }
}
