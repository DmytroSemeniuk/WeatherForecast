//
//  ForecastListPresenter.swift
//  WeatherForecast
//
//  Created by Dmitry Sem on 9/15/19.
//  Copyright © 2019 Dmitry Sem. All rights reserved.
//

import UIKit

class ForecastListPresenter: NSObject {

    let weatherInfoPresenter = WeatherInfoPresenter()

    let dataSource: TableSectionDatasource = TableSectionDatasource()
    weak var viewController: ForecastInfoTableViewController!
    
    func viewDidLoad() {
        dataSource.tableView = self.viewController.tableView
        self.fillCityButton()
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeLocation), name: .didChangeLocation, object: nil)
    }
    
    func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(fillDataSource), name: .didChangeForecastInfo, object: nil)
        self.fillDataSource()
    }
    
    func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: .didChangeForecastInfo, object: nil)
    }
    
    func didSelectRowAt(indexPath: IndexPath) {
        self.fillWeatherInfoByItemAt(index: indexPath.row)
    }
    
    func showCitiesSearch() {
        _ = Router.shared().showCitiesSearch()
    }
    
    func showMap() {
        _ = Router.shared().showMap()
    }
    
    @objc func fillDataSource() {
        var dataSourceItemArray: [DataSourceItem] = []
        for dayForecast in WeatherForecastManager.shared().getForecast() {
            let dataSourceItem = DataSourceItem.init(self.viewController.cellIdentify, payload: dayForecast)
            dataSourceItemArray.append(dataSourceItem)
        }
        self.dataSource.items = dataSourceItemArray
        let defaultSelectedIndex = 0
        if (dataSourceItemArray.count > defaultSelectedIndex) {
            self.viewController.setSelectedCell(at: defaultSelectedIndex)
            self.fillWeatherInfoByItemAt(index: defaultSelectedIndex)
        }
    }
    
    private func fillWeatherInfoByItemAt(index: Int) {
        if let forecatsForDayInfo = self.itemAt(index: index) as? ForecatsForDayInfo {
            self.fillWeatherInfo(dayForecast: forecatsForDayInfo)
        }
    }
    
    private func itemAt(index: Int) -> AnyHashable? {
        let itemsArray = self.dataSource.items
        if itemsArray.count > index {
            let dataSourceItem = itemsArray[index]
            return dataSourceItem.payload
        }
        return nil
    }
    
    private func fillWeatherInfo(dayForecast: ForecatsForDayInfo) {
        self.weatherInfoPresenter.showDayForecast(dayForecast: dayForecast)
    }
    
    private func fillCityButton() {
        var cityName = "Choose city"
        if let name = WeatherLocationManager.shared().cityName {
            cityName = name
        }
        self.viewController.fillCityButtonBy(cityName: cityName)
    }
    
    @objc private func didChangeLocation() {
        self.fillCityButton()
    }
    
}

extension ForecastListPresenter: WeatherInfoPresenterProtocol {

    var weatherInfoViewController: WeatherInfoViewControllerProtocol! {
        get {
            return self.weatherInfoPresenter.weatherInfoViewController
        }
        set {
            self.weatherInfoPresenter.weatherInfoViewController = newValue
        }
    }
    
    func showDayForecast(dayForecast: ForecatsForDayInfo) {
        self.weatherInfoPresenter.showDayForecast(dayForecast: dayForecast)
    }
    
    func setupHourForecastDataSource() {
        self.weatherInfoPresenter.setupHourForecastDataSource()
    }
    
    
}
