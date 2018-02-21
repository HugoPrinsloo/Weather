//
//  NetworkManager.swift
//  Weather
//
//  Created by Hugo Prinsloo on 2018/01/28.
//  Copyright © 2018 Over. All rights reserved.
//

import Foundation

enum City {
    case capetown
    case tokyo
    case berlin
        
    var url: URL {
        switch self {
        case .capetown:
            return URL(string: "http://api.openweathermap.org/data/2.5/weather?id=3369157&units=metric&appid=6942ae4a2643a8dd39dc2a452fc4653d")!
        case .tokyo:
            return URL(string: "http://api.openweathermap.org/data/2.5/weather?id=1850144&units=metric&appid=6942ae4a2643a8dd39dc2a452fc4653d")!
        case .berlin:
            return URL(string: "http://api.openweathermap.org/data/2.5/weather?id=2950159&units=metric&appid=6942ae4a2643a8dd39dc2a452fc4653d")!
        }
    }
}

class NetworkManager {
    
    func getWeather(for city: City, completion:@escaping (_ weather: CurrentLocalWeather?, _ error:Error?) -> Void) {
        URLSession.shared.dataTask(with: city.url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let weatherData = try decoder.decode(CurrentLocalWeather.self, from: data)
                completion(weatherData, nil)
            } catch let error {
                print("NetworkManager - Failed to fetch weather data with error: ", error)
            }
            }.resume()
    }
}


struct CurrentLocalWeather: Codable {
    let name: String
    let weather: [Weather]
    let main: Main
    let wind: Wind
}


struct Weather: Codable {
    let description: String
    let icon: String
    let id: Int
    let main: String
}

struct Main: Codable {
    let currentTemperature: Float
    let pressure: Int
    let humidity: Int

    private enum CodingKeys: String, CodingKey {
        case currentTemperature = "temp"
        case pressure, humidity
    }
}

struct Wind: Codable {
    let speed: Float
    let deg: Int
}




