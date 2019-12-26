//
//  CitiesSearchPresenter.swift
//  WeatherForecast
//
//  Created by Dmitry Sem on 23.12.2019.
//  Copyright © 2019 Dmitry Sem. All rights reserved.
//

import UIKit

class CitiesSearchPresenter: NSObject, UISearchResultsUpdating, UITableViewDelegate {

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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cityInfo = self.itemAt(index: indexPath.row) as? CitySearchInfo {
            WeatherLocationManager.shared().didChangeCityLocation(cityInfo: cityInfo)
            self.tableViewController.navigationController?.popViewController(animated: true)
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
}


