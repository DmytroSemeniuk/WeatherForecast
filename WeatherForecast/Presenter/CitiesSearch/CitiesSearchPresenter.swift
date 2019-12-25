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
        self.updateDataSourceBy(filterText: "")
    }
    
    func updateSearchResults(for searchController: UISearchController) {
       let searchBar = searchController.searchBar
        if let filterText = searchBar.text {
            self.updateDataSourceBy(filterText: filterText)
        }
    }
//    func cityBy(name: String) -> [CitySearchInfo] {

    func updateDataSourceBy(filterText: String) {
        var dataSourceItemArray: [DataSourceItem] = []

        if filterText.count >= 3 {
            let citiesArray = CitySearchManager.shared().cityBy(name: filterText)
            
            for citySearchInfo in citiesArray {
                let dataSourceItem = DataSourceItem.init(self.tableViewController.cellIdentify, payload: citySearchInfo)
                dataSourceItemArray.append(dataSourceItem)
            }
        }
        self.dataSource.items = dataSourceItemArray
    }
}


