//
//  Formatter.swift
//  WeatherForecast
//
//  Created by Dmitry Sem on 10/1/19.
//  Copyright © 2019 Dmitry Sem. All rights reserved.
//

import UIKit

class Formatter: NSObject {

    static func temperatureString(from temp: Double) -> String {
        let temperature = Int(round(temp))
        let temperatureText = Formatter.temperatureString(from: temperature)
        return temperatureText
    }
    
    static func temperatureString(from temp: Int) -> String {
        let temperatureText = "\(temp)°"
        return temperatureText
    }
    
    static func hoursText(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        let timeText = dateFormatter.string(from: date)
        return timeText
    }
    
    static func minutesText(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "mm"
        let timeText = dateFormatter.string(from: date)
        return timeText
    }
    
    static func dayOfWeek(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE"
        let weekDay = dateFormatter.string(from: date)
        return weekDay
    }
    
}
