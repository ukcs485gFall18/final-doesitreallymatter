//
//  infoViewController.swift
//  Restaurant Royale
//
//  Created by Joseph Crocker on 12/12/18.
//  Copyright © 2018 Ken Toh. All rights reserved.
//
import UIKit
import MapKit

class infoViewController: UIViewController {
  @IBOutlet weak var restaurantNameLabel: UITextField!
  @IBOutlet weak var categoryLabel: UITextField!
  
  var restaurant = Restaurant()
  var category = ""
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    restaurantNameLabel.text = restaurant.name
    categoryLabel.text = category
  }
  
  @IBAction func mapButton(_ sender: Any) {
    restaurant.openMapToRestaurant()
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
