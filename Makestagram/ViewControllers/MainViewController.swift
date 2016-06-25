//
//  MainTableViewController.swift
//  Makestagram
//
//  Created by Randy Perecman on 6/23/16.
//  Copyright © 2016 Make School. All rights reserved.
//
import MapKit
import UIKit
import Parse
import CoreLocation

class MainViewController: UIViewController, CLLocationManagerDelegate, UITableViewDataSource, MKMapViewDelegate {

   
    
    // Manages location of user
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("My Location = \(locValue.latitude) \(locValue.longitude)")
        print("Dorm Location = \(Constants.myDormLocation.latitude) \(Constants.myDormLocation.longitude)")
        Constants.myLocation = locValue
        isUserHome()
    }
   
   
    @IBOutlet weak var tableView: UITableView!
    
    
    
 
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        // hardcoded value of 1140 Enterprise Way
        let myDorm = Location(title: "11140 Enterprise Way", coordinate: CLLocationCoordinate2D(latitude: 37.410348, longitude: -122.036445))
        // values for user
        let myUser = Location(title: (PFUser.currentUser()?.username)!, coordinate: CLLocationCoordinate2D(latitude: Constants.myLocation.latitude, longitude: Constants.myLocation.longitude))
        
        // Ask for Authorisation from the User.
        Constants.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        Constants.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            Constants.locationManager.delegate = self
            Constants.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            Constants.locationManager.startUpdatingLocation()
        }
        
        
    
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//                func getMeterDistance() -> Double {
//                    let myDormCL: CLLocation = CLLocation(latitude: Constants.myDormLocation.latitude, longitude: Constants.myDormLocation.longitude)
//        
//                    let myLocationCL: CLLocation = CLLocation(latitude: Constants.myLocation.latitude, longitude: Constants.myLocation.longitude)
//        
//                    var distance = myDormCL.distanceFromLocation(myLocationCL)
//        
//        
//                    return distance
//                }
//       //         print("DISTANCE TO DORM: \(getMeterDistance())")
    



    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        // return usersPresent.count 
        return 3
        
    }

    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        if indexPath.row == 0 {
         let cell = tableView.dequeueReusableCellWithIdentifier("locationCell", forIndexPath: indexPath)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCellWithIdentifier("userCell", forIndexPath: indexPath)
            return cell
        }
    

        // Configure the cell...

        
    }
    

   

    
    

   
    



    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}



