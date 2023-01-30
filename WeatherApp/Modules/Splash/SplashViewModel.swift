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
    
    func viewDidLoad() {
        locationProvider.agent.requestAccess()
    }
}
