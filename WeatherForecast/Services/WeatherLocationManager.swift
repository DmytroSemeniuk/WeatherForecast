//
//  WeatherLocationManager.swift
//  WeatherForecast
//
//  Created by Dmitry Sem on 9/13/19.
//  Copyright © 2019 Dmitry Sem. All rights reserved.
//

import UIKit

class WeatherLocationManager: NSObject {

    // MARK: - singleton

    private static var uniqueInstance: WeatherLocationManager?
    
    private override init() {}
    
    static func shared() -> WeatherLocationManager {
        if uniqueInstance == nil {
            uniqueInstance = WeatherLocationManager()
        }
        return uniqueInstance!
    }

    public private(set) var lat :Double = 47.8228900
    public private(set) var lon :Double = 35.1903100

    var citySearchInfo: CitySearchInfo?
    
    func didChangeCityLocation(cityInfo: CitySearchInfo) {
        self.citySearchInfo = cityInfo
        self.lat = cityInfo.lat
        self.lon = cityInfo.lon
        NotificationCenter.default.post(name: .didChangeLocation, object: nil)
    }
    
    func didChangeLocation(lat: Double, lon: Double) {
        self.citySearchInfo = nil
        self.lat = lat
        self.lon = lon
        NotificationCenter.default.post(name: .didChangeLocation, object: nil)
    }
    
    var cityName: String? {
        if let cityInfo = self.citySearchInfo {
            return cityInfo.name
        }
        return nil
    }
}
