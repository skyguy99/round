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

    
    func isUserHome() {
        
        
        if Constants.distance < 30.0 { // ofoucrse gonna say not home
            user!["atHome"] = true
            user?.saveInBackground() // save to change in back with block
            
        }
        else {
            user!["atHome"] = false
            user?.saveInBackground() // change to save in back with block
        }
        
        print("At Home:  \(atHome)")
        
    }
        func fillUserArray() {
            usersArray = []
            
            let query = PFUser.query()!
            query.whereKey("atHome", equalTo: true)
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
        
        
        
        if user!["atHome"] as! Bool == true {
            //User is HOME!!!
            print("USER IS HOME")
            // Do we add him to the array??
            if !usersArray.contains(user!) {
                // Add to the array
                usersArray.append(user!)
                
                user?.saveInBackground()
                
                
                
            }
            else {
                // do nothing bc hes already in the array
            }

        }
            
        else {
            print("User is not home")
        
            //He is not home!!! Is he in the array??
            if usersArray.contains(user!) {
                // if he is, then take him out of the array
                usersArray.removeAtIndex(usersArray.indexOf(user!)!)
                user?.saveInBackground()
            }
            else {
                print("User is not home")
                // do nothing bc hes already out of the array
            }
            
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
            
            if(userAtHome.username == PFUser.currentUser()?.username)
            {
                
                cell.layer.backgroundColor = UIColor(colorLiteralRed: 244.0/255, green: 100.0/255, blue: 118.0/255, alpha: 0.5).CGColor
                //cell.textLabel?.textColor = UIColor.whiteColor()
                cell.userFullNameLabel?.textColor = UIColor.whiteColor()
                
//                let logOut = UITableViewRowAction(style: .Normal, title: "Log Out") { action, index in
//                    print("log out button tapped")
//                    PFUser.logOut()
//                    
//                }
//                logOut.backgroundColor = UIColor.lightGrayColor()
//                return[logOut]
            }
            
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
            else if userAtHome.username  == "patrick "
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
    
    
   
func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // the cells you would like the actions to appear needs to be editable
    return true
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




