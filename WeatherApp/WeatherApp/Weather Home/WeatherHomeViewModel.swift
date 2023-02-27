//
//  WeatherHomeViewModel.swift
//  WeatherApp
//
//  Created by Karan . on 2/17/23.
//

import Foundation
import CoreLocation

class WeatherViewModel: ObservableObject {
//    var coordinates: CLLocationCoordinate2D?
    @Published var model: WeatherModel?
    var cityArray: [City] = []
    
    init(coordinates: CLLocationCoordinate2D) {
//        self.coordinates = coordinates
        fetchWeatherAPI(lat: coordinates.latitude, long: coordinates.longitude)
        setupCityData()

    }
    
    init() {
    }
    
    func fetchWeatherAPI(lat: Double, long: Double) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(long)&appid=c310747a77546f09ca29100af67baace&units=imperial") else { return }
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
    
    func setupCityData() {
        if let path = Bundle.main.path(forResource: "city.list", ofType: "json") {
            do {
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                let items = try decoder.decode([City].self, from: jsonData)
                self.cityArray = items
//                let filteredItems = items.filter { item in
//                    searchText.isEmpty || item.title.localizedStandardContains(searchText)
//                }
            } catch {
                print("something went wrong!")
            }
        }
    }
}
