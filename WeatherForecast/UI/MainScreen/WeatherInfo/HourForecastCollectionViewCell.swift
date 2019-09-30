//
//  HourForecastCollectionViewCell.swift
//  WeatherForecast
//
//  Created by Dmitry Sem on 9/22/19.
//  Copyright © 2019 Dmitry Sem. All rights reserved.
//

import UIKit

class HourForecastCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    
    private func timeTextFrom(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let timeText = dateFormatter.string(from: date)
        return timeText
    }
}

extension HourForecastCollectionViewCell: DataAwareCell {
    
    func fillWithData(_ data: DataSourceItem) {
        if let weatherInfo = data.payload as? WeatherInfo {
            let temperature = Int(round(weatherInfo.main.temp))
            let temperatureText = "\(temperature)°"
            self.temperatureLabel.text = temperatureText
            
            let timeInterval = TimeInterval(weatherInfo.dt)
            let date = Date.init(timeIntervalSince1970: timeInterval)

            let timeText = self.timeTextFrom(date: date)
            self.timeLabel.text = timeText
        }
    }
    
}
