//
//  Date.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 30/01/23.
//

import Foundation

extension String {
    func getTime() -> String {
        guard let unix = Double(self) else {
            return.empty
        }
        let date = Date(timeIntervalSince1970: unix)
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        return "\(hour):\(minute)"
    }
}
