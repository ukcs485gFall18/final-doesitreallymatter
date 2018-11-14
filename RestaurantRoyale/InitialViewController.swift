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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    if let user = Auth.auth().currentUser {
      self.performSegue(withIdentifier: "toDashboard", sender: self)
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
