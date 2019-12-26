//
//  WeatherInfoPresenter.swift
//  WeatherForecast
//
//  Created by Dmitry Sem on 9/20/19.
//  Copyright © 2019 Dmitry Sem. All rights reserved.
//

import UIKit

protocol WeatherInfoPresenterProtocol {
    
    var weatherInfoViewController: WeatherInfoViewControllerProtocol! {get set}

    func showDayForecast(dayForecast: ForecatsForDayInfo)
    func setupHourForecastDataSource()
    
}

class WeatherInfoPresenter: NSObject, WeatherInfoPresenterProtocol {    

    private let dataSource: CollectionSectionDatasource = CollectionSectionDatasource()
    weak var weatherInfoViewController: WeatherInfoViewControllerProtocol!
    
    func setupHourForecastDataSource() {
        self.dataSource.collectionView = self.weatherInfoViewController.hourForecastCollectionView
    }
    
    func showDayForecast(dayForecast: ForecatsForDayInfo) {
        self.fillDataSource(weathersArray: dayForecast.forecatsForHoursArray)
        
        let dateText = self.dateText(from: dayForecast.date)
        self.weatherInfoViewController.fillDateLabel(by: dateText)
        
        let maxTemperature = Formatter.temperatureString(from: dayForecast.maxTepmerature)
        let minTemperature = Formatter.temperatureString(from: dayForecast.minTepmerature)
        let temperatureText = "\(maxTemperature)/ \(minTemperature)"
        self.weatherInfoViewController.fillTemperatureLabel(by: temperatureText)
        
        let humidity = Formatter.humidityString(from: dayForecast.humidity)
        self.weatherInfoViewController.fillHumidityLabel(by: humidity)
        
        let wind = Formatter.windString(from: dayForecast.wind)
        self.weatherInfoViewController.fillWindLabel(by: wind)

    }
    
    private func fillDataSource(weathersArray: [WeatherInfo]) {
        var dataSourceItemArray: [DataSourceItem] = []
        for weatherInfo in weathersArray {
            let dataSourceItem = DataSourceItem.init(self.weatherInfoViewController.hourForecastCellIdentify, payload: weatherInfo)
            dataSourceItemArray.append(dataSourceItem)
        }
        self.dataSource.items = dataSourceItemArray
        
    }
    
    private func dateText(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE, dd MMMM"
        let text = dateFormatter.string(from: date)
        return text
    }
}
