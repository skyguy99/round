//
//  DistanceFormula.swift
//  Makestagram
//
//  Created by Randy Perecman on 6/24/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import Foundation
import MapKit
import Parse

//var atHome: Bool = false
//
//func isUserHome() {
//    var one = 0.001
//    var two = 0.0002
//    var three = 0.0003
//    var four = 0.0004
//    var five = 0.0005
//    var six = 0.0006
//    var seven = 0.0007
//    var eight = 0.0008
//    var nine = 0.0009
//    
//    var user = PFUser.currentUser()
//    var usersArray: [PFUser] = []
//    
//    if Constants.myDormLocation.latitude > Constants.myLocation.latitude {
//        var latDiff = Constants.myDormLocation.latitude - Constants.myLocation.latitude
//        if latDiff < nine {
//            // The latitudes are close to eachother
//            // Check if longitudes are close to eachother also
//            if Constants.myDormLocation.longitude > Constants.myLocation.longitude {
//                var longDiff = Constants.myDormLocation.longitude - Constants.myLocation.longitude
//                if longDiff < nine {
//                    // Longitudes are close to eachother also
//                    atHome = true
//                }
//            }
//            else {
//                var longDiff = Constants.myLocation.longitude - Constants.myDormLocation.longitude
//                if longDiff < nine {
//                    // Longitudes are close to eachother also
//                    atHome = true
//                    
//                }
//            }
//        }
//        else {
//            // the latitudes are NOT close to eachother
//            atHome = false
//            
//        }
//    }
//    else { // Initial if statement
//        
//        
//        
//        var latDiff = Constants.myLocation.latitude - Constants.myDormLocation.latitude
//        if latDiff < nine {
//            // The latitudes are close to eachother
//            // Check if longitudes are close to eachother also
//            if Constants.myDormLocation.longitude > Constants.myLocation.longitude {
//                var longDiff = Constants.myDormLocation.longitude - Constants.myLocation.longitude
//                if longDiff < nine {
//                    // Longitudes are close to eachother also
//                    atHome = true
//                    
//                }
//            }
//            else {
//                var longDiff = Constants.myLocation.longitude - Constants.myDormLocation.longitude
//                if longDiff < nine {
//                    // Longitudes are close to eachother also
//                    atHome = true
//                    
//                }
//            }
//        }
//        else {
//            // the latitudes are NOT close to eachother
//            atHome = false
//            
//        }
//    }
//    
//    
//    
//    
//    if atHome == true {
//        print("USER IS HOME")
//        user!["atHome"] = "YES"
//        usersArray.append(user!)
//        user?.saveInBackground()
//        print(user!["atHome"])
//        
//    }
//        
//    else {
//        print("nah")
//        user!["atHome"] = "No"
//        user?.saveInBackground()
//        print(user!["atHome"])
//    }
//    
//    
//    
//    
//    
//    
//}
//
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
