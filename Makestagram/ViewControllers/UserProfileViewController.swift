//
//  UserProfileViewController.swift
//  Pods
//
//  Created by Skylar Thomas on 6/25/16.
//
//

import UIKit
import Parse

class UserProfileViewController: UIViewController {
    
    @IBOutlet var shadowView: UIView!
    @IBOutlet var profileView: UIView!
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var usernameLabel: UILabel?
    @IBOutlet var nameLabel: UILabel?
    @IBOutlet var locationLabel: UILabel!
    
    @IBOutlet var userSearch: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    @IBAction func editInfo(sender: AnyObject) {
        print("edit info")
        
        //profileView.hidden = false
    }
    
    let imagePicker = UIImagePickerController()
    
    var viewGestureRecognizer = UITapGestureRecognizer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shadowView.hidden = true
        profileView.layer.cornerRadius = 8
        profileView.hidden = true;
        
        userSearch.barTintColor = colorWithHexString("F46476")
        
        // Do any additional setup after loading the view.
        print("Users loaded")
        
        
        // let user = PFUser.currentUser(); should delete
        //print(user);
        
//        var first = String(user!["firstName"]) // should delete
//        var last = String (user!["lastName"])   // should delete
        
        viewGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(UserProfileViewController.removeProfileView(_:)))
        view.userInteractionEnabled = true
        view.addGestureRecognizer(viewGestureRecognizer)
        viewGestureRecognizer.enabled = false
        
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    func removeProfileView(sender: AnyObject)
    {
        UIView.animateWithDuration(0.25, animations: {
            self.profileView.transform = CGAffineTransformMakeScale(1.3, 1.3)
            self.profileView.alpha = 0.0;
            }, completion:{(finished : Bool)  in
                if (finished)
                {
                    self.profileView.hidden = true
                    self.viewGestureRecognizer.enabled = false
                    self.shadowView.hidden = true
                    //self.keyboardGestureRecognizer.enabled = false
                }
        });
        print("remove")
    }
    
    func imageTapped(img: AnyObject) {
        print("change profile image")
        
        /*if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum){
         print("Button capture")
         
         
         //imagePicker.delegate = self
         imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum;
         imagePicker.allowsEditing = false
         
         self.presentViewController(imagePicker, animated: true, completion: nil)
         }*/
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
        
        profileImage.image = image
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    /*func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     // #warning Incomplete implementation, return the number of rows
     //         return usersPresent.count
     return 1
     
     }
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCellWithIdentifier("userSearchCell", forIndexPath: indexPath)
     return cell
     }*/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //This is new---
    
    // stores all the users that match the current search query
    var users: [PFUser]?
    
    /*
     This is a local cache. It stores all the users this user is following.
     It is used to update the UI immediately upon user interaction, instead of
     having to wait for a server response.
     */
    var followingUsers: [PFUser]? {
        didSet {
            /**
             the list of following users may be fetched after the tableView has displayed
             cells. In this case, we reload the data to reflect "following" status
             */
            tableView.reloadData()
        }
    }
    
    // the current parse query
    var query: PFQuery? {
        didSet {
            // whenever we assign a new query, cancel any previous requests
            // you can use oldValue to access the previous value of the property
            oldValue?.cancel()
        }
    }
    
    // this view can be in two different states
    enum State {
        case DefaultMode
        case SearchMode
    }
    
    
    // whenever the state changes, perform one of the two queries and update the list
    var state: State = .DefaultMode {
        didSet {
            switch (state) {
                
            case .SearchMode:
                let searchText = userSearch?.text ?? ""
                query = ParseHelper.searchUsers(searchText, completionBlock:updateList)
                //keyboardGestureRecognizer.enabled = true //test
                
                
            case .DefaultMode:
                print("nothing")
                //keyboardGestureRecognizer.enabled = false
            }
        }
    }
    // MARK: Update userlist
    
    /**
     Is called as the completion block of all queries.
     As soon as a query completes, this method updates the Table View.
     */
    func updateList(results: [PFObject]?, error: NSError?) {
        self.users = results as? [PFUser] ?? []
        self.tableView.reloadData()
        
    }
    
    // MARK: View Lifecycle
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        state = .DefaultMode
        
        // fill the cache of a user's followees
        ParseHelper.getFollowingUsersForUser(PFUser.currentUser()!) { (results: [PFObject]?, error: NSError?) -> Void in
            let relations = results ?? []
            // use map to extract the User from a Follow object
            self.followingUsers = relations.map {
                $0.objectForKey(ParseHelper.ParseFollowToUser) as! PFUser
            }
            
        }
    }
    
}

