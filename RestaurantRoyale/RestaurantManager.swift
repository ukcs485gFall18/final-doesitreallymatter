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

  func GetEveryRestaurant(completion: @escaping ([Restaurant]) -> Void){
    
    var restaurantsArray = [Restaurant]()
    
    db.collection("restaurants").getDocuments() { (querySnapshot, err) in
      if let err = err {
        print("Error getting documents: \(err)")
        completion(restaurantsArray)
      } else {
        var numAdded = 0
        for document in querySnapshot!.documents {
          let nextRestaurant = Restaurant()
          nextRestaurant.loadRestaurant(restaurantID: document.documentID, completion: {
            restaurantsArray.append(nextRestaurant)
            numAdded += 1
            if numAdded == querySnapshot?.count {
              completion(restaurantsArray)
            }
          })
        }
      }
    }
  }
  
  func GetRestaurantByCategory(category: String, completion: @escaping () -> Void) -> Restaurant {
    let randomRestaurant = Restaurant()
    
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
    let randomID = String((0...19).map{ _ in letters.randomElement()! })
    
    db.collection("restaurants").whereField("type", arrayContains: category).whereField(FieldPath.documentID(), isGreaterThan: randomID).limit(to: 1).getDocuments() { (querySnapshot, err) in
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
  
  func GetRandomRestaurant(completion: @escaping () -> Void) -> Restaurant {
    
    let randomRestaurant = Restaurant()
    
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
