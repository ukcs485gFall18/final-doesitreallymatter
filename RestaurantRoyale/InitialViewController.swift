//
//  InitialViewController.swift
//  RestaurantRoyale
//
//  Created by Netreconlab on 11/4/18.
//  Copyright © 2018 University of Kentucky. All rights reserved.
//

import UIKit
import Firebase

class AuthButtons: UIButton {
  
  override func awakeFromNib() {
    
    layer.cornerRadius = 15
    backgroundColor = UIColor(red: 0.75, green: 0.20, blue: 0.19, alpha: 1.0)
    setTitleColor(UIColor.white, for: .normal)
    
    
  }
  
}

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
