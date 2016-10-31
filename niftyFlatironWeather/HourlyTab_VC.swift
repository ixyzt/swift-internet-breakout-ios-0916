//
//  HourlyTab_VC.swift
//  niftyFlatironWeather
//
//  Created by Erica Millado on 10/29/16.
//  Copyright © 2016 Johann Kerr. All rights reserved.
//

import UIKit

 class HourlyTab_VC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var store = DataStore.sharedInstance

    var latitude = Double()
    var longitude = Double()
    
    
    var tableView: UITableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.green
        self.title = "Hourly Weather"
        
         createTableView()
        var queue = OperationQueue()
        queue.qualityOfService = .background
        
        queue.addOperation {
            self.store.getWeather(for: .hourly, latitude: self.latitude, longitude: self.longitude) {
                print("This is the hourly array \(self.store.hourlyArray).")
                OperationQueue.main.addOperation {
                     self.tableView.reloadData()
                }
               
            }
        }
        
       
        
       
    }

    //MARK: Setup tableview
    func createTableView() {
        tableView = UITableView(frame: UIScreen.main.bounds, style: UITableViewStyle.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.green
        //method to tell the tableview how to create new cells before we dequeue them?
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "hourlycell")
        //adds our tableview to our view
        self.view.addSubview(self.tableView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return store.hourlyArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "hourlycell")
        //QUESTION - Why don't I dequeue a resuable cell here?
        let hour = store.hourlyArray[indexPath.row].date
        let hourlyTemp = Int(store.hourlyArray[indexPath.row].hourlyTemperature)
        let hourlySummary = store.hourlyArray[indexPath.row].summary
        cell.textLabel!.text = "\(hour)      Temp:   \(hourlyTemp)°"
        cell.detailTextLabel?.text = hourlySummary
        cell.backgroundColor = UIColor.green

        return cell
    }
    
//end of class
}




























