//
//  Router.swift
//  WeatherForecast
//
//  Created by Dmitry Sem on 9/3/19.
//  Copyright © 2019 Dmitry Sem. All rights reserved.
//

import UIKit

class Router: NSObject {
    
    private static var uniqueInstance: Router?
    
    private override init() {}
    
    static func shared() -> Router {
        if uniqueInstance == nil {
            uniqueInstance = Router()
        }
        return uniqueInstance!
    }
    
    private var currentNavigationViewController: UINavigationController?
    
    func mainScreen() -> UIViewController {
        let viewController = ControllersFabric.forecastInfoTableViewController()
        let presenter: ForecastListPresenter = ForecastListPresenter()
        viewController.presenter = presenter
        presenter.viewController = viewController

        let mainNavigationController = ControllersFabric.mainNavigationController()
        mainNavigationController.viewControllers = [viewController]
        self.currentNavigationViewController = mainNavigationController
        
        return mainNavigationController;
    }
    
    func showCitiesSearch() -> UIViewController {
        let viewController = ControllersFabric.cityTableViewController()
        let presenter: CitiesSearchPresenter = CitiesSearchPresenter()
        viewController.presenter = presenter
        presenter.tableViewController = viewController

        currentNavigationViewController?.pushViewController(viewController, animated: true)
        
        return viewController;
    }
    
    func showMap() -> UIViewController {
        let viewController = ControllersFabric.mapViewController()
        let presenter: LocationFromMapPresenter = LocationFromMapPresenter()
        viewController.presenter = presenter
        presenter.viewController = viewController

        currentNavigationViewController?.pushViewController(viewController, animated: true)
        
        return viewController;
    }
    
    
}
