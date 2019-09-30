//
//  APIManager.swift
//  WeatherForecast
//
//  Created by Dmitry Sem on 8/30/19.
//  Copyright © 2019 Dmitry Sem. All rights reserved.
//


import UIKit
import Alamofire

class APIManager: NSObject {
    
    private static var uniqueInstance: APIManager?
    
    private override init() {}
    
    static func shared() -> APIManager {
        if uniqueInstance == nil {
            uniqueInstance = APIManager()
        }
        return uniqueInstance!
    }
    
    let apiKey: String = "d64161c08f711e4f08b0a4197c018779"
    let session = Alamofire.Session()
    let lat: Float = 35
    let lon: Float = 139
    func getWeather(completion: @escaping (DataResponse<ForecastInfo>) -> Void) -> Request {
        let url = "http://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&,uk&units=metric&APPID=\(apiKey)"
        
        // Set up the call and fire it off
        let request = session.request(url).responseDecodable(
            completionHandler: { (response: DataResponse<ForecastInfo>) in
                completion(response)
//                print(response)
                // Process the asynchronous response by returning it to the
                // caller; if successful, response includes a deserialized model
        })
        
        // Not necessary, but might be nice for debugging purposes
        return request
    }
}


