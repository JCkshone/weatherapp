//
//  LocationAgent.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 30/01/23.
//

import Foundation
import CoreLocation
import Combine

public protocol LocationAgent: AnyObject {
    var location: Published<CLLocation?>.Publisher { get }
    
    func requestAccess()
    func loadLocation()
}
