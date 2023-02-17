//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Karan . on 2/16/23.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    
    @Published var location: CLLocationCoordinate2D?
    @Published var isLoading = false
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func requestLocation() {
        isLoading = true
        manager.requestLocation()
        location = CLLocationCoordinate2D.init(latitude: 37.787359, longitude: -122.408227)
//        37.787359
//        -122.408227
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
        print("LOCATION: \(location)")
        isLoading = false
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //handle error
        isLoading = false
    }
    
}
