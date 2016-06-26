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
        
        
        fillUserArray()

        isUserHome()
        

        updateUserAtHome()

    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var user = PFUser.currentUser()
    
    
    var usersArray: [PFUser] = []
    
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        print("view did load")
        


        
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        UIApplication.sharedApplication().statusBarHidden = false
      //  presentTotalLabel.text = "\(usersArray.count) people present"
         setStatusBarBackgroundColor((UIColor(colorLiteralRed: 244.0/255, green: 100.0/255, blue: 118.0/255, alpha: 1)))
        
        // hardcoded value of 1140 Enterprise Way
        // values for user
        // Ask for Authorisation from the User.
        Constants.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        Constants.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            Constants.locationManager.delegate = self
            Constants.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            Constants.locationManager.startUpdatingLocation()
        }
        
        print("CLLocationManager enabled")
        
    }

    
    func isUserHome() {                 // Algo determining if user is within "home" area
        let nine = 0.00011
        if Constants.myDormLocation.latitude > Constants.myLocation.latitude {
            let latDiff = Constants.myDormLocation.latitude - Constants.myLocation.latitude
            print("latdiff \(latDiff)")
            if latDiff < nine {
                // The latitudes are close to eachother
                // Check if longitudes are close to eachother also
                if Constants.myDormLocation.longitude > Constants.myLocation.longitude {
                    let longDiff = Constants.myDormLocation.longitude - Constants.myLocation.longitude
                    print("longDiff \(longDiff)")

                    if longDiff < nine {
                        // Longitudes are close to eachother also
                        atHome = true
                        print("Welcome Home")
                    }
                }
                else {
                    let longDiff = Constants.myLocation.longitude - Constants.myDormLocation.longitude
                    print("longDiff \(longDiff)")

                    if longDiff < nine {
                        // Longitudes are close to eachother also
                        atHome = true
                        print("Welcome Home")

                        
                    }
                }
            }
            else {
                // the latitudes are NOT close to eachother
                atHome = false // should be false
                print("You arent home")
                
            }
        }
        else { // Initial if statement
            
            
            
            let latDiff = Constants.myLocation.latitude - Constants.myDormLocation.latitude
            print("latdiff \(latDiff)")
            if latDiff < nine {
                // The latitudes are close to eachother
                // Check if longitudes are close to eachother also
                if Constants.myDormLocation.longitude > Constants.myLocation.longitude {
                    let longDiff = Constants.myDormLocation.longitude - Constants.myLocation.longitude
                    if longDiff < nine {
                        // Longitudes are close to eachother also
                        atHome = true
                        print("Welcome Home")

                        
                    }
                }
                else {
                    let longDiff = Constants.myLocation.longitude - Constants.myDormLocation.longitude
                    if longDiff < nine {
                        // Longitudes are close to eachother also
                        atHome = true
                        print("Welcome Home")

                        
                    }
                }
            }
            else {
                // the latitudes are NOT close to eachother
                atHome = false // should be false
                print("You arent home")
                
            }
        }
        
        
        
        
        
        
    }
        func fillUserArray() {
            usersArray = []
            
            let query = PFUser.query()!
            query.whereKey("atHome", equalTo: "YES")
            let v = try! query.findObjects()
//            print(v)
            if(v.count > 0){
            for user in v {
                self.usersArray.append((user as? PFUser)!)
            }
            
            }
    
            tableView.reloadData()
        }
    
    
    func updateUserAtHome() {
        
        
//        usersArray = []
//
//        let query = PFUser.query()!
//        query.whereKey("atHome", equalTo: "YES")
//        let v = try! query.findObjects()
//        print(v)
//        
//        ParseHelper.getUsersAtHomeArray{ (results: [PFObject]?, error: NSError?) -> Void in
//            if let results = results {
//                for user in results {
//                    self.usersArray.append((user as? PFUser)!)
//                }
//            }
//            else{
//                print("help me")
//            }
//        }
        
//        tableView.reloadData()
        
        
//         fillUserArray()
        
        if atHome == true {
            //User is HOME!!!
            print("USER IS HOME")
            user!["atHome"] = "YES"        //  ->>>>>>>>>>>>>>>>>>>>>>>>>>>> PARSE
            // Do we add him to the array??
            if !usersArray.contains(user!) {
                // Add to the array
                usersArray.append(user!)
                user?.saveInBackground()
//                 print(user!["atHome"])
                
                
            }
            else {
            print("USER NOT HOME")

//                // do nothing bc hes already in the array
            }
//
        }
            
        else {
            //He is not home!!! Is he in the array??
            if usersArray.contains(user!) {
                // if he is, then take him out of the array
                usersArray.removeAtIndex(usersArray.indexOf(user!)!)
                print("User is not home")
                user!["atHome"] = "No"          // ->>>>>>>>>>>>>>>>>>>>>>>> PARSE
                user?.saveInBackground()
            }
            else {
                print("USER NOT HOME")
                // do nothing bc hes already out of the array
            }
            
//             print(user!["atHome"])
        }
        tableView.reloadData()
    }
    
    func setStatusBarBackgroundColor(color: UIColor) {
        
        guard let statusBar = UIApplication.sharedApplication().valueForKey("statusBarWindow")?.valueForKey("statusBar") as? UIView else
        {
            return
        }
        
        statusBar.backgroundColor = color
    }
    
    
    
    
    
    
    
    
    
    
    
    // MARK: - Table view data source
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 200
        }
        else {
            return 70
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, RETURN NUMBER OF SECTIONS
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, RETURN THE NUMBER OF ROWS
        
        
        print("users in home: \(usersArray.count)")
        
        return usersArray.count + 1
    }
    
    
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("locationCell", forIndexPath: indexPath) as! LocationTableViewCell
            
            let center = CLLocationCoordinate2D(latitude: Constants.myDormLocation.latitude, longitude: Constants.myDormLocation.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            
            let objectAnnotation = MKPointAnnotation()
            objectAnnotation.coordinate = center
            objectAnnotation.title = "HPE"
            cell.mapView.addAnnotation(objectAnnotation)
            
            
            cell.mapView.setRegion(region, animated: true)
            
            return cell
        }
        else {
            let cell: UserTableViewCell = tableView.dequeueReusableCellWithIdentifier("userCell", forIndexPath: indexPath) as! UserTableViewCell
            
            let userAtHome = usersArray[indexPath.row - 1]
            
            // print("Index is at: \(indexPath.row - 1)")
            
            // edit label to full name of user
            let first = userAtHome["firstName"]
            let last = userAtHome["lastName"]
            cell.userFullNameLabel.text = String("\(first) \(last)")
            
            if userAtHome.username == "miriam"
            {
                cell.profileImage2.image = UIImage(named: "mlogo.png")
            }
            else if userAtHome.username == "justinjlee99"
            {
                cell.profileImage2.image = UIImage(named: "jlogo.png")
            }
            else if userAtHome.username  == "Patrick"
            {
                cell.profileImage2.image = UIImage(named: "plogo.png")
            }
            else if userAtHome.username == "skyyguy"
            {
                cell.profileImage2.image = UIImage(named: "logo1.png")
            }
                
            else if userAtHome.username == "Randy"
            {
                cell.profileImage2.image = UIImage(named: "jlogo 2.png")
            }
            else{
                cell.profileImage2.image = UIImage(named: "round_logo")
            }

            
            // return cell
            return cell
            
        }
    }
    
    
    
    
}

func colorWithHexString (hex:String) -> UIColor {
    var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString
    
    if (cString.hasPrefix("#")) {
        cString = (cString as NSString).substringFromIndex(1)
    }
    
    if (cString.characters.count != 6) {
        return UIColor.grayColor()
    }
    
    let rString = (cString as NSString).substringToIndex(2)
    let gString = ((cString as NSString).substringFromIndex(2) as NSString).substringToIndex(2)
    let bString = ((cString as NSString).substringFromIndex(4) as NSString).substringToIndex(2)
    
    var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
    NSScanner(string: rString).scanHexInt(&r)
    NSScanner(string: gString).scanHexInt(&g)
    NSScanner(string: bString).scanHexInt(&b)
    
    
    return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
}

// MARK: - Navigation




