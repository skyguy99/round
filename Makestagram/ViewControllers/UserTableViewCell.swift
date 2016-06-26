//
//  UserTableViewCell.swift
//  Makestagram
//
//  Created by Randy Perecman on 6/23/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var userFullNameLabel: UILabel!
    @IBOutlet weak var userDetailsLabel: UILabel!
    @IBOutlet weak var profileImage2: UIImageView!
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