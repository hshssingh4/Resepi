//
//  ResepiClient.swift
//  Resepi
//
//  Created by Harpreet Singh on 11/8/16.
//  Copyright © 2016 Harpreet Singh. All rights reserved.
//

import UIKit
import Parse

class UserClient: NSObject {
    
    class func initializeParse()
    {
        Parse.initialize(
            with: ParseClientConfiguration(block: { (configuration:ParseMutableClientConfiguration) -> Void in
                configuration.applicationId = "alhfafhahfhlafhkallsasldjlaj"
                configuration.clientKey = "njaaflhalskhfhakshfasnklasnlkas"
                configuration.server = "http://resepi.herokuapp.com/parse"
            })
        )
    }
    
    class func signIn(username: String, password: String, vc: LoginViewController)
    {
        print("signing in...")
        PFUser.logInWithUsername(inBackground: username, password: password, block: { (user: PFUser?, error: Error?) in
            if (user != nil) {
                print("logged in successfully")
                NotificationCenter.default.post(name: Notification.Name(rawValue: "Log In User"), object: nil)
            }
            
            if (error != nil) {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle:UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    vc.present(alert, animated: true, completion: nil)
            }
        })
    }
    
    class func signUp(firstName: String, lastName: String, username: String, password: String)
    {
        let newUser = PFUser()
        
        newUser.username = username
        newUser.password = password
        newUser["firstName"] = firstName
        newUser["lastName"] = lastName
        
        newUser.signUpInBackground { (success, Error) in
            if (success) {
                print("new user created")
            }
            else {
                print(Error?.localizedDescription ?? "failed to sign up")
            }
        }
    }
    
    class func logout()
    {
        PFUser.logOut()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Log Out User"), object: nil)
    }
}
