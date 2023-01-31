//
//  View.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 31/01/23.
//

import Foundation
import SwiftUI

extension View {
    func convertToCelsius(_ value: Double) -> String {
        let t = Measurement(value: value, unit: UnitTemperature.kelvin)
        return "\(round(t.converted(to: UnitTemperature.celsius).value))°C"
    }
}
