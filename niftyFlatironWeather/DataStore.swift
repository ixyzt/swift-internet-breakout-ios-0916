//
//  DataStore.swift
//  niftyFlatironWeather
//
//  Created by Erica Millado on 10/28/16.
//  Copyright © 2016 Johann Kerr. All rights reserved.
//

import Foundation
import CoreLocation

class DataStore {

    static let sharedInstance = DataStore()
    private init() {}
    
    var hourlyArray = [Forecast]()
    var dailyArray = [Forecast]()
    var currentlyArray = [Forecast]()
    let locationManager = CLLocationManager()
    var latitude = Double()
    var longitude = Double()
    
    //using the datastore as a hub for the data; here the completion acts as the person "opening and closing the doors"
    func getWeather(for period:ForecastType, latitude:Double, longitude:Double, completion:@escaping ()->()) {
        
        APIClient.getWeatherApi(latitude: latitude, longitude: longitude) { (weatherDict) in
            if period == .hourly  {
                var hourlyOrDailyDict = weatherDict["\(period)"] as! [String:Any]
                let hourlyOrDailyDataArrayOfDict = hourlyOrDailyDict["data"] as! [[String:Any]]
                for dataDict in hourlyOrDailyDataArrayOfDict {
                    let forecast = Forecast(dict: dataDict, type: period)
                    self.hourlyArray.append(forecast)
                }
            } else if period == .currently {
                let currentlyDict = weatherDict["\(period)"] as! [String:Any]
                let forecast = Forecast(dict: currentlyDict, type: period)
                self.currentlyArray.append(forecast)
            } else if period == .daily {
                var hourlyOrDailyDict = weatherDict["\(period)"] as! [String:Any]
                let hourlyOrDailyDataArrayOfDict = hourlyOrDailyDict["data"] as! [[String:Any]]
                for dataDict in hourlyOrDailyDataArrayOfDict {
                    let forecast = Forecast(dict: dataDict, type: period)
                    self.dailyArray.append(forecast)
                }
            }
            completion()
        }
        
//        APIClient.getWeatherApi { (weatherDict) in
//           
//        }
      }

 //end
 }




