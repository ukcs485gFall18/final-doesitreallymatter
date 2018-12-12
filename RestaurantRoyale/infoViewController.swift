//
//  infoViewController.swift
//  Restaurant Royale
//
//  Created by Joseph Crocker on 12/11/18.
//  Copyright © 2018 Ken Toh. All rights reserved.
//

import UIKit

class infoViewController: UIViewController {
  @IBOutlet weak var restaurantNameLabel: UITextField!
  
  var recievedData: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      loadData()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
  func loadData(){
    restaurantNameLabel.text = recievedData
  }

}
