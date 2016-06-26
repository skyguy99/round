//
//  LocationTableViewCell.swift
//  Makestagram
//
//  Created by Randy Perecman on 6/23/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit
import MapKit

class LocationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var peoplePresentLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

// selection is off so be aware
