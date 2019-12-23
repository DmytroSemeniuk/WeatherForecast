//
//  WeatherInfoViewController.swift
//  WeatherForecast
//
//  Created by Dmitry Sem on 8/30/19.
//  Copyright © 2019 Dmitry Sem. All rights reserved.
//

import UIKit

protocol WeatherInfoViewControllerProtocol: AnyObject {
    
    var hourForecastCollectionView: UICollectionView! {get}
    var hourForecastCellIdentify: String {get}
    func fillDateLabel(by text: String)
    func fillTemperatureLabel(by text: String)
    func fillHumidityLabel(by text: String)
    func fillWindLabel(by text: String)


}

class WeatherInfoViewController: UIViewController, WeatherInfoViewControllerProtocol {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var hourForecastCollectionView: UICollectionView!

    var presenter: WeatherInfoPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.weatherInfoViewController = self
        self.presenter.setupHourForecastDataSource()
    }
    
    let hourForecastCellIdentify = "HourForecastCell"

    func fillDateLabel(by text: String) {
        self.dateLabel.text = text
    }
    
    func fillTemperatureLabel(by text: String) {
        self.temperatureLabel.text = text
    }
    
    func fillHumidityLabel(by text: String) {
        self.humidityLabel.text = text
    }
    
    func fillWindLabel(by text: String) {
        self.windLabel.text = text
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
