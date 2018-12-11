//
//  InitialViewController.swift
//  RestaurantRoyale
//
//  Created by Netreconlab on 11/4/18.
//  Copyright © 2018 University of Kentucky. All rights reserved.
//

import UIKit
import Firebase

class InitialViewController: UIViewController {
  
  @IBOutlet weak var loginButton: UIButton!
  @IBOutlet weak var signupButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    loginButton.layer.cornerRadius = loginButton.frame.size.height / 2
    loginButton.layer.frame.size = CGSize(width: 50, height: 25)
    loginButton.layer.masksToBounds = true
    
    loginButton.layer.borderWidth = 1
    loginButton.layer.borderColor = Colors.Timberwolf.cgColor
    
    signupButton.layer.cornerRadius = signupButton.frame.size.height / 2
    signupButton.layer.masksToBounds = true
    
    signupButton.layer.borderWidth = 1
    signupButton.layer.borderColor = Colors.Timberwolf.cgColor
    
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    loginButton.setGradientBackground(colorOne: Colors.DarkTangerine, colorTwo: Colors.SunsetOrange)
    signupButton.setGradientBackground(colorOne: Colors.DarkTangerine, colorTwo: Colors.SunsetOrange)
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    if let user = Auth.auth().currentUser {
      self.performSegue(withIdentifier: "toDashboard", sender: self)
    }
    
  }
  
}
