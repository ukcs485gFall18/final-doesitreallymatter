//
//  LoginViewController.swift
//  RestaurantRoyale
//
//  Created by Netreconlab on 11/4/18.
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
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}
