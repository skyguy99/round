//
//  ParseHelper.swift
//  round
//
//  Created by Skylar Thomas on 6/25/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import Foundation
import FBSDKCoreKit
import Parse
import ParseUI

class ParseHelper {
    
    // Following Relation
    static let ParseFollowClass       = "Follow"
    static let ParseFollowFromUser    = "fromUser"
    static let ParseFollowToUser      = "toUser"
    
    // Like Relation
    static let ParseLikeClass         = "Like"
    static let ParseLikeToPost        = "toPost"
    static let ParseLikeFromUser      = "fromUser"
    
    // Post Relation
    static let ParsePostUser          = "user"
    static let ParsePostCreatedAt     = "createdAt"
    
    // Flagged Content Relation
    static let ParseFlaggedContentClass    = "FlaggedContent"
    static let ParseFlaggedContentFromUser = "fromUser"
    static let ParseFlaggedContentToPost   = "toPost"
    
    // User Relation
    static let ParseUserUsername      = "username"
    static let ParseUserArray         = "userArray"
    
    /**
     Fetches all users that the provided user is following.
     
     :param: user The user whose followees you want to retrieve
     :param: completionBlock The completion block that is called when the query completes
     */
    static func getFollowingUsersForUser(user: PFUser, completionBlock: PFQueryArrayResultBlock) {
        let query = PFQuery(className: ParseFollowClass)
        
        query.whereKey(ParseFollowFromUser, equalTo:user)
        query.findObjectsInBackgroundWithBlock(completionBlock)
    }
    
    
    static func getUserArray(completionBlock: PFQueryArrayResultBlock){
        let query = PFUser.query()!
        
        query.findObjectsInBackgroundWithBlock(completionBlock)

    }
    
    static func getUsersAtHomeArray(completionBlock: PFQueryArrayResultBlock){
        let query = PFQuery(className: "hpePresentUsers")
         query.whereKey("atHome", equalTo: "YES")
        query.findObjectsInBackgroundWithBlock(completionBlock)
        
        
       // query.findObjectsInBackgroundWithBlock(completionBlock)
    
        
    }
    

    /**
     Establishes a follow relationship between two users.
     
     :param: user    The user that is following
     :param: toUser  The user that is being followed
     */
    static func addFollowRelationshipFromUser(user: PFUser, toUser: PFUser) {
        let followObject = PFObject(className: ParseFollowClass)
        followObject.setObject(user, forKey: ParseFollowFromUser)
        followObject.setObject(toUser, forKey: ParseFollowToUser)
        
        followObject.saveInBackgroundWithBlock(nil)
    }
    
    /**
     Deletes a follow relationship between two users.
     
     :param: user    The user that is following
     :param: toUser  The user that is being followed
     */
    static func removeFollowRelationshipFromUser(user: PFUser, toUser: PFUser) {
        let query = PFQuery(className: ParseFollowClass)
        query.whereKey(ParseFollowFromUser, equalTo:user)
        query.whereKey(ParseFollowToUser, equalTo: toUser)
        
        query.findObjectsInBackgroundWithBlock { (results: [PFObject]?, error: NSError?) -> Void in
            
            let results = results ?? []
            
            for follow in results {
                follow.deleteInBackgroundWithBlock(nil)
            }
        }
    }
    
    // MARK: Users
    
    /**
     Fetch all users, except the one that's currently signed in.
     Limits the amount of users returned to 20.
     
     :param: completionBlock The completion block that is called when the query completes
     
     :returns: The generated PFQuery
     */
//    static func allUsers(completionBlock: PFQueryArrayResultBlock) -> PFQuery {
//        let query = PFUser.query()!
//        // exclude the current user
//        //query.whereKey(ParseHelper.ParseUserUsername)
//        query.orderByAscending(ParseHelper.ParseUserUsername)
//        query.limit = 20
//        
//        query.findObjectsInBackgroundWithBlock(completionBlock)
//        
//        return query
//    }
    
    /**
     Fetch users whose usernames match the provided search term.
     
     :param: searchText The text that should be used to search for users
     :param: completionBlock The completion block that is called when the query completes
     
     :returns: The generated PFQuery
     */
    static func searchUsers(searchText: String, completionBlock: PFQueryArrayResultBlock) -> PFQuery {
        /*
         NOTE: We are using a Regex to allow for a case insensitive compare of usernames.
         Regex can be slow on large datasets. For large amount of data it's better to store
         lowercased username in a separate column and perform a regular string compare.
         */
        let query = PFUser.query()!.whereKey(ParseHelper.ParseUserUsername,
                                             matchesRegex: searchText, modifiers: "i")
        
        
        query.orderByAscending(ParseHelper.ParseUserUsername)
        query.limit = 20
        
        query.findObjectsInBackgroundWithBlock(completionBlock)
        
        return query
    }
}
