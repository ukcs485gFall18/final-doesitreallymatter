//
//  SettingsViewController.swift
//  Restaurant Royale
//
//  Created by Netreconlab on 11/14/18.
//  Copyright © 2018 Ken Toh. All rights reserved.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  
  @IBAction func handleLogout(_ sender: Any) {
    try! Auth.auth().signOut()
    self.dismiss(animated: false, completion: nil)
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
