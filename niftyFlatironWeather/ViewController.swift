//
//  ViewController.swift
//  niftyFlatironWeather
//
//  Created by Johann Kerr on 10/27/16.
//  Copyright © 2016 Johann Kerr. All rights reserved.
//

import UIKit
import CoreLocation

//this VC will hold tab 1 and tab 2
class ViewController: UITabBarController, UITabBarControllerDelegate {

    let locationManager = CLLocationManager()
    var latitude = Double()
    var longitude = Double()
    
    let store = DataStore.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()

        //Assign self for delegate for our VC so we can respond to UITabBarControllerDelegate methods
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Create Daily Tab and its labels
        let dailyTab = DailyTabBar_VC()
        dailyTab.latitude = self.latitude
        dailyTab.longitude = self.longitude
        let dailyTabBarItem = UITabBarItem(title: "Daily Weather", image: UIImage(named: "calendarIconSmall.png"), selectedImage: UIImage(named:"calendarIconSmall.png"))
        dailyTab.tabBarItem = dailyTabBarItem
        
        //Create Hourly Tab and its labels
        let hourlyTab = HourlyTab_VC()
        hourlyTab.latitude = self.latitude
        hourlyTab.longitude = self.longitude
        let hourlyTabBarItem = UITabBarItem(title: "Hourly Weather", image: UIImage(named: "watch.png"), selectedImage: UIImage(named: "watch.png"))
        hourlyTab.tabBarItem = hourlyTabBarItem
        
        //Create Current Tab and its labels
        let currentTab = CurrentTab_VC()
        currentTab.latitude = self.latitude
        currentTab.longitude = self.longitude
        let currentTabBarItem = UITabBarItem(title: "Current Weather", image: UIImage(named: "hourglass.png"), selectedImage: UIImage(named: "hourglass.png"))
        currentTab.tabBarItem = currentTabBarItem
        
        //.viewControllers is an array of VCs to be displayed in tabbed form
        self.viewControllers = [currentTab, hourlyTab, dailyTab]
    }

    //UITabBarControllerDelegate method
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected \(viewController.title!)")
    }
    
//end class
}





extension ViewController: CLLocationManagerDelegate{
    func setupLocationManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        if let unwrappedlatitude = locationManager.location?.coordinate.latitude, let unwrappedLongitude = locationManager.location?.coordinate.longitude{
            self.latitude = unwrappedlatitude
            self.longitude = unwrappedLongitude
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
//end extension
}

