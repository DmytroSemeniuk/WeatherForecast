//
//  WeatherForecastManager.swift
//  WeatherForecast
//
//  Created by Dmitry Sem on 9/13/19.
//  Copyright © 2019 Dmitry Sem. All rights reserved.
//

import UIKit

class WeatherForecastManager: NSObject {
    
    // MARK: - singleton

    private static var uniqueInstance: WeatherForecastManager?
    
    private override init() {}
    
    static func shared() -> WeatherForecastManager {
        if uniqueInstance == nil {
            uniqueInstance = WeatherForecastManager()
            NotificationCenter.default.addObserver(uniqueInstance!, selector: #selector(didChangeLocation), name: .didChangeLocation, object: nil)
        }
        return uniqueInstance!
    }

    // MARK: - public
    
    private var daysForecastArray : [ForecatsForDayInfo] = []
    
    func getForecast() -> [ForecatsForDayInfo] {
        if self.isNeedToReloadData() {
            self.loadForecastInfo()
        }
        
        return self.daysForecastArray
    }
    
    // MARK: - private

    private var forecastInfo: ForecastInfo? {
        didSet {
            self.fillDaysForecastArray()
            self.forecastInfoChangeNotify()
        }
    }
    
    private func loadForecastInfo() {
        let lat = WeatherLocationManager.shared().lat
        let lon = WeatherLocationManager.shared().lon
        _ = APIManager.shared().getWeatherIn(lat:lat, lon:lon, completion: { [self] (responce) in
            if let forecastInfo = responce.value {
                self.forecastInfo = forecastInfo
            }
        })
    }
    
    private func needToReloadData() {
        self.forecastInfo = nil
        self.daysForecastArray.removeAll()
    }
    
    private func isNeedToReloadData() -> Bool {
        if self.forecastInfo == nil {
            return true
        }
        return false
    }
    
    private func fillDaysForecastArray() {
        if let forecastInfo = self.forecastInfo {
            for weatherInfo in forecastInfo.weaterInfoArray {
                if let lastDayWeather = self.daysForecastArray.last {
                    let newTimeInterval = TimeInterval(weatherInfo.dt)
                    let newDate = Date.init(timeIntervalSince1970: newTimeInterval)
                    let isSameDay = Calendar.current.isDate(lastDayWeather.date, inSameDayAs: newDate)
                    if (isSameDay) {
                        self.updateDayForecast(dayForecast: lastDayWeather, byWeather: weatherInfo)
                    } else {
                        let forecatsForDayInfo = createDayForecastFrom(weather: weatherInfo)
                        self.daysForecastArray.append(forecatsForDayInfo)
                    }
                } else {
                    let forecatsForDayInfo = createDayForecastFrom(weather: weatherInfo)
                    self.daysForecastArray.append(forecatsForDayInfo)
                }
            }
        }
    }
    
    private func updateDayForecast(dayForecast: ForecatsForDayInfo, byWeather weather: WeatherInfo) {
        let tempMin = weather.main.tempMin
        if (dayForecast.minTepmerature > tempMin) {
            dayForecast.minTepmerature = tempMin
        }
        
        let tempMax = weather.main.tempMax
        if (dayForecast.maxTepmerature < tempMax) {
            dayForecast.maxTepmerature = tempMax
        }
        
        dayForecast.forecatsForHoursArray.append(weather)
    }
    
    private func createDayForecastFrom(weather: WeatherInfo) -> ForecatsForDayInfo {
        let timeInterval = TimeInterval(weather.dt)
        let date = Date.init(timeIntervalSince1970: timeInterval)
        let tempMin = weather.main.tempMin
        let tempMax = weather.main.tempMax
        let forecatsForDayInfo = ForecatsForDayInfo.init(date: date, minTepmerature: tempMin, maxTepmerature: tempMax, hoursForecastArray: [weather])
        return forecatsForDayInfo
    }
    
    private func forecastInfoChangeNotify() {
        NotificationCenter.default.post(name: .didChangeForecastInfo, object: nil)
    }
    
    @objc private func didChangeLocation() {
        self.needToReloadData()
    }

}

extension Notification.Name {
    static let didChangeForecastInfo = Notification.Name("didChangeForecastInfo")
}

extension Notification.Name {
    static let didChangeLocation = Notification.Name("didChangeLocation")
}
