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
    }
  @IBAction func winnerButtonPressed(_ sender: Any) {
  }
  
  @IBAction func tryAgainPressed(_ sender: Any) {
  }
}
