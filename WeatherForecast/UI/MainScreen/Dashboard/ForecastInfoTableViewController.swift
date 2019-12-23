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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewController = self
        self.presenter.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.presenter.viewWillDisappear(animated)
    }
    
    let cellIdentify = "ForecastCell"
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter.didSelectRowAt(indexPath: indexPath)
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
        if segue.identifier == "WeatherInfoViewController" {
            if let weatherInfoViewController = segue.destination as? WeatherInfoViewController {
                weatherInfoViewController.presenter = self.presenter
            }
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}

extension ForecastInfoTableViewController {
    
    func setSelectedCell(at row: Int) {
        let indexPath = IndexPath.init(row: row, section: 0)
        self.tableView.selectRow(at: indexPath, animated: false, scrollPosition: .top)
    }
    
}
