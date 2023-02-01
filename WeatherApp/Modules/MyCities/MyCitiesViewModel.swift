//
//  MyCitiesViewModel.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 31/01/23.
//

import Foundation
import Combine
import CoreData
import Resolver

enum MyCitiesViewState {
    case showResults
    case isLoading
}

struct MyCitiesItem {
    let name: String
    let lat: Double
    let lon: Double
    let temp: String
    var isFirst: Bool
    let canDelete: Bool
    let entity: WeatherCityCore
}

class MyCitiesViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    private var originalCities: [MyCitiesItem] = []

    @Published var cities: [MyCitiesItem] = []
    @Published var searchValue: String = .empty
    
    @Injected var coreData: CoreDataAgent<WeatherCityCore>
    @Injected(name: .userDefaults) private var userPreferences: StorageProviderProtocol
    
    private var currentLocation: ActiveLocation {
        guard let location = userPreferences.agent.object(
            type: ActiveLocation.self,
            forKey: String(describing: ActiveLocation.self)
        ) else {
            return ActiveLocation(lat: .zero, lon: .zero)
        }
        return location
    }
    
    deinit {
        cancellables.removeAll()
    }
    
    func viewDidLoad() {
        suscribeEvents()
        loadCities()
    }
}

extension MyCitiesViewModel {
    // MARK: - Suscribers
    func suscribeEvents() {
        $searchValue.sink { value in
            self.cities = value.isEmpty ? self.originalCities : self.originalCities.filter { $0.name.lowercased().contains(value.lowercased()) }
        }.store(in: &cancellables)
    }
    
    func loadCities() {
        coreData.fetch(sortDescriptors: [NSSortDescriptor(keyPath: \WeatherCityCore.active, ascending: true)])
            .replaceError(with: [])
            .sink { cities in
                self.originalCities = cities.map {
                    let equalLat = self.getLocation(with: $0.lat) == self.getLocation(with: self.currentLocation.lat)
                    let equalLon = self.getLocation(with: $0.long) == self.getLocation(with: self.currentLocation.lon)
                    
                    return MyCitiesItem(
                        name: $0.name ?? .empty,
                        lat: $0.lat,
                        lon: $0.long,
                        temp: $0.temp ?? .empty,
                        isFirst: equalLat && equalLon,
                        canDelete: $0.canDelete,
                        entity: $0
                    )
                }
                self.cities = self.originalCities
            }.store(in: &cancellables)
    }
    
    func delete(entity: WeatherCityCore) {
        coreData.delete(entity)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    debugPrint("an error occurred \(error.localizedDescription)")
                case .finished:
                    self.loadCities()
                }
            } receiveValue: { _ in }
            .store(in: &cancellables)
    }
    
    func changeActivation(lat: Double, lon: Double) {
        if let currentIndex = getIndex(lat: currentLocation.lat, lon: currentLocation.lon) {
            originalCities[currentIndex].isFirst = false
        }
        
        if let nextIndex = getIndex(lat: lat, lon: lon) {
            originalCities[nextIndex].isFirst = true
        }
        
        cities = originalCities
        saveLocation(lat: lat, lon: lon)
    }
    
    func getIndex(lat: Double, lon: Double) -> Int? {
        originalCities.firstIndex {
            getLocation(
                with: $0.entity.lat
            ) == getLocation(with: lat) &&
            getLocation(
                with: $0.entity.long
            ) == getLocation(with: lon)
        }
    }
    
    func getLocation(with location: Double) -> Double {
        Double(round(1000 * location) / 1000)
    }
    
    func saveLocation(lat: Double, lon: Double) {
        userPreferences.agent.set(
            ActiveLocation(
                lat: lat,
                lon: lon),
            forKey: String(describing: ActiveLocation.self)
        )
    }
}
