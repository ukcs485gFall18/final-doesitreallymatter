//
//  Restaurant.swift
//  Restaurant Royale
//
//  Created by Netreconlab on 12/3/18.
//  Copyright © 2018 Ken Toh. All rights reserved.
//

import Foundation
import Firebase
import MapKit

class Restaurant {
  
  var name = String()
  var location = CLLocationCoordinate2D()
  var categories = Array<String>()
  
  init(restaurantID: String) {
    
    let docRef = db.collection("restaurants").document(restaurantID)
    docRef.getDocument() { (document, error) in
      if let document = document {
        
        self.name = document.get("name") as! String
        // From https://stackoverflow.com/questions/52374315/swift-retrieving-geopoints-from-firestore-how-to-show-them-as-map-annotations/52375416
        if let coords = document.get("location") {
          let point = coords as! GeoPoint
          let lat = point.latitude
          let lon = point.longitude
          print(lat, lon) //here you can
          self.location = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        }
        self.categories = document.get("categories") as! [String]
        
      }
    }
  }
  
  
  
}
