//
//  RewardsViewController.swift
//  Restaurant Royale
//
//  Created by Joseph Crocker on 11/29/18.
//  Copyright © 2018 Ken Toh. All rights reserved.
//

import UIKit

class RewardsViewController: UIViewController {
  
  @IBOutlet weak var restaurantLabel: UILabel!
  @IBOutlet weak var typeLabel: UILabel!
  @IBOutlet weak var rewardLabel: UILabel!
  
  var selectedRestaurant = Restaurant()

  var manager = RestaurantManager()
  var restaurantArray = [Restaurant]()
  
    override func viewDidLoad() {
      super.viewDidLoad()
      
      restaurantLabel.text = selectedRestaurant.name
      typeLabel.text = selectedRestaurant.categories[0]
      
      
      manager.GetEveryRestaurant(completion: { loaded in
        self.restaurantArray = loaded
        for restaurant in self.restaurantArray {
          print(restaurant.name)
        }
        // Do Array things here, like updating the tableview
      })
      
      
      
    }

}
