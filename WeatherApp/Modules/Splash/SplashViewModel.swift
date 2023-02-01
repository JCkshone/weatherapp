//
//  SplashViewModel.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 30/01/23.
//

import Combine
import SwiftUI
import Resolver

class SplashViewModel: ObservableObject {
    @Injected var locationProvider: LocationProviderProtocol
    @Injected(name: .userDefaults) private var userPreferences: StorageProviderProtocol

    private var cancellables = Set<AnyCancellable>()

    func viewDidLoad() {
        locationProvider.agent.requestAccess()
        locationProvider.agent.location.sink { [weak self] location in
            guard let self = self, let coordinate = location?.coordinate else { return }
            if !self.userPreferences.agent.hasValue(forKey: String(describing: ActiveLocation.self)) {
                self.userPreferences.agent.set(
                    ActiveLocation(
                        lat: coordinate.latitude,
                        lon: coordinate.longitude),
                    forKey: String(describing: ActiveLocation.self)
                )
            }
        }
        .store(in: &cancellables)
        locationProvider.agent.loadLocation()
        
    }
}
