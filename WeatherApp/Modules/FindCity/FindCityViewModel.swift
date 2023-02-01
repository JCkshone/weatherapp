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
import CoreData

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
    @Injected var coreData: CoreDataAgent<WeatherCityCore>
    
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
        coreData.add { model in
            model.lat = info.coord.lat
            model.long = info.coord.lon
            model.name = info.name.components(separatedBy: " ").first ?? self.searchValue
            model.active = false
            model.temp = self.convertToCelsius(info.main.temp, addCelsius: false)
            model.canDelete = true
        }.sink { completion in
            switch completion {
            case .failure(let error):
                debugPrint("an error occurred \(error.localizedDescription)")
            case .finished:
                break
            }
        } receiveValue: { reponse in
            self.showConfirmation = true
            debugPrint("todo has been added")
        }.store(in: &cancellables)
    }
    
    func convertToCelsius(_ value: Double, addCelsius: Bool = true) -> String {
        let t = Measurement(value: value, unit: UnitTemperature.kelvin)
        let value = "\(round(t.converted(to: UnitTemperature.celsius).value))" + (addCelsius ? "°C" : .empty)
        return "\(value.components(separatedBy: ".").first ?? .empty)°"
    }
}
