//
//  WeatherHomeViewModel.swift
//  WeatherApp
//
//  Created by Karan . on 2/17/23.
//

import Foundation
import CoreLocation
import SwiftUI

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
                    print(model)
                }
            } catch {
                print("something went wrong")
            }
        }
        task.resume()
    }
    
    func getWeatherIcon(icon: WeatherIcon) -> String {
        switch icon {
        case .clearSkyDay:
            return "sun.max.fill"
        case .clearSkyNight:
            return "moon.fill"
        case .fewCloudsDay:
            return "cloud.sun.fill"
        case .fewCloudsNight:
            return "cloud.moon.fill"
        case .scatteredCloudsDay:
            return "cloud.fill"
        case .scatteredCloudsNight:
            return "cloud.fill"
        case .brokenCloudsDay:
            return "cloud.fill"
        case .brokenCloudsNight:
            return "cloud.fill"
        case .showerCloudsDay:
            return "cloud.sun.rain.fill"
        case .showerCloudsNight:
            return "cloud.moon.rain.fill"
        case .rainDay:
            return "cloud.heavyrain.fill"
        case .rainNight:
            return "cloud.heavyrain.fill"
        case .thunderStormDay:
            return "cloud.bolt.fill"
        case .thunderStormNight:
            return "cloud.bolt.fill"
        case .snowDay:
            return "snowflake"
        case .snowNight:
            return "snowflake"
        case .mistDay:
            return "cloud.fog.fill"
        case .mistNight:
            return "cloud.fog.fill"
        }
    }
    
    func getBackgroundGradientColors(icon: WeatherIcon) -> [Color] {
        switch icon {
            
        case .clearSkyDay:
            return [.blue,Color("lightBlue")]
        case .clearSkyNight:
            return [Color("night1"), Color("night2")]
        case .fewCloudsDay:
            return [Color("cloudDay1"), Color("cloudDay2")]

        case .fewCloudsNight:
            return [Color("cloudNight1"), Color("cloudNight2")]

        case .scatteredCloudsDay:
            return [Color("cloudDay1"), Color("cloudDay2")]

        case .scatteredCloudsNight:
            return [Color("cloudNight1"), Color("cloudNight2")]

        case .brokenCloudsDay:
            return [Color("cloudDay1"), Color("cloudDay2")]

        case .brokenCloudsNight:
            return [Color("cloudNight1"), Color("cloudNight2")]

        case .showerCloudsDay:
            return [Color("cloudDay1"), Color("cloudDay2")]

        case .showerCloudsNight:
            return [Color("cloudNight1"), Color("cloudNight2")]

        case .rainDay:
            return [Color("rainDay1"), Color("rainDay2")]

        case .rainNight:
            return [Color("rainNight1"), Color("rainNight2")]

        case .thunderStormDay:
            return [Color("thunderStormDay1"), Color("thunderStormDay2")]

        case .thunderStormNight:
            return [Color("thunderStormNight1"), Color("thunderStormNight2")]

        case .snowDay:
            return [Color("snowDay1"), Color("snowDay2")]

        case .snowNight:
            return [Color("snowNight1"), Color("snowNight2")]

        case .mistDay:
            return [Color("mistDay1"), Color("mistDay2")]

        case .mistNight:
            return [Color("mistNight1"), Color("mistNight2")]

        }
    }
    
    func setupCityData() {
        if let path = Bundle.main.path(forResource: "city.list", ofType: "json") {
            do {
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                let items = try decoder.decode([City].self, from: jsonData)
                self.cityArray = items
            } catch {
                print("something went wrong!")
            }
        }
    }
}
