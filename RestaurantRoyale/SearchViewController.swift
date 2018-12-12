//
//  SearchViewController.swift
//  Restaurant Royale
//
//  Created by Jordan Menchen on 12/12/18.
//  Copyright © 2018 Ken Toh. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
  
  var manager = RestaurantManager()
  var restaurantArray = [Restaurant]()

    override func viewDidLoad() {
        super.viewDidLoad()
      manager.GetEveryRestaurant(completion: { loaded in
        self.restaurantArray = loaded
        for restaurant in self.restaurantArray {
          print(restaurant.name)
        }
        // Do Array things here, like updating the tableview
      })

        // Do any additional setup after loading the view.
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
