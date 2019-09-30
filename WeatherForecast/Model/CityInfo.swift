//
//  CityInfo.swift
//  WeatherForecast
//
//  Created by Dmitry Sem on 9/13/19.
//  Copyright © 2019 Dmitry Sem. All rights reserved.
//

import UIKit

class CityInfo: Codable {
    let id: Int?
    let name: String?
    let coord: Coord?
    let country: String?
}

// MARK: - Coord
struct Coord: Codable {
    let lat, lon: Double?
}
