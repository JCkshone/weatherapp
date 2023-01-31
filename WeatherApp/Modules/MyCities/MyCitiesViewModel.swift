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
    let isFirst: Bool
    let entity: WeatherCityCore
}

class MyCitiesViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    
    @Injected var coreData: CoreDataAgent<WeatherCityCore>
    @Published var cities: [MyCitiesItem] = []
    
    deinit {
        cancellables.removeAll()
    }
}

extension MyCitiesViewModel {
    func loadCities() {
        coreData.fetch(sortDescriptors: [NSSortDescriptor(keyPath: \WeatherCityCore.active, ascending: true)])
            .replaceError(with: [])
            .sink { cities in
                self.cities = cities.map {
                    MyCitiesItem(
                        name: $0.name ?? .empty,
                        lat: $0.lat,
                        lon: $0.long,
                        temp: $0.temp ?? .empty,
                        isFirst: $0.active,
                        entity: $0
                    )
                }
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
}
