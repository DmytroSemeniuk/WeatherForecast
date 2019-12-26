//
//  ForecastInfoTableViewController.swift
//  WeatherForecast
//
//  Created by Dmitry Sem on 9/14/19.
//  Copyright © 2019 Dmitry Sem. All rights reserved.
//

import UIKit

class ForecastInfoTableViewController: UITableViewController {

    let presenter: ForecastListPresenter = ForecastListPresenter()
    
    @IBOutlet weak var cityButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewController = self
        self.presenter.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.presenter.viewWillDisappear(animated)
    }
    
    // MARK: - Input

    let cellIdentify = "ForecastCell"
    
    func fillCityButtonBy(cityName: String) {
        self.cityButton.title = cityName
    }
    
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter.didSelectRowAt(indexPath: indexPath)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
        if segue.identifier == "WeatherInfoViewController" {
            if let weatherInfoViewController = segue.destination as? WeatherInfoViewController {
                weatherInfoViewController.presenter = self.presenter
            }
        }
    }

}

extension ForecastInfoTableViewController {
    
    func setSelectedCell(at row: Int) {
        let indexPath = IndexPath.init(row: row, section: 0)
        self.tableView.selectRow(at: indexPath, animated: false, scrollPosition: .top)
    }
    
}
