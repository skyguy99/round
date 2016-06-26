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
   
    
    weak var delegate: FriendSearchTableViewCellDelegate?
    
    var user: PFUser? {
        
        /*var first = String(user!["firstName"])
        var last = String (user!["lastName"])*/
        
        didSet {
            name.text = "\(user!["firstName"]) \(user!["lastName"])"
            
            let current = PFUser.currentUser()
            
            if(name.text == "\(current!["firstName"]) \(current!["lastName"])")
            {
                
                self.backgroundColor = UIColor(red: 241/255, green: 73/255, blue: 97/255, alpha: 1)
                name.textColor = UIColor.whiteColor()
            }
            else {
                self.backgroundColor = UIColor.whiteColor()
                name.textColor = UIColor(red: 241/255, green: 73/255, blue: 97/255, alpha: 1)
                
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
        
       
        
//        var tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("cellTapped:"))
//        self.userInteractionEnabled = true
//        self.addGestureRecognizer(tapGestureRecognizer)
        
        }
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
