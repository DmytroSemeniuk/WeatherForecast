//
//  ForecastTableViewCell.swift
//  WeatherForecast
//
//  Created by Dmitry Sem on 9/14/19.
//  Copyright © 2019 Dmitry Sem. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {

    @IBInspectable public var normalColor: UIColor!
    @IBInspectable public var selectedColor: UIColor!

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            dayLabel.textColor = selectedColor
            temperatureLabel.textColor = selectedColor
        } else {
            dayLabel.textColor = normalColor
            temperatureLabel.textColor = normalColor
        }
        // Configure the view for the selected state
    }
    
    private func weekDayTextFrom(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE"
        let weekDay = dateFormatter.string(from: date)
        return weekDay
    }


}

extension ForecastTableViewCell: DataAwareCell {
    
    func fillWithData(_ data: DataSourceItem) {
        if let dayForecast = data.payload as? ForecatsForDayInfo {
            let maxTemperature = Int(round(dayForecast.maxTepmerature))
            let minTemperature = Int(round(dayForecast.minTepmerature))
            let temperatureText = "\(maxTemperature)°/ \(minTemperature)°"
            self.temperatureLabel.text = temperatureText
            
            let date = dayForecast.date
            let weekday = self.weekDayTextFrom(date: date)
            self.dayLabel.text = weekday
        }
    }
    
}
