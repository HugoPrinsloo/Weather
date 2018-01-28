//
//  WeatherService.swift
//  Weather
//
//  Created by Hugo Prinsloo on 2018/01/28.
//  Copyright © 2018 Over. All rights reserved.
//

import Foundation

protocol WeatherProviderDelegate: class {
    func weatherProvider(didUpdateWeatherData weather: WeatherDisplay)
}

struct WeatherDisplay {
    let name: String
    let description: String
    let currentTemperature: Int
    let humidity: Int
    let pressure: Int
    let windSpeed: Double
    let windDirection: Int
}


class WeatherProvider {
    
    var delegate: WeatherProviderDelegate?
    
    private let networkManager = NetworkManager()
    
    init() {
        networkManager.getWeather(for: .capetown) { [weak self] (weatherData, error) in
            guard error == nil else { return }
            if let data = weatherData {
                let weather = WeatherDisplay(name: data.name, description: data.weather.first?.description ?? "", currentTemperature: data.main.currentTemperature, humidity: data.main.humidity, pressure: data.main.pressure, windSpeed: data.wind.speed, windDirection: data.wind.deg)
                self?.delegate?.weatherProvider(didUpdateWeatherData: weather)
            }
        }
    }
}
