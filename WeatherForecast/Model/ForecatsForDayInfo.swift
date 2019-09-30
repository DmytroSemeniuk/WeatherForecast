//
//  ForecatsForDayInfo.swift
//  WeatherForecast
//
//  Created by Dmitry Sem on 9/16/19.
//  Copyright © 2019 Dmitry Sem. All rights reserved.
//

import UIKit

class ForecatsForDayInfo: Hashable {

    let date: Date
    var minTepmerature, maxTepmerature: Double
    var forecatsForHoursArray: [WeatherInfo]
    
    init(date: Date, minTepmerature: Double, maxTepmerature: Double, hoursForecastArray: [WeatherInfo] ) {
        self.date = date
        self.minTepmerature = minTepmerature
        self.maxTepmerature = maxTepmerature
        self.forecatsForHoursArray = hoursForecastArray
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.date)
    }
    
    static func == (lhs: ForecatsForDayInfo, rhs: ForecatsForDayInfo) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
}
