//
//  MapViewController.swift
//  WeatherForecast
//
//  Created by Dmitry Sem on 26.12.2019.
//  Copyright © 2019 Dmitry Sem. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!

    let presenter: LocationFromMapPresenter = LocationFromMapPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewController = self
    }
    
    @IBAction func longTap(sender: UIGestureRecognizer) {
        switch sender.state {
        case .began:
            self.mapView.removeAnnotations(self.mapView.annotations)
            let locationInView = sender.location(in: mapView)
            let locationOnMap = mapView.convert(locationInView, toCoordinateFrom: mapView)
            addAnnotation(location: locationOnMap)
            
        default: break
            
        }
    }

    @IBAction func useLocationPressed() {
        if let annotation = self.mapView.annotations.first {
            let lat = annotation.coordinate.latitude
            let lon = annotation.coordinate.longitude
            self.presenter.didChoseLocation(lat: lat, lon: lon)
        }
    }
    
    func addAnnotation(location: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        self.mapView.addAnnotation(annotation)
    }

}
