//
//  SignUpViewController.swift
//  Resepi
//
//  Created by Harpreet Singh on 11/8/16.
//  Copyright © 2016 Harpreet Singh. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet var firstNameField: UITextField!
    @IBOutlet var lastNameField: UITextField!
    @IBOutlet var usernameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var verifyPasswordField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameField.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func onCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onScreenTapGesture(_ sender: UITapGestureRecognizer) {
        firstNameField.resignFirstResponder()
        lastNameField.resignFirstResponder()
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
        verifyPasswordField.resignFirstResponder()
    }
    
    @IBAction func onScreenSwipeGesture(_ sender: UISwipeGestureRecognizer) {
        firstNameField.resignFirstResponder()
        lastNameField.resignFirstResponder()
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
        verifyPasswordField.resignFirstResponder()
    }
    
    @IBAction func onSignUpButton(_ sender: Any) {
        let firstName = firstNameField.text!
        let lastName = lastNameField.text!
        let username = usernameField.text!
        let password = passwordField.text!
        let verifyPassword = verifyPasswordField.text!
        
        if (!firstName.isEmpty && !lastName.isEmpty && !username.isEmpty && !password.isEmpty && !verifyPassword.isEmpty && password == verifyPassword) {
            UserClient.signUp(firstName: firstName, lastName: lastName, username: username, password: password)
            print("sign up passed successfully")
            let alert = UIAlertController(title: "Signed Up", message: "Thanks for signing up with us. Enjoy!", preferredStyle:UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Got it!", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction) in
                self.dismiss(animated: true, completion: nil)
            }))
                
            self.present(alert, animated: true, completion: nil)
            
            
        }
        else
        {
            var message = "Error Signing Up!"
            if (password != verifyPassword) {
                message = "Passwords don't match!"
            }
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
