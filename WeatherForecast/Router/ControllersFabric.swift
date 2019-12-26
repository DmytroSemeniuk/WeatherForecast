//
//  ControllersFabric.swift
//  WeatherForecast
//
//  Created by Dmitry Sem on 9/3/19.
//  Copyright © 2019 Dmitry Sem. All rights reserved.
//

import UIKit

class ControllersFabric: NSObject {
    
    static func mainNavigationController() -> UINavigationController {
        let storyboard = UIStoryboard(name: "MainNavigationController", bundle: nil)
        if let mainNavigationController = storyboard.instantiateInitialViewController() as? UINavigationController {
            return mainNavigationController
        }
        return UINavigationController()
    }
    
    static func forecastInfoTableViewController() -> ForecastInfoTableViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let forecastInfoTableViewController = storyboard.instantiateInitialViewController() as? ForecastInfoTableViewController {
            return forecastInfoTableViewController
        }
        return ForecastInfoTableViewController()
    }
    
    static func cityTableViewController() -> CityTableViewController {
        let storyboard = UIStoryboard(name: "CitiesSearch", bundle: nil)
        if let cityTableViewController = storyboard.instantiateInitialViewController() as? CityTableViewController {
            return cityTableViewController
        }
        return CityTableViewController()
    }
    
    static func mapViewController() -> MapViewController {
        let storyboard = UIStoryboard(name: "MapViewController", bundle: nil)
        if let mapViewController = storyboard.instantiateInitialViewController() as? MapViewController {
            return mapViewController
        }
        return MapViewController()
    }
    
}
