//
//  Forecast.swift
//  niftyFlatironWeather
//
//  Created by Joanna Tzu-Hsuan Huang on 10/28/16.
//  Copyright © 2016 Johann Kerr. All rights reserved.
//

import Foundation

enum ForecastType{
    case hourly, daily, currently
}

struct Forecast {
    var hourlyTemperature = 0.0
    var currentTemperature = 0.0
    var dailyTemperatures: (Double, Double) = (0.0,0.0)
    var summary: String
    var date: String
    
    init(dict: [String: Any], type: ForecastType){
        let dateDouble = dict["time"] as! Double
        let dateObj = Date(timeIntervalSince1970: dateDouble)
        let dateFormatter = DateFormatter()
        
        switch type{
        case .daily:
            self.dailyTemperatures.0 = dict["temperatureMin"] as! Double
            self.dailyTemperatures.1 = dict["temperatureMax"] as! Double
             dateFormatter.dateFormat = "EEE"
            break
        case .hourly:
            self.hourlyTemperature = dict["temperature"] as! Double
             dateFormatter.dateFormat = "HH:mm"
            break
        case .currently:
            self.currentTemperature = dict["apparentTemperature"] as! Double
            dateFormatter.dateFormat = "HH:mm"
        }
        
        self.date = dateFormatter.string(from: dateObj)
        self.summary = dict["summary"] as! String
    }

}
