//
//  WeatherInfo.swift
//  WeatherForecast
//
//  Created by Dmitry Sem on 9/3/19.
//  Copyright © 2019 Dmitry Sem. All rights reserved.
//

import UIKit

class WeatherInfo: Codable, Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.dt)
    }
    
    static func == (lhs: WeatherInfo, rhs: WeatherInfo) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    let dt: Int
    let main: WeatherMainInfo
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let dtTxt: String
    
    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind
        case dtTxt = "dt_txt"
    }
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}

// MARK: - MainClass
struct WeatherMainInfo: Codable {
    let temp, tempMin, tempMax, pressure: Double
    let seaLevel, grndLevel: Double
    let humidity: Int
    let tempKf: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main: String
    let weatherDescription: String
    let icon: String
    
    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

// MARK: - Wind
struct Wind: Codable {
    let speed, deg: Double
}
