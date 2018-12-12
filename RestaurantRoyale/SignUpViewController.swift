//
//  SignUpViewController.swift
//  RestaurantRoyale
//
//  Created by Netreconlab on 11/4/18.
//  Copyright © 2018 University of Kentucky. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
  
  
  @IBOutlet weak var usernameField: UITextField!
  @IBOutlet weak var emailField: UITextField!
  @IBOutlet weak var passwordField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
    @IBAction func backButtonPressed(_ sender: UIButton) {
    }
    
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    self.view.setGradientBackground(colorOne: Colors.MaastrichtBlue, colorTwo: Colors.RifleGray)
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.setNeedsStatusBarAppearanceUpdate()
  }
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  
  @IBAction func handleSignUp(_ sender: Any) {
    guard let username = usernameField.text else { return }
    guard let email = emailField.text else { return }
    guard let password = passwordField.text else { return }
    
    Auth.auth().createUser(withEmail: email, password: password) { user, error in
        if error == nil && user != nil {
            print("User created!")
          
            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
            changeRequest?.displayName = username
            changeRequest?.commitChanges { error in
                if error == nil {
                    print("User display name changed!")
                    self.dismiss(animated: false, completion: nil)
                }
            }
          
        } else {
            print("Error creating user: \(error!.localizedDescription)")
        }
    }
  }
    

}
