//
//  CitySearchManager.swift
//  WeatherForecast
//
//  Created by Dmitry Sem on 23.12.2019.
//  Copyright © 2019 Dmitry Sem. All rights reserved.
//

import UIKit

class CitySearchManager: NSObject {

    // MARK: - singleton

    private static var uniqueInstance: CitySearchManager?
    
    private override init() {}
    
    static func shared() -> CitySearchManager {
        if uniqueInstance == nil {
            uniqueInstance = CitySearchManager()
        }
        return uniqueInstance!
    }
    
    private var citiesArray: [CitySearchInfo] {
        let zaporighia : CitySearchInfo = CitySearchInfo(id: 1, cityName: "Zaporighia", countyName: "Ukraine", lat: 47.8228900, lon: 35.1903100)
        let zapolyarny : CitySearchInfo = CitySearchInfo(id: 2, cityName: "Zapolyarny", countyName: "Russia", lat: 69.4154100, lon: 30.8135500)
        let kyiv : CitySearchInfo = CitySearchInfo(id: 3, cityName: "Kyiv", countyName: "Ukraine", lat: 50.45, lon: 30.523333)
        let london : CitySearchInfo = CitySearchInfo(id: 4, cityName: "London", countyName: "UK", lat: 51.507222, lon: -0.1275)

        return [zaporighia, zapolyarny, kyiv, london]
        
    }
    
    func cityBy(name: String) -> [CitySearchInfo] {
        let filtredArray = self.citiesArray.filter { (cityInfo) -> Bool in
            if cityInfo.name.count > name.count {
                let index = cityInfo.name.index(cityInfo.name.startIndex, offsetBy: name.count)
                let sub = cityInfo.name.prefix(upTo: index)
                if name == sub {
                    return true
                }
            }
            return false
        }
        return filtredArray
    }
}
