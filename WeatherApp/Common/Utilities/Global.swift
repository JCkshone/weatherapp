//
//  Global.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 31/01/23.
//

import Foundation

public func delay(deadline: Double = 0, completion: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + deadline) {
        completion()
    }
}
