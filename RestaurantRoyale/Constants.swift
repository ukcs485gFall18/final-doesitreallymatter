//
//  Constants.swift
//  Restaurant Royale
//
//  Created by Netreconlab on 12/11/18.
//  Copyright © 2018 Ken Toh. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorage

let db = Firestore.firestore()
let settings = db.settings

let storage = Storage.storage()

struct Colors {
  static let DarkTangerine = UIColor(red: 255/255, green: 172/255, blue: 20/255, alpha: 1)
  static let SunsetOrange = UIColor(red: 255/255, green: 94/255, blue: 91/255, alpha: 1)
  static let Timberwolf = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1)
  static let DeepLemon = UIColor(red: 252/255, green: 204/255, blue: 30/255, alpha: 1)
  static let Red = UIColor(red: 252/255, green: 49/255, blue: 22/255, alpha: 1)
  static let Isabelline = UIColor(red: 247/255, green: 243/255, blue: 237/255, alpha: 1)
  static let RifleGray = UIColor(red: 68/255, green: 67/255, blue: 65/255, alpha: 1)
}
