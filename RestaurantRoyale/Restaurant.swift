//
//  Restaurant.swift
//  Restaurant Royale
//
//  Created by Carrier, Kenton on 12/3/18.
//  Copyright © 2018 Ken Toh. All rights reserved.
//

import Foundation
import Firebase
import MapKit

class Restaurant {
  
  var name = String()
  var location = CLLocationCoordinate2D()
  var categories = Array<String>()
  
  func loadRestaurant(restaurantID: String, completion: @escaping () -> Void) {
    
    let docRef = db.collection("restaurants").document(restaurantID)
    docRef.getDocument(){ (document, error) in
      if let document = document {
        self.name = document.get("name") as! String
        // From https://stackoverflow.com/questions/52374315/swift-retrieving-geopoints-from-firestore-how-to-show-them-as-map-annotations/52375416
        if let coords = document.get("location") {
          let point = coords as! GeoPoint
          let lat = point.latitude
          let lon = point.longitude
          self.location = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        }
        self.categories = document.get("categories") as! [String]
      }
      completion()
    }
    
  }
  
  func openMapToRestaurant() {
    
    let mapBoundary: CLLocationDistance = 10000
    let region = MKCoordinateRegionMakeWithDistance(self.location, mapBoundary, mapBoundary)
    let options = [ MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: region.center),
                    MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: region.span)
    ]
    let placemark = MKPlacemark(coordinate: self.location)
    let mapItem = MKMapItem(placemark: placemark)
    
    mapItem.name = self.name
    print(self.name)
    mapItem.openInMaps(launchOptions: options)
  }
  
}
