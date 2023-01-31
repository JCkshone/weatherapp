//
//  String.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 30/01/23.
//

import Foundation

extension String {
    static let empty = ""
    
    var digits: String {
        return components(
            separatedBy: CharacterSet.decimalDigits.inverted
        ).joined()
    }
}
