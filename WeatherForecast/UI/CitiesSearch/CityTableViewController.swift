//
//  CityTableViewController.swift
//  WeatherForecast
//
//  Created by Dmitry Sem on 23.12.2019.
//  Copyright © 2019 Dmitry Sem. All rights reserved.
//

import UIKit

class CityTableViewController: UITableViewController {

    let searchController = UISearchController(searchResultsController: nil)
    var presenter: CitiesSearchPresenter!
    let cellIdentify = "CityCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter.viewDidLoad()
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search City"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchResultsUpdater = self.presenter

    }

    // MARK: UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter.tableView(tableView, didSelectRowAt: indexPath)
    }
    

}
