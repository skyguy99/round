//
//  Location.swift
//  Makestagram
//
//  Created by Randy Perecman on 6/23/16.
//  Copyright © 2016 Round. All rights reserved.
//

import Foundation
import MapKit

// Template for new locations 
class Location: NSObject {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
       
    }
}
