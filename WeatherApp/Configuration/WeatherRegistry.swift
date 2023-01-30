//
//  WeatherRegistry.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 30/01/23.
//

import Foundation

class WeatherRegistry: NSObject, AppLifecycleProtocol {
    override init() {
        super.init()
        WeatherDependencies.bindComponents()
    }
}

struct AppRegistry {
    var registry: [AppLifecycleProtocol]
    
    init() {
        self.registry = [
            WeatherRegistry()
        ]
    }
    
    func getRegistry() -> [AppLifecycleProtocol] { registry }
}
