//
//  UserSearchTableCell.swift
//  round
//
//  Created by Skylar Thomas on 6/25/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit
import Parse

protocol FriendSearchTableViewCellDelegate: class {
    func cell(cell: UserSearchTableCell, didSelectFollowUser user: PFUser)
    func cell(cell: UserSearchTableCell, didSelectUnfollowUser user: PFUser)
}

class UserSearchTableCell: UITableViewCell {

    @IBOutlet var name: UILabel!
    @IBOutlet var settingsBtn: UIButton!
    
    weak var delegate: FriendSearchTableViewCellDelegate?
    
    var user: PFUser? {
        
        /*var first = String(user!["firstName"])
        var last = String (user!["lastName"])*/
        
        didSet {
            name.text = "\(user!["firstName"]) \(user!["lastName"])"
            let current = PFUser.currentUser()
            
            if(name.text != "\(current!["firstName"]) \(current!["lastName"])")
            {
                settingsBtn.hidden = true
            }
            else {
                self.backgroundColor = UIColor(red: 241/255, green: 73/255, blue: 97/255, alpha: 1)
                name.textColor = UIColor.whiteColor()
                
            }

        }
    }
    
    var canFollow: Bool? = true {
        didSet {
            /*
             Change the state of the follow button based on whether or not
             it is possible to follow a user.
             */
            /*if let canFollow = canFollow {
                settingsBtn.selected = !canFollow
            }*/
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
