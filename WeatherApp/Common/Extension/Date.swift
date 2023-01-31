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
        let dateFormatter = DateFormatter()
        let timezone = TimeZone.current.abbreviation() ?? "CET"
        
        dateFormatter.timeZone = TimeZone(abbreviation: timezone)
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "HH:mm a"
        
        return dateFormatter.string(from: date)
    }
    
    func getDay() -> String {
        guard let unix = Double(self) else {
            return.empty
        }

        let date = Date(timeIntervalSince1970: unix)
        let dateFormatter = DateFormatter()
        let timezone = TimeZone.current.abbreviation() ?? "CET"
        
        dateFormatter.timeZone = TimeZone(abbreviation: timezone)
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "EEEE"
        
        return dateFormatter.string(from: date)
    }
}
