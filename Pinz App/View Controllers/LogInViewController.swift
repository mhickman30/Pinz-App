//
//  LogInViewController.swift
//  Pinz App
//
//  Created by Matt Hickman on 6/17/18.
//  Copyright © 2018 Matt Hickman. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class LogInViewController: UIViewController {

    @IBOutlet weak var signInSelector: UISegmentedControl!
    @IBOutlet weak var signInLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    var isSignIn: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func signInSelectorChanged(_ sender: UISegmentedControl) {
        isSignIn = !isSignIn
        
        if isSignIn {
            signInLabel.text = "Sign In"
            signInButton.setTitle("Sign In", for: .normal)
        } else {
            signInLabel.text = "Register"
            signInButton.setTitle("Register", for: .normal)
        }
    }
    
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            if isSignIn {
                // Sign in user with Firebase
                Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                    // Check to see if an error was returned or the user wasn't created
                    if error == nil && user != nil {
                        self.errorLabel.isHidden = true
                        self.performSegue(withIdentifier: "goToHome", sender: self)
                    } else {
                        self.errorLabel.isHidden = false
                        self.errorLabel.text = error!.localizedDescription
                        print("Error signing in user: \(error!.localizedDescription)")
                    }
                }
            } else {
                // Register user with Firebase
                Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                    if error == nil && user != nil {
                        // Set account info in database upon creation of user
                        guard let uid = Auth.auth().currentUser?.uid else {return}
                        let storageRef = Database.database().reference().child("users/\(uid)")
                        storageRef.setValue(["email" : email, "password" : password, "pinz" : ["pin1" : "test"]])
                        
                        
                        self.errorLabel.isHidden = true
                        self.performSegue(withIdentifier: "goToHome", sender: self)
                    } else {
                        self.errorLabel.isHidden = false
                        self.errorLabel.text = error!.localizedDescription
                        print("Error creating user: \(error!.localizedDescription)")
                    }
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Dismiss the keyboard when the view is tapped on
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
}

