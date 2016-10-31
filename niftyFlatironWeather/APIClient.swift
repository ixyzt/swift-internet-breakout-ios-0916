//
//  APIClient.swift
//  niftyFlatironWeather
//
//  Created by Joanna Tzu-Hsuan Huang on 10/28/16.
//  Copyright © 2016 Johann Kerr. All rights reserved.
//

import Foundation

class APIClient {

    var store = DataStore.sharedInstance
    
    //here is where I fetch the data
    class func getWeatherApi(latitude:Double, longitude: Double, completion:  @escaping ([String:Any])->()) {
        
        let urlString = "\(Secrets.apiURL)\(Secrets.apikey)\(latitude),\(longitude)"
    
        let url = URL(string: urlString)
        
        let session = URLSession.shared
        
        if let unwrappedURL = url {
            
            let dataTask = session.dataTask(with: unwrappedURL, completionHandler: { (data, response, error) in
                if let unwrappeddata = data {
                        do {
                            let responseJSON = try
                            JSONSerialization.jsonObject(with: unwrappeddata, options: []) as! [String: AnyObject]
                            completion(responseJSON)
//                            let summary = responseJSON["hourly"]?["summary"]
//                            print(summary)
//                            let data = responseJSON["hourly"]?["data"] as! [[String: AnyObject]]
//                            print(data.count)
//                            let firstDataDictionary = data[0]
//                            let temperature = firstDataDictionary["temperature"]
//                            print(temperature)
                        } catch {
                            print("Catch achieved here.")
                        }
            }
            })
            dataTask.resume()
        }
    }
}
