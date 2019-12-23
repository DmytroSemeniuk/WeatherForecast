//
//  CitySearchTableViewCell.swift
//  WeatherForecast
//
//  Created by Dmitry Sem on 23.12.2019.
//  Copyright © 2019 Dmitry Sem. All rights reserved.
//

import UIKit

class CitySearchTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension CitySearchTableViewCell: DataAwareCell {
    
    func fillWithData(_ data: DataSourceItem) {
        if let cityInfo = data.payload as? CitySearchInfo {
            self.textLabel?.text = cityInfo.name
        }
    }
    
}
