//
//  WinnerViewController.swift
//  Restaurant Royale
//
//  Created by Jordan Menchen on 12/9/18.
//  Copyright © 2018 Ken Toh. All rights reserved.
//

import UIKit

class WinnerViewController: UIViewController {
  
  // Two values used to store the random location for the user
  var restaurantID = String()
  var restaurantName = String()
  var restaurantType = String()
  var randomRestaurant: (name: String, id: String, type: String)?
  var randomRestaurantView = Restaurant()
  
    @IBOutlet weak var restaurantLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var rewardLabel: UILabel!
    @IBOutlet weak var winnerButton: UIButton!
    @IBOutlet weak var tryAgainButton: UIButton!
  
    override func viewDidLoad() {
      super.viewDidLoad()
      getRandomRestaurant()
      winnerButton.layer.cornerRadius = 4
      tryAgainButton.layer.cornerRadius = 4
      //set name label here with randomly selected restaurant
      restaurantLabel.text = (restaurantName)
      //set type here
      typeLabel.text = (restaurantType)
      if (reward) {
        rewardLabel.text = (rewardArray.randomElement())
      } else {
        rewardLabel.text = ("Sorry, no reward this time!")
      }
    }
  func getRandomRestaurant() {
    
    randomRestaurant = restaurants.randomElement()
    restaurantName = randomRestaurant!.name
    restaurantID = randomRestaurant!.id
    restaurantType = randomRestaurant!.type
    
  }
  
  // List of restaurants in Alphabetical order
  var restaurants: [(name: String, id: String, type: String)] = [
    ("Canes", "6YI7ekMfD3xs6u04PVmC", "American"),
    ("Chipotle", "bmnzNLBxZ9jshG7BpkEI", "Mexican"),
    ("Local Taco", "dUGaUGDC8xeSLpGICNpU", "Mexican"),
    ("McDonalds", "lj2aSybH94VKs1vrpGOy", "American"),
    ("Pazzo's Pizza Pub", "nzkjAfMY4rvKayCuvsr7", "Italian"),
    ("Tolly Ho", "rPyOHTck8RK2BPNIdrbF", "American")
  ]
  
  let rewardArray = [
  "A free drink!",
  "A free side!",
  "10% Off Your Entire Meal!"
  ]
  
  @IBAction func winnerButtonPressed(_ sender: Any) {
    
    let alert = UIAlertController(title: "Open in Maps?", message: nil, preferredStyle: .alert)
    let action1 = UIAlertAction(title: "Yes", style: .default) { (action) in
      print("Yes Selected")
      reward = false
      self.randomRestaurantView.loadRestaurant(restaurantID: self.restaurantID, completion: {
        self.randomRestaurantView.openMapToRestaurant()
      })
      self.performSegue(withIdentifier: "showReward", sender: self)
    }
    let action2 = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
      print("Cancel selected")
    }
    alert.addAction(action1)
    alert.addAction(action2)
    present(alert, animated: true, completion: nil)
    
  }
  
  @IBAction func tryAgainPressed(_ sender: Any) {
    let noReward = "Sorry, no reward this time!"
    let isEqual = (rewardLabel.text == noReward)
    if (!isEqual) {
      let alert = UIAlertController(title: "Are you sure?", message: "Your reward will be lost!", preferredStyle: .alert)
      let action1 = UIAlertAction(title: "Yes", style: .destructive) { (action) in
        print("Yes Selected")
        reward = false
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
        reward = false
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
  
  func prepareForSegue(segue: UIStoryboardSegue, sender: UIAlertController) {
    if(segue.identifier == "backToRandom"){
      if let tabVC = segue.destination as? TabViewController{
        tabVC.selectedIndex = 2
        print("back to random")
      }
    }
  }
}
