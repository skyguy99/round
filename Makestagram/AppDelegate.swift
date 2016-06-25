//
//  AppDelegate.swift
//  Makestagram
//
//  Created by Benjamin Encz on 5/15/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Parse
import FBSDKCoreKit
import ParseUI
import ParseFacebookUtilsV4
import MapKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    // Override point for customization after application launch.
    // Set up the Parse SDK
    let configuration = ParseClientConfiguration {
        $0.applicationId = "round"
        $0.server = "https://round-parse-randy.herokuapp.com/parse"
    }
    Parse.initializeWithConfiguration(configuration)
    
   

    
    
    
    
    
//    // automatic login to "hello"
//    do {
//        try PFUser.logInWithUsername("hello", password: "hello")
//    } catch {
//        print("Unable to log in")
//    }
//    
//    if let currentUser = PFUser.currentUser() {
//        print("\(currentUser.username!) logged in successfully")
//    } else {
//        print("No logged in user :(")
//    }
//
//    
  //   PFUser.logOut()
    
    // check if we have logged in user
    let startViewController: UIViewController

    if PFUser.currentUser() != nil {
    
        // if we have a user, set the TabBarController to be the initial view controller
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        startViewController = storyboard.instantiateViewControllerWithIdentifier("TabBarController") as! UITabBarController
        print("User has already logged in")
    } else {
        // Otherwise set the LoginViewController to be the first
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        startViewController = storyboard.instantiateViewControllerWithIdentifier("LogInViewController") 
        print("No logged in user")
    }
    
     
    self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
    self.window?.rootViewController = startViewController;
    self.window?.makeKeyAndVisible()
    
    return true
  }
    
        
    
    

  func applicationWillResignActive(application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }

    func applicationDidBecomeActive(application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }

  func applicationWillTerminate(application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }


}

