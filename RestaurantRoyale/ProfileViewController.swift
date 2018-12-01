//
//  ProfileViewController.swift
//  Restaurant Royale
//
//  Created by Carrier, Kenton on 11/14/18.
//  Copyright © 2018 Ken Toh. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

  @IBOutlet weak var profilePic: UIImageView!
  @IBOutlet weak var usernameDisplay: UILabel!
  
  override func viewDidLoad() {
        super.viewDidLoad()

    let user = Auth.auth().currentUser
    
    usernameDisplay.text = user?.displayName
    profilePic.load(url: (user?.photoURL)!)
      
  }
  
  @IBAction func handleLogout(_ sender: Any) {
    try! Auth.auth().signOut()
    self.dismiss(animated: false, completion: nil)
  }

}
