//
//  CLLocationAgent.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 30/01/23.
//
import Foundation
import CoreLocation
import Combine

class CLLocationAgent: NSObject, ObservableObject {
    
    private let locationManager = CLLocationManager()
    @Published var currentLocation: CLLocation? = nil
    var location: Published<CLLocation?>.Publisher { $currentLocation }
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
    }
    
}

extension CLLocationAgent: LocationAgent {
    func requestAccess() {
        locationManager.requestAlwaysAuthorization()
    }
    
    func loadLocation() {
        locationManager.startUpdatingLocation()
    }
}

extension CLLocationAgent: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else {
            locationManager.stopUpdatingLocation()
            return
        }
        
        DispatchQueue.main.async {
            self.currentLocation = currentLocation
        }
        
        locationManager.stopUpdatingLocation()
    }
}
