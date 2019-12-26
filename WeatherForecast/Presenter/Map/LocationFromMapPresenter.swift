//
//  LocationFromMapPresenter.swift
//  WeatherForecast
//
//  Created by Dmitry Sem on 26.12.2019.
//  Copyright © 2019 Dmitry Sem. All rights reserved.
//

import UIKit

class LocationFromMapPresenter: NSObject {

    weak var viewController: MapViewController!
    
    func didChoseLocation(lat: Double, lon: Double) {
        WeatherLocationManager.shared().didChangeLocation(lat: lat, lon: lon)
        self.viewController.navigationController?.popViewController(animated: true)
    }

}
