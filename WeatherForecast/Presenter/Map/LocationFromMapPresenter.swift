//
//  LocationFromMapPresenter.swift
//  WeatherForecast
//
//  Created by Dmitry Sem on 26.12.2019.
//  Copyright © 2019 Dmitry Sem. All rights reserved.
//

import UIKit
import CoreLocation

class LocationFromMapPresenter: NSObject {

    weak var viewController: MapViewController!
    
    var locationManager: CLLocationManager?

    func showCurrentLocation() {
        if (CLLocationManager.locationServicesEnabled()) {
            self.locationManager = CLLocationManager()
            self.locationManager?.delegate = self
            self.locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager?.requestAlwaysAuthorization()
            self.locationManager?.startUpdatingLocation()
        }
    }
    
    func didChoseLocation(lat: Double, lon: Double) {
        WeatherLocationManager.shared().didChangeLocation(lat: lat, lon: lon)
        self.viewController.navigationController?.popViewController(animated: true)
    }

}

extension LocationFromMapPresenter: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            self.viewController.showLocation(location: center)
            self.locationManager?.stopUpdatingLocation()
        }
    }
    
}