// MARK: TableView Data Source

extension UserProfileViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let user = self.users![indexPath.row]
        
        if(profileView.hidden)
        {
            profileView.hidden = false
            
            //profileView.transform = CGAffineTransformMakeScale(1.3, 1.3)
            
            self.profileView.transform = CGAffineTransformMakeScale(1.3, 1.3)
            self.profileView.alpha = 0.0;
            UIView.animateWithDuration(0.25, animations: {
                self.profileView.alpha = 1.0
                self.profileView.transform = CGAffineTransformMakeScale(1.0, 1.0)
                self.viewGestureRecognizer.enabled = true
                self.shadowView.hidden = false
                self.dismissKeyboard()
                //self.keyboardGestureRecognizer.enabled = true
            });
        }
        usernameLabel?.text = user.username
        nameLabel?.text = "\(user["firstName"]) \(user["lastName"])"
        locationLabel.text = "Dorm \(user["roomNumber"])"
        
        if user.username == "miriam"
        {
            profileImage.image = UIImage(named: "mlogo.png")
                 }
        else if user.username == "justinjlee99"
        {
            profileImage.image = UIImage(named: "jlogo.png")
        }
        else if user.username == "Patrick"
        {
            profileImage.image = UIImage(named: "plogo.png")
        }
        else if user.username == "skyyguy"
        {
            profileImage.image = UIImage(named: "logo1.png")
        }
        
        else if user.username == "Randy"
        {
            profileImage.image = UIImage(named: "jlogo 2.png")
        }
        else{
            profileImage.image = UIImage(named: "round_logo")
        }
        
        // set labels and imageview below
        
    }
}

extension UserProfileViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("userSearchCell") as! UserSearchTableCell
        
        let user = users![indexPath.row]
        cell.user = user
        
        /*if let followingUsers = followingUsers {
         // check if current user is already following displayed user
         // change button appereance based on result
         cell.canFollow = !followingUsers.contains(user)
         }*/
        
        cell.delegate = self
        
        return cell
    }
}

// MARK: Searchbar Delegate

extension UserProfileViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        state = .SearchMode
        
        for ob: UIView in ((searchBar.subviews[0] )).subviews {
            
            if let z = ob as? UIButton {
                let btn: UIButton = z
                btn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            }
        }
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        searchBar.setShowsCancelButton(false, animated: true)
        state = .DefaultMode
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        ParseHelper.searchUsers(searchText, completionBlock:updateList)
    }
    
}

// MARK: FriendSearchTableViewCell Delegate

extension UserProfileViewController: FriendSearchTableViewCellDelegate {
    
    func cell(cell: UserSearchTableCell, didSelectFollowUser user: PFUser) {
        ParseHelper.addFollowRelationshipFromUser(PFUser.currentUser()!, toUser: user)
        // update local cache
        followingUsers?.append(user)
    }
    
    func cell(cell: UserSearchTableCell, didSelectUnfollowUser user: PFUser) {
        if let followingUsers = followingUsers {
            ParseHelper.removeFollowRelationshipFromUser(PFUser.currentUser()!, toUser: user)
            // update local cache
            self.followingUsers = followingUsers.filter({$0 != user})
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
