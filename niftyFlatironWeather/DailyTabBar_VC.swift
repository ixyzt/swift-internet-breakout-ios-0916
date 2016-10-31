//
//  DailyTabBar_VC.swift
//  niftyFlatironWeather
//
//  Created by Erica Millado on 10/29/16.
//  Copyright © 2016 Johann Kerr. All rights reserved.
//

import UIKit


class DailyTabBar_VC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var store = DataStore.sharedInstance
    
    var latitude = Double()
    var longitude = Double()
    
    var tableView: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.cyan
        self.title = "Daily Weather"
        
        createTableView()
        
        var queue = OperationQueue()
        queue.qualityOfService = .background
        queue.addOperation {
            self.store.getWeather(for: .daily, latitude: self.latitude, longitude: self.longitude) {
                print("This is the daily array \(self.store.dailyArray).")
                OperationQueue.main.addOperation {
                    self.tableView.reloadData()
                }
            }
        }
        
    }

    // MARK: Setup tableview
    
    func createTableView() {
        tableView = UITableView(frame: UIScreen.main.bounds, style: UITableViewStyle.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.cyan
        //method to tell the table view how to create new cells before we dequeue them
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "dailycell")
        //adds our tableview to our view
        self.view.addSubview(self.tableView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return self.store.dailyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "dailycell")
        let date = store.dailyArray[indexPath.row].date
        let dailySummary = store.dailyArray[indexPath.row].summary
        let minTemp = Int(store.dailyArray[indexPath.row].dailyTemperatures.0)
        let maxTemp = Int(store.dailyArray[indexPath.row].dailyTemperatures.1)
        
        cell.textLabel!.text = "\(date)           Min:  \(minTemp)°            Max:  \(maxTemp)°"
        cell.detailTextLabel?.text = dailySummary
        cell.backgroundColor = UIColor.cyan
        return cell
    }
    

//end of class
}






























