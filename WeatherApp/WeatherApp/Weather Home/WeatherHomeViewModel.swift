//
//  WeatherHomeViewModel.swift
//  WeatherApp
//
//  Created by Karan . on 2/17/23.
//

import Foundation
import CoreLocation

class WeatherViewModel: ObservableObject {
    var coordinates: CLLocationCoordinate2D?
    @Published var model: WeatherModel?
    
    init(coordinates: CLLocationCoordinate2D) {
        self.coordinates = coordinates
        fetchWeatherAPI()
    }
    
    init() {}
    
    func fetchWeatherAPI() {
        guard let coordinate = coordinates, let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinate.latitude)&lon=\(coordinate.longitude)&appid=c310747a77546f09ca29100af67baace&units=imperial") else { return }
        let task = URLSession.shared.dataTask(with: url) {[weak self] data, _, error in
            guard let `self` = self else { return }
            guard let data = data, error == nil else { return }
            do {
                let model = try JSONDecoder().decode(WeatherModel.self, from: data)
                DispatchQueue.main.async {
                    self.model = model
                }
            } catch {
                print("something went wrong")
            }
        }
        task.resume()
    }
}
