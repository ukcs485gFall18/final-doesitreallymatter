//
//  LoginViewController.swift
//  RestaurantRoyale
//
//  Created by Carrier, Kenton on 11/4/18.
//  Copyright © 2018 University of Kentucky. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
  
  @IBOutlet weak var emailField: UITextField!
  @IBOutlet weak var passwordField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
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
  
  @IBAction func handleLogin(_ sender: Any) {
    
    guard let email = emailField.text else { return }
    guard let password = passwordField.text else { return }
  
    Auth.auth().signIn(withEmail: email, password: password) { user, error in
      
      if error == nil && user != nil {
          self.dismiss(animated: false, completion: nil)
      } else {
          print("Error logging in: \(error!.localizedDescription)")
      }
    }

  }
  
}
