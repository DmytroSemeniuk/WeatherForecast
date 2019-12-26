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

    var presenter: LocationFromMapPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewController = self
    }
    
    @IBAction private func longTap(sender: UIGestureRecognizer) {
        switch sender.state {
        case .began:
            self.removeAllAnnotations()
            let locationInView = sender.location(in: mapView)
            let locationOnMap = mapView.convert(locationInView, toCoordinateFrom: mapView)
            self.addAnnotation(location: locationOnMap)
            
        default: break
            
        }
    }

    @IBAction private func useLocationPressed() {
        if let annotation = self.mapView.annotations.first {
            let lat = annotation.coordinate.latitude
            let lon = annotation.coordinate.longitude
            self.presenter.didChoseLocation(lat: lat, lon: lon)
        }
    }
    
    @IBAction func showCurrentLocation() {
        self.presenter.showCurrentLocation()
    }
    
    func addAnnotation(location: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        self.mapView.addAnnotation(annotation)
    }
    
    //MARK: private
    
    private func removeAllAnnotations() {
        self.mapView.removeAnnotations(self.mapView.annotations)
    }

    //MARK: input
    
    func showLocation(location: CLLocationCoordinate2D) {
        self.removeAllAnnotations()
        self.addAnnotation(location: location)
        let region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.mapView.setRegion(region, animated: true)
    }

}
