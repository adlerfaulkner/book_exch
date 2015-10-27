//
//  ViewController.swift
//  BookExchangeApp
//
//  Created by Adler Faulkner on 2/24/15.
//  Copyright (c) 2015 Adler Faulkner. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    var json: JSON = []
    
    @IBOutlet weak var login: UIButton!
    
    @IBOutlet weak var signup: UIButton!
    
    @IBOutlet weak var signUpView: UIView!
    
    @IBOutlet weak var signUpEmail: UITextField!
    
    @IBOutlet weak var signUpName: UITextField!
    
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var loginPassword: UITextField!
    @IBOutlet weak var loginEmail: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var nextSignUpButton: UIView!
   
    @IBOutlet weak var black: UIView!
    
    @IBOutlet weak var picture: UIImageView!
    
    @IBOutlet weak var triangle: UIImageView!
    
    //var context: CIContext!
    
    //var filter: CIFilter!
    
    //var finalImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationController!.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationController!.navigationBar.shadowImage = UIImage()
        navigationController!.navigationBar.backgroundColor = UIColor(red: 0.0, green: 0.3, blue: 0.5, alpha: 0.0)
        showSignUp(self)
        if (getSession() != nil) {
             self.performSegueWithIdentifier("loggedIn", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue,
         sender: AnyObject!){
            //make sure that the segue is going to secondViewController
            if segue.identifier == "toSignUp2" {
                var svg = segue.destinationViewController as signUp1ViewController
                svg.Name = signUpName.text
                svg.Email = signUpEmail.text
            }
    }
    
    func applyfilter () {
        let img = CIImage(image: picture.image)
        let filter = CIFilter(name: "CIGaussianBlur")
        filter.setValue(img, forKey: "inputImage")
        filter.setValue(12, forKey: "inputRadius")
        
        let newImage = UIImage(CIImage: filter.outputImage)
        
        picture.image = newImage
    }
    
    

    @IBAction func showSignUp(sender: AnyObject) {
        signUpView.hidden = false
        loginView.hidden = true
        signup.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        login.titleLabel?.textColor = UIColor.grayColor()
        loginButton.hidden = true
        if (signUpEmail.text != "" && signUpName.text != ""){
            nextSignUpButton.hidden = false
        }
        
        triangle.contentMode = UIViewContentMode.TopLeft
        
    }
    @IBAction func showLogin(sender: AnyObject) {
        signUpView.hidden = true
        loginView.hidden = false
        signup.titleLabel?.textColor = UIColor.grayColor()
        login.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        nextSignUpButton.hidden = true
        if (loginEmail.text != "" && loginPassword.text != ""){
            loginButton.hidden = false
        }
        triangle.contentMode = UIViewContentMode.TopRight    }
    
    @IBAction func startedPassword(sender: AnyObject) {
        if (loginEmail.text != nil) {
        loginButton.hidden = false
        }
    }
    
    
    
    @IBAction func startedName(sender: AnyObject) {
        if (signUpEmail.text != nil) {
            nextSignUpButton.hidden = false
        }
    }
    
    @IBAction func nextClicked(sender: AnyObject) {
        if (signUpEmail.text == "" || signUpName.text == "") {
            let alertController = UIAlertController(title: "Not all fields filled", message:
                "Please enter a valid email and full name.", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        else {
            self.performSegueWithIdentifier("toSignUp2", sender: self)
        }
    }
    
    @IBAction func loginClicked(sender: AnyObject) {
        if (loginEmail.text == "" || loginPassword.text == "") {
            let alertController = UIAlertController(title: "Login failed", message:
                "Please enter a valid email and password.", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
        else {
            var parameters = ["email": loginEmail.text + "@cornell.edu", "password": loginPassword.text]
            
            DataManager.sharedInstance.call( "/user/login", parameters: parameters,
                completion: { (error, result) -> Void in
                
                    if error != nil {
                        println("error!")
                        println(error)
                    } else {
                        println(result)
                        self.json = result!
                        
                        
                        if (self.json["api_key"] != nil) {
                            println("logged In")
                            makeSession(self.json["api_key"].string!)
                            self.performSegueWithIdentifier("loggedIn", sender: self)
                        }
                        else if (self.json["message"] != nil) {
                            println("login failed")
                            var message = self.json["message"].string!
                            let alertController = UIAlertController(title: "Login Failed", message: message, preferredStyle: UIAlertControllerStyle.Alert)
                            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                                
                            self.presentViewController(alertController, animated: true, completion: nil)
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
    }
}

