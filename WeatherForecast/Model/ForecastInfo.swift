//
//  ForecastInfo.swift
//  WeatherForecast
//
//  Created by Dmitry Sem on 9/13/19.
//  Copyright © 2019 Dmitry Sem. All rights reserved.
//

import UIKit

class ForecastInfo: Codable {
    let weaterInfoArray: [WeatherInfo]
    let city: CityInfo?
    
    enum CodingKeys: String, CodingKey {
        case city
        case weaterInfoArray = "list"
    }
}
