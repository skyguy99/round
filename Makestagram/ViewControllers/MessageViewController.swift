//
//  MessageViewController.swift
//  Makestagram
//
//  Created by Randy Perecman on 6/24/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {

    
    @IBOutlet weak var amIHomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if atHome == true {
            amIHomeLabel.textColor = UIColor.whiteColor()
            amIHomeLabel.backgroundColor = UIColor.greenColor()
            amIHomeLabel.text = "Welcome home"
        }
        else {
            amIHomeLabel.textColor = UIColor.blackColor()
            amIHomeLabel.text = "You are not home"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func amIHome() {
//        if DistanceFormula.dist <= 0.00135135135 {
//            amIHomeLabel.layer.backgroundColor = UIColor.blueColor().CGColor
//            amIHomeLabel.text = "Welcome Home!"
//        }
//        else {
//            amIHomeLabel.layer.backgroundColor = UIColor.redColor().CGColor
//        }
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
