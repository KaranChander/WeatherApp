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
}

struct City: Decodable, Identifiable {
    let id = UUID()
    let city: String
    let latitude: Double
    let longitude: Double
    // Add other properties as needed
}


