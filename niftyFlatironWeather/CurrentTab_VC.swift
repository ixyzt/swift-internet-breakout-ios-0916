//
//  CurrentTab_VC.swift
//  niftyFlatironWeather
//
//  Created by Erica Millado on 10/29/16.
//  Copyright © 2016 Johann Kerr. All rights reserved.
//

import UIKit

class CurrentTab_VC: UIViewController {
    
    var store = DataStore.sharedInstance
    
    var latitude = Double()
    var longitude = Double()
    
    let currentTempLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 350, height: 30))
    
    let currentSummaryLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 350, height: 30))

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.yellow
        self.title = "Current Weather"
        makeLabels()
        updateLabels()
        
        var queue = OperationQueue()
        queue.qualityOfService = .background
        queue.addOperation {
            self.store.getWeather(for: .currently, latitude: self.latitude, longitude: self.longitude) {
                print(self.store.currentlyArray)
                OperationQueue.main.addOperation {
                    self.view.reloadInputViews()
                }
            }
        }
        
    }
    
    func makeLabels() {
        
        currentTempLabel.center = CGPoint(x: 207, y: 285)
        currentTempLabel.textAlignment = .center
        currentTempLabel.text = ""
        currentTempLabel.font = UIFont(name: "Avenir Next", size: 30)
        self.view.addSubview(currentTempLabel)
        
        currentSummaryLabel.center = CGPoint(x: 207, y: 385)
        currentSummaryLabel.textAlignment = .center
        currentSummaryLabel.text = "Insert Summary Here"
        currentSummaryLabel.font = UIFont(name: "Avenir Next", size: 20)
        self.view.addSubview(currentSummaryLabel)
    }
    
    func updateLabels() {
        store.getWeather(for: .currently, latitude: latitude, longitude: longitude) {
            let currentTemp = Int(self.store.currentlyArray[0].currentTemperature)
            let currentSummary = self.store.currentlyArray[0].summary
            self.currentTempLabel.text = "It's currently \(currentTemp)°."
            print(currentTemp)
            self.currentSummaryLabel.text = currentSummary
        }
    }
//    func createTableView() {
//        tableView = UITableView(frame: UIScreen.main.bounds, style: UITableViewStyle.plain)
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.backgroundColor = UIColor.yellow
//        //method to tell tableview how to create new cells before we dequeue them?
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "currentlycell")
//        self.view.addSubview(self.tableView)
//    }
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        return self.store.forecastArray.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "currentlyCell")
//        
//        let currentTemp = store.forecastArray[indexPath.row].currentTemperature
//        let currentSummary = store.forecastArray[indexPath.row].summary
//        cell.textLabel?.text = String(currentTemp)
//        
//        cell.detailTextLabel?.text = currentSummary
//        cell.backgroundColor = UIColor.yellow
//        return cell
//    }
    
//end of class
}
















