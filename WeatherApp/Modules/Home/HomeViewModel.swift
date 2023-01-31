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
    let icon: String
}

struct AirConditionToday {
    let temp: String
    let windSpeed: String
}

struct ForecastDayWithIcon {
    let day: String
    let icon: String
    let weatherName: String
    let temp: String
    let realTemp: String
}

class HomeViewModel: ObservableObject {
    @Published var viewState: HomeViewState = .isLoading
    @Published var weatherInfo: HomeModel? = nil
    @Published var temp: String = ""
    @Published var icon: String = ""
    @Published var forecastToday: [ForecastToday] = []
    @Published var forecastDays: [ForecastDayWithIcon] = []
    @Published var airCondition: ForecastCurrent? = nil
    
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
    
    func getAirConditionInfo() -> AirConditionWithWeather {
        AirConditionWithWeather(
            title: weatherInfo?.name ?? .empty,
            icon: icon,
            temp: temp,
            uv: "\(airCondition?.uvi ?? .zero)",
            wind: "\(airCondition?.windSpeed ?? .zero) km/h",
            humidity: "\(airCondition?.humidity ?? .zero) %",
            feelsLike: "\(airCondition?.feelsLike ?? .zero)°",
            visibility: "\((airCondition?.visibility ?? .zero)/1000) km",
            pressure: "\(airCondition?.pressure ?? .zero) hPa"
        )
    }
    
    // MARK: - Suscribe
    func suscribeStore() {
        store.$state.sink { [weak self] state in
            guard let self = self else { return }
            switch state {
            case let .loadedWeatherInfo(info, forecast):
                self.forecastToday = forecast.hourly.map {
                    ForecastToday(
                        time: "\($0.dt)".getTime(),
                        temp: self.convertToCelsius($0.temp),
                        icon: self.loadIcon(weathers: $0.weather)
                    )
                }
                
                self.forecastDays = forecast.daily.map {
                    ForecastDayWithIcon(
                        day: "\($0.dt)".getDay(),
                        icon: self.loadIcon(weathers: $0.weather),
                        weatherName: $0.weather.first?.main ?? .empty,
                        temp: self.convertToCelsius($0.temp.day, addCelsius: false).components(separatedBy: ".").first ?? .empty,
                        realTemp: self.convertToCelsius($0.feelsLike.day, addCelsius: false).components(separatedBy: ".").first ?? .empty
                    )
                }
                self.weatherInfo = info
                self.temp = self.convertToCelsius(info.main.temp)
                self.icon = self.loadIcon(weathers: info.weather)
                self.viewState = .showWeather
                self.airCondition = forecast.hourly.first
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
    
    func convertToCelsius(_ value: Double, addCelsius: Bool = true) -> String {
        let t = Measurement(value: value, unit: UnitTemperature.kelvin)
        return "\(round(t.converted(to: UnitTemperature.celsius).value))" + (addCelsius ? "°C" : .empty)
    }
    
    func loadIcon(weathers: [Weather]) -> String {
        guard let weather = weathers.first else {
            return "01"
        }
        
        return weather.icon.digits
    }
}
