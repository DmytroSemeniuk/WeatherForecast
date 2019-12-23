//
//  HourForecastCollectionViewCell.swift
//  WeatherForecast
//
//  Created by Dmitry Sem on 9/22/19.
//  Copyright © 2019 Dmitry Sem. All rights reserved.
//

import UIKit

class HourForecastCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    
}

extension HourForecastCollectionViewCell: DataAwareCell {
    
    func fillWithData(_ data: DataSourceItem) {
        if let weatherInfo = data.payload as? WeatherInfo {
            let temperature = weatherInfo.main.temp
            let temperatureText = Formatter.temperatureString(from: temperature)
            self.temperatureLabel.text = temperatureText
            
            let timeInterval = TimeInterval(weatherInfo.dt)
            let date = Date.init(timeIntervalSince1970: timeInterval)

            let hoursText = Formatter.hoursText(from: date)
            self.hoursLabel.text = hoursText
            
            let minutesText = Formatter.minutesText(from: date)
            self.minutesLabel.text = minutesText
        }
    }
    
}
