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

class MainViewController: UIViewController, CLLocationManagerDelegate, UITableViewDataSource, MKMapViewDelegate, UITableViewDelegate {
    
    
    @IBOutlet weak var userDetails: UILabel!
    @IBOutlet weak var userFullName: UILabel!
    
    var atHome: Bool = false
    
    // Manages location of user
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("My Location = \(locValue.latitude) \(locValue.longitude)")
        print("Dorm Location = \(Constants.myDormLocation.latitude) \(Constants.myDormLocation.longitude)")
        Constants.myLocation = locValue
        
        
        isUserHome()
        fillUserArray()
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var user = PFUser.currentUser()
    
    
    var usersArray: [PFUser] = []
    
    func isUserHome() {
        var one = 0.001
        var two = 0.0002
        var three = 0.0003
        var four = 0.0004
        var five = 0.0005
        var six = 0.0006
        var seven = 0.0007
        var eight = 0.0008
        var nine = 0.0009
        

        
        
        if Constants.myDormLocation.latitude > Constants.myLocation.latitude {
            var latDiff = Constants.myDormLocation.latitude - Constants.myLocation.latitude
            if latDiff < nine {
                // The latitudes are close to eachother
                // Check if longitudes are close to eachother also
                if Constants.myDormLocation.longitude > Constants.myLocation.longitude {
                    var longDiff = Constants.myDormLocation.longitude - Constants.myLocation.longitude
                    if longDiff < nine {
                        // Longitudes are close to eachother also
                        atHome = true
                    }
                }
                else {
                    var longDiff = Constants.myLocation.longitude - Constants.myDormLocation.longitude
                    if longDiff < nine {
                        // Longitudes are close to eachother also
                        atHome = true
                        
                    }
                }
            }
            else {
                // the latitudes are NOT close to eachother
                atHome = true // should be false
                
            }
        }
        else { // Initial if statement
            
            
            
            var latDiff = Constants.myLocation.latitude - Constants.myDormLocation.latitude
            if latDiff < nine {
                // The latitudes are close to eachother
                // Check if longitudes are close to eachother also
                if Constants.myDormLocation.longitude > Constants.myLocation.longitude {
                    var longDiff = Constants.myDormLocation.longitude - Constants.myLocation.longitude
                    if longDiff < nine {
                        // Longitudes are close to eachother also
                        atHome = true
                        
                    }
                }
                else {
                    var longDiff = Constants.myLocation.longitude - Constants.myDormLocation.longitude
                    if longDiff < nine {
                        // Longitudes are close to eachother also
                        atHome = true
                        
                    }
                }
            }
            else {
                // the latitudes are NOT close to eachother
                atHome = true // should be false
                
            }
        }
        

        
       


    }
    func fillUserArray() {
        if atHome == true {
            //User is HOME!!! Do we add him to the array??
            print("USER IS HOME")
            user!["atHome"] = "YES"
            if !usersArray.contains(user!) {
                // Add to the array
                usersArray.append(user!)
                user?.saveInBackground()
                print(user!["atHome"])
            }
            else {
            // do nothing bc hes already in
            }
            
        }
            
        else {
            //He is not home!!! Is he in the array??
            if usersArray.contains(user!) {
                //Take out of array
                usersArray.removeAtIndex(usersArray.indexOf(user!)!)
            }
            else {
                // do nothing bc hes already out
            }
            print("nah")
            user!["atHome"] = "No"
            user?.saveInBackground()
            print(user!["atHome"])
        }
        tableView.reloadData()
    }

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
        
        //
        //    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        //        return 200
    
        //    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        // print("# of users \(usersArray.count)")
        // return usersArray.count + 1
        
        print("users in array: \(usersArray.count)")

        return usersArray.count + 1
    }
    
        func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }
        
    
        func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
            if indexPath.row == 0 {
                return 200
            } else {
                return 70
            }
        }
    
        
        
        
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            
            
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier("locationCell", forIndexPath: indexPath) as! LocationTableViewCell
                
                let center = CLLocationCoordinate2D(latitude: Constants.myDormLocation.latitude, longitude: Constants.myDormLocation.longitude)
                let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                
                var objectAnnotation = MKPointAnnotation()
                objectAnnotation.coordinate = center
                objectAnnotation.title = "HPE"
                cell.mapView.addAnnotation(objectAnnotation)
                
                
                cell.mapView.setRegion(region, animated: true)
                
                return cell
            }
            else {
                let cell: UserTableViewCell = tableView.dequeueReusableCellWithIdentifier("userCell", forIndexPath: indexPath) as! UserTableViewCell
                
                
                let userAtHome = usersArray[indexPath.row - 1]
                
                print("Index is at: \(indexPath.row - 1)")
                
                cell.userFullNameLabel.text = String(userAtHome["firstName"])
                print(cell.userFullNameLabel.text)
                return cell
                
            }
    }
        

    
    
}

        // MARK: - Navigation




