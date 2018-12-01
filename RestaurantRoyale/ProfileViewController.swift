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

    @IBOutlet weak var favFoodDisplay: UILabel!
    @IBOutlet weak var usernameDisplay: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var nameDisplay: UILabel!
  
  override func viewDidLoad() {
        super.viewDidLoad()

    let user = Auth.auth().currentUser
    let userDocRef = db.collection("userData").document((user?.uid)!)
    
    userDocRef.getDocument() { (document, error) in
      if let document = document {
        self.favFoodDisplay.text = document.get("favFood") as? String
        self.nameDisplay.text = document.get("fullName") as? String
      } else {
        print("Document does not exist")
      }
    }
    
    usernameDisplay.text = user?.displayName
    profilePic.load(url: (user?.photoURL)!)
      
  }
  
  @IBAction func handleLogout(_ sender: Any) {
    try! Auth.auth().signOut()
    self.dismiss(animated: false, completion: nil)
  }

}
