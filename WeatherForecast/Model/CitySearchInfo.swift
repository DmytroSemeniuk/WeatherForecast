//
//  CitySearchInfo.swift
//  WeatherForecast
//
//  Created by Dmitry Sem on 23.12.2019.
//  Copyright © 2019 Dmitry Sem. All rights reserved.
//

import UIKit

class CitySearchInfo: Hashable {
    
    let name: String

    init(cityName: String) {
        self.name = cityName
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.name)
    }
    
    static func == (lhs: CitySearchInfo, rhs: CitySearchInfo) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    


    
}
