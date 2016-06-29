//
//  Constants.swift
//  Makestagram
//
//  Created by Randy Perecman on 6/24/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import Foundation
import MapKit







class Constants {
   static var myLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: Constants.myLocation.latitude, longitude: Constants.myLocation.longitude)
    static var myDormLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 37.773510, longitude: -122.417805)
    
    static var distance = getMeterDistance(myLocation, location2: myDormLocation)
    
    static let locationManager = CLLocationManager()
    
}

    

