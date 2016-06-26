//
//  LogInViewController.swift
//  Makestagram
//
//  Created by Randy Perecman on 6/23/16.
//  Copyright © 2016 Make School. All rights reserved.
//
import UIKit
import Parse
//import FBSDKCoreKit
import ParseUI
//import ParseFacebookUtilsV4

class LogInViewController: UIViewController {
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!
    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tap: UITapGestureRecognizer?
        tap = UITapGestureRecognizer(target: self, action: #selector(LogInViewController.dismissKeyboard))
        view.addGestureRecognizer(tap!)
        
        
        
        logInButton.layer.cornerRadius = 15
        logInButton.layer.backgroundColor = UIColor.whiteColor().CGColor
        logInButton.layer.borderWidth = 1.5
        logInButton.layer.borderColor = UIColor(colorLiteralRed: 135.0/255, green: 56.0/255, blue: 148.0/255, alpha: 1).CGColor
        logInButton.setTitleColor(UIColor(colorLiteralRed: 135.0/255, green: 56.0/255, blue: 148.0/255, alpha: 1), forState: UIControlState.Normal)
        
        
        
        
        
        
        
        signUpButton.layer.cornerRadius = 15
        signUpButton.layer.backgroundColor = UIColor.whiteColor().CGColor
        signUpButton.layer.borderWidth = 1.5
        signUpButton.layer.borderColor = UIColor(colorLiteralRed: 236.0/255, green: 53.0/255, blue: 127.0/255, alpha: 1.0).CGColor
        signUpButton.setTitleColor(UIColor(colorLiteralRed: 236.0/255, green: 53.0/255, blue: 127.0/255, alpha: 1.0), forState: UIControlState.Normal)
        
        
        
    }
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func logInPressed(sender: UIButton) {
        print("log in button pressed")
        
        logInButton.layer.backgroundColor = UIColor.whiteColor().CGColor
        
        logInButton.setTitleColor(UIColor(colorLiteralRed: 135.0/255, green: 56.0/255, blue: 148.0/255, alpha: 1), forState: UIControlState.Normal)
        
        
        
        PFUser.logInWithUsernameInBackground(usernameField.text!, password:passwordField.text!) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                print("hi there")
                let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("TabBarController")
                self.showViewController(vc as! UITabBarController, sender: vc)
                
            } else {
                // The login failed. Check error to see why.
                if self.usernameField.text == "" && self.passwordField.text != "" {
                    let alert = UIAlertController(title: "Wait Up...", message: "You know you need your username to get in right?", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                else if self.usernameField.text != "" && self.passwordField.text == "" {
                    let alert = UIAlertController(title: "Hey!", message: "I need your password before you can enter.", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                if self.usernameField.text == "" && self.passwordField.text == "" {
                    let alert = UIAlertController(title: "Sorry Bud", message: "I can't let you in without a username and password", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                else {
                    let alert = UIAlertController(title: "hmm", message: "Your [user]name [& password] isn't on the list. Try different ones. ", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                
                
                
            }
        }
    }
    
    
    @IBAction func unwindToLogInViewController(segue: UIStoryboardSegue) {
        
        // for now, simply defining the method is sufficient.
        // we'll add code later
        
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

// Put this piece of code anywhere you like

