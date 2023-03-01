//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Karan . on 2/17/23.
//

import Foundation

struct WeatherModel: Codable {
    let name: String
    let main: CurrentWeather
    let weather: [WeatherInfo]
}

struct CurrentWeather: Codable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
}

struct WeatherInfo: Codable {
    let main: String
    let description: String
    let icon: WeatherIcon
}

enum WeatherIcon: String, Codable {
    case clearSkyDay = "01d"
    case clearSkyNight = "01n"
    case fewCloudsDay = "02d"
    case fewCloudsNight = "02n"
    case scatteredCloudsDay = "03d"
    case scatteredCloudsNight = "03n"
    case brokenCloudsDay = "04d"
    case brokenCloudsNight = "04n"
    case showerCloudsDay = "09d"
    case showerCloudsNight = "09n"
    case rainDay = "10d"
    case rainNight = "10n"
    case thunderStormDay = "11d"
    case thunderStormNight = "11n"
    case snowDay = "13d"
    case snowNight = "13n"
    case mistDay = "50d"
    case mistNight = "50n"
}

struct City: Decodable, Identifiable {
    let id = UUID()
    let city: String
    let latitude: Double
    let longitude: Double
    // Add other properties as needed
}


