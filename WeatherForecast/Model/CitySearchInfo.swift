//
//  CitySearchInfo.swift
//  WeatherForecast
//
//  Created by Dmitry Sem on 23.12.2019.
//  Copyright © 2019 Dmitry Sem. All rights reserved.
//

import UIKit

class CitySearchInfo: Hashable {
    
    let id: Int
    let lat, lon: Double
    let name: String
    let country: String

    init(id: Int, cityName: String, countyName: String, lat: Double, lon: Double) {
        self.id = id
        self.lat = lat
        self.lon = lon
        self.name = cityName
        self.country = countyName
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
    static func == (lhs: CitySearchInfo, rhs: CitySearchInfo) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    


    
}
