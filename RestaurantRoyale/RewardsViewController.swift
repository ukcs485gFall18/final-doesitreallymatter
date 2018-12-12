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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    winnerButton.layer.cornerRadius = winnerButton.frame.size.height / 2
    winnerButton.layer.masksToBounds = true
    winnerButton.layer.borderWidth = 1
    tryAgainButton.layer.cornerRadius = tryAgainButton.frame.size.height / 2
    tryAgainButton.layer.masksToBounds = true
    tryAgainButton.layer.borderWidth = 1
    
    restaurantLabel.text = selectedRestaurant.name
    typeLabel.text = selectedRestaurant.categories[0]
    if (reward) {
      rewardLabel.text = (rewardArray.randomElement())
    } else {
      rewardLabel.text = ("Sorry, no reward this time!")
    }
  }
  
  let rewardArray = [
    "A free drink!",
    "A free side!",
    "10% Off Your Entire Meal!"
  ]
  
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
        reward = false
        self.performSegue(withIdentifier: "backToRandom", sender: self)
      }
      let action2 = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
      }
      alert.addAction(action1)
      alert.addAction(action2)
      present(alert, animated: true, completion: nil)
    } else {
      let alert = UIAlertController(title: "Are you sure?", message: nil, preferredStyle: .alert)
      let action1 = UIAlertAction(title: "Yes", style: .destructive) { (action) in
        reward = false
        self.performSegue(withIdentifier: "backToRandom", sender: self)
      }
      let action2 = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
      }
      alert.addAction(action1)
      alert.addAction(action2)
      present(alert, animated: true, completion: nil)
    }
  }
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    winnerButton.setGradientBackground(colorOne: Colors.Maize, colorTwo: Colors.DeepLemon)
    
    tryAgainButton.setGradientBackground(colorOne: Colors.Rosewood, colorTwo: Colors.Red)
    
    self.view.setGradientBackground(colorOne: Colors.MaastrichtBlue, colorTwo: Colors.RifleGray)
  }
}
