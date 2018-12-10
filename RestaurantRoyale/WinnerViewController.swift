//
//  WinnerViewController.swift
//  Restaurant Royale
//
//  Created by Jordan Menchen on 12/9/18.
//  Copyright © 2018 Ken Toh. All rights reserved.
//

import UIKit

class WinnerViewController: UIViewController {
  
    @IBOutlet weak var restaurantLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var rewardLabel: UILabel!
    @IBOutlet weak var winnerButton: UIButton!
    @IBOutlet weak var tryAgainButton: UIButton!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        winnerButton.layer.cornerRadius = 4
        tryAgainButton.layer.cornerRadius = 4
      //set name label here with randomly selected restaurant
      //set type here
      if (reward) {
        rewardLabel.text = (rewardArray.randomElement())
      } else {
        rewardLabel.text = ("Sorry, no reward this time!")
      }
    }
  
  let rewardArray = [
  "A free drink!",
  "A free side!",
  "10% Off Entire Meal"
  ]
  
  @IBAction func winnerButtonPressed(_ sender: Any) {
    
    //open in maps function here
    
  }
  
  @IBAction func tryAgainPressed(_ sender: Any) {
    
    let alert = UIAlertController(title: "Are you sure?", message: "Your reward will be lost!", preferredStyle: .alert)
    let action1 = UIAlertAction(title: "Yes", style: .destructive) { (action) in
      print("Yes Selected")
      reward = false
      self.performSegue(withIdentifier: "mySegueIdentifier", sender: self)
    }
    let action2 = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
      print("Cancel selected")
    }
    alert.addAction(action1)
    alert.addAction(action2)
    present(alert, animated: true, completion: nil)
    
  }
}
