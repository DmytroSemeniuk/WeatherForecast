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
    }
    
    private func fillDataSource(weathersArray: [WeatherInfo]) {
        var dataSourceItemArray: [DataSourceItem] = []
        for weatherInfo in weathersArray {
            let dataSourceItem = DataSourceItem.init(self.weatherInfoViewController.hourForecastCellIdentify, payload: weatherInfo)
            dataSourceItemArray.append(dataSourceItem)
        }
        self.dataSource.items = dataSourceItemArray
        
    }
}
