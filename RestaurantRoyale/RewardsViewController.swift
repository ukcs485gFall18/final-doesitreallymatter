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
  
  @IBOutlet weak var tryAgainButton: UIButton!
  @IBOutlet weak var winnerButton: UIButton!
  
  var selectedRestaurant = Restaurant()

  var manager = RestaurantManager()
  var restaurantArray = [Restaurant]()
  
    override func viewDidLoad() {
      super.viewDidLoad()
      winnerButton.layer.cornerRadius = 4
      tryAgainButton.layer.cornerRadius = 4
      
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

  @IBAction func winnerButtonPressed(_ sender: Any) {
    let alert = UIAlertController(title: "Open in Maps?", message: nil, preferredStyle: .alert)
    let action1 = UIAlertAction(title: "Yes", style: .default) { (action) in
      print("Yes Selected")
      self.selectedRestaurant.openMapToRestaurant()
    }
    let action2 = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
      print("Cancel selected")
    }
    alert.addAction(action1)
    alert.addAction(action2)
    present(alert, animated: true, completion: nil)
  }
  
  @IBAction func tryAgainButtonPressed(_ sender: Any) {
    let noReward = "Sorry, no reward this time!"
    let isEqual = (rewardLabel.text == noReward)
    if (!isEqual) {
      let alert = UIAlertController(title: "Are you sure?", message: "Your reward will be lost!", preferredStyle: .alert)
      let action1 = UIAlertAction(title: "Yes", style: .destructive) { (action) in
        print("Yes Selected")
        self.performSegue(withIdentifier: "backToRandom", sender: self)
      }
      let action2 = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        print("Cancel selected")
      }
      alert.addAction(action1)
      alert.addAction(action2)
      present(alert, animated: true, completion: nil)
    } else {
      let alert = UIAlertController(title: "Are you sure?", message: nil, preferredStyle: .alert)
      let action1 = UIAlertAction(title: "Yes", style: .destructive) { (action) in
        print("Yes Selected")
        self.performSegue(withIdentifier: "backToRandom", sender: self)
      }
      let action2 = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        print("Cancel selected")
      }
      alert.addAction(action1)
      alert.addAction(action2)
      present(alert, animated: true, completion: nil)
    }
  }
}
