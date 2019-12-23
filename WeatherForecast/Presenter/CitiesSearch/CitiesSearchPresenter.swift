//
//  CitiesSearchPresenter.swift
//  WeatherForecast
//
//  Created by Dmitry Sem on 23.12.2019.
//  Copyright © 2019 Dmitry Sem. All rights reserved.
//

import UIKit

class CitiesSearchPresenter: NSObject, UISearchResultsUpdating {

    let dataSource: TableSectionDatasource = TableSectionDatasource()
    weak var tableViewController: CityTableViewController!
    
    func viewDidLoad() {
        dataSource.tableView = self.tableViewController.tableView
        self.fillDataSource()
    }
    
    func fillDataSource() {
        var dataSourceItemArray: [DataSourceItem] = []
        for index in 1...5 {
            let citySearchInfo = CitySearchInfo.init(cityName: "City name \(index)")
            let dataSourceItem = DataSourceItem.init(self.tableViewController.cellIdentify, payload: citySearchInfo)
            dataSourceItemArray.append(dataSourceItem)
        }
        self.dataSource.items = dataSourceItemArray
    }
    
    func updateSearchResults(for searchController: UISearchController) {
      // TODO
    }
}


