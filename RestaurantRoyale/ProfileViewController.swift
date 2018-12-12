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
  @IBOutlet weak var logoutButton: UIButton!
  
  override func viewDidLoad() {
        super.viewDidLoad()
    
    logoutButton.layer.cornerRadius = logoutButton.frame.size.height / 2
    logoutButton.layer.masksToBounds = true
    logoutButton.layer.borderWidth = 1
    logoutButton.layer.borderColor = Colors.Timberwolf.cgColor
    
    let settings = db.settings
    settings.areTimestampsInSnapshotsEnabled = true
    db.settings = settings

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
    if (user!.photoURL == nil) {
      profilePic.load(url: NSURL(string: "https://upload.wikimedia.org/wikipedia/commons/9/93/Default_profile_picture_%28male%29_on_Facebook.jpg")! as URL)
    }
    else {
      profilePic.load(url: (user?.photoURL)!)
    }
      
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.setNeedsStatusBarAppearanceUpdate()
  }
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  @IBAction func handleLogout(_ sender: Any) {
    try! Auth.auth().signOut()
    self.dismiss(animated: false, completion: nil)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    logoutButton.setGradientBackground(colorOne: Colors.DarkTangerine, colorTwo: Colors.SunsetOrange)
    self.view.setGradientBackground(colorOne: Colors.MaastrichtBlue, colorTwo: Colors.RifleGray)
    
  }

}
