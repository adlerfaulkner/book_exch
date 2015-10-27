//
//  signUp1ViewController.swift
//  BookExchangeApp
//
//  Created by Adler Faulkner on 3/19/15.
//  Copyright (c) 2015 Adler Faulkner. All rights reserved.
//

import UIKit

class signUp1ViewController: UIViewController, UITextFieldDelegate {
    var json: JSON = []

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var password1: UITextField!
    @IBOutlet weak var password2: UITextField!
    @IBOutlet weak var profPic: UIImageView!
    @IBOutlet weak var doneButton: UIButton!
    
    var Name: String!
    var Email:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        email.text = Email
        name.text = Name
        profPic.layer.cornerRadius = 41
        profPic.layer.borderColor = UIColor.whiteColor().CGColor
        profPic.layer.borderWidth = 4
        
        self.password2.delegate = self;
        
        navigationController!.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationController!.navigationBar.shadowImage = UIImage()
        navigationController!.navigationBar.backgroundColor = UIColor(red: 0.0, green: 0.3, blue: 0.5, alpha: 0.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    var firstname: String!
    var lastname: String!
    
    //user clicks to finish the sign up process
    
    func textFieldShouldReturn(UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        resignFirstResponder()
        return true;
    }
    @IBAction func startedConfirm(sender: AnyObject) {
        doneButton.hidden = false
    }
    
    @IBAction func donePressed(sender: AnyObject) {
        //if all the text fields are filled
        if (email.text != "" && name.text != "" && password1.text != "" && password2 != "") {
            // if the confirmation password is the same as the password
            if (password1.text == password2.text) {
                var namearray = name.text.componentsSeparatedByCharactersInSet(NSCharacterSet (charactersInString: " "))
                // if they dont have a distinct first name ans last name
                if (namearray.count < 2) {
                    let alertController = UIAlertController(title: "Full Name", message:
                        "Please enter a first and last name.", preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                    
                    self.presentViewController(alertController, animated: true, completion: nil)
                } // they have a first and last name
                else {
                    var firstname = namearray.removeAtIndex(0)
                    var joint = " "
                    var lastname = joint.join(namearray)
                    
                    var parameters = ["first_name": firstname, "last_name": lastname, "email": email.text + "@cornell.edu", "password": password1.text, "password_confirmation": password2.text]
                    
                    DataManager.sharedInstance.call( "/user/create", parameters: parameters,
                        completion: { (error, result) -> Void in
                            
                            if error != nil {
                                println("error!")
                                println(error)
                            } else {
                                println(result)
                                self.json = result!
                                
                                if (self.json["message"] != nil) {
                                    println("user creation failed")
                                    var message = self.json["message"].string!
                                    let alertController = UIAlertController(title: "User creation failed", message:
                                        message, preferredStyle: UIAlertControllerStyle.Alert)
                                    alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                                    
                                    self.presentViewController(alertController, animated: true, completion: nil)
                                }
                                else if (self.json["api_key"] != nil) {
                                    println("loggedin")
                                    makeSession(self.json["apikey"].stringValue)
                                    self.performSegueWithIdentifier("signedUp", sender: self)
                                }
                                else {
                                    let alertController = UIAlertController(title: "Login Failed", message:
                                        "Please try again.", preferredStyle: UIAlertControllerStyle.Alert)
                                    alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                                    
                                    self.presentViewController(alertController, animated: true, completion: nil)
                                }
                            }
                    })
                    
                }
            } // passwords arent the same
                
            else {
                let alertController = UIAlertController(title: "Confirm Password", message:
                    "Please make sure to confirm your password correctly.", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                
                self.presentViewController(alertController, animated: true, completion: nil)
            }
            
        } // they havnet filled out all the text fields
        else {
            let alertController = UIAlertController(title: "Login Failed", message:
                "Please fill out all of the required fields.", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
        }

    }
}
