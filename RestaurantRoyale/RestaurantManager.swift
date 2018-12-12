//
//  RestaurantManager.swift
//  Restaurant Royale
//
//  Created by Carrier, Kenton on 12/11/18.
//  Copyright © 2018 Ken Toh. All rights reserved.
//

import Foundation
import Firebase
import MapKit

class RestaurantManager {

  func GetEveryRestaurant() {
    
  }
  
  func GetRandomRestaurant(completion: @escaping () -> Void) -> Restaurant {
    
    var randomRestaurant = Restaurant()
    
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
    let randomID = String((0...19).map{ _ in letters.randomElement()! })
    
    db.collection("restaurants").whereField(FieldPath.documentID(), isGreaterThan: randomID).limit(to: 1).getDocuments() { (querySnapshot, err) in
      if let err = err {
        print("Error getting documents: \(err)")
      } else {
        if querySnapshot?.count == 0 {
          db.collection("restaurants").whereField(FieldPath.documentID(), isLessThan: randomID).limit(to: 1).getDocuments() { (querySnapshot, err) in
            if let err = err {
              print("Error getting documents: \(err)")
            } else {
              for document in querySnapshot!.documents {
                randomRestaurant.loadRestaurant(restaurantID: document.documentID, completion: {
                  completion()
                })
              }
            }
          }
        } else {
          
          for document in querySnapshot!.documents {
            randomRestaurant.loadRestaurant(restaurantID: document.documentID, completion: {
              completion()
            })
          }
          
        }
      }
    }
    return randomRestaurant
  }
  
}
