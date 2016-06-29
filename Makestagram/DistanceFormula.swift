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

// func getMeterDistance() -> Double {
//    let myDormCL: CLLocation = CLLocation(latitude: Constants.myDormLocation.latitude, longitude: Constants.myDormLocation.longitude)
//
//    let myLocationCL: CLLocation = CLLocation(latitude: Constants.myLocation.latitude, longitude: Constants.myLocation.longitude)
//
//    let distance = myDormCL.distanceFromLocation(myLocationCL)
//    print("distance")
//    return distance
//}

func getMeterDistance(location1: CLLocationCoordinate2D, location2: CLLocationCoordinate2D) -> Double {
    let location1CL: CLLocation = CLLocation(latitude: location1.latitude, longitude: location1.longitude)
    
    let location2CL: CLLocation = CLLocation(latitude: location2.latitude, longitude: location2.longitude)
    
    let distance = location1CL.distanceFromLocation(location2CL)
    print("distance")
    return distance
}


       //         print("DISTANCE TO DORM: \(getMeterDistance())")