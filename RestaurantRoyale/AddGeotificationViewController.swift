import UIKit
import MapKit
import Firebase

var reward = Bool(true)

class AddGeotificationViewController: UIViewController{
  
  var randomRestaurant = Restaurant()
  
  @IBOutlet weak var slots: UIImageView!
  @IBOutlet weak var background: UIImageView!
  @IBOutlet weak var randomRestaurantButton: UIButton!
  
  @IBAction func randomRestaurantRequest(_ sender: UIButton) {
    
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
    let randomID = String((0...19).map{ _ in letters.randomElement()! })
   
    db.collection("restaurants").whereField(FieldPath.documentID(), isGreaterThan: randomID).limit(to: 1).getDocuments() { (querySnapshot, err) in
      if let err = err {
        print("Error getting documents: \(err)")
      } else {
        print(querySnapshot?.count as Any)
        for document in querySnapshot!.documents {
          self.randomRestaurant.loadRestaurant(restaurantID: document.documentID, completion: {
            self.randomRestaurant.openMapToRestaurant()
          })
        }
      }
    }
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    randomRestaurantButton.setTitle("Let's Eat!", for: .normal)
    randomRestaurantButton.layer.cornerRadius = 4
    background.loadGif(name: "money")
    slots.loadGif(name: "slots")
    view.bringSubview(toFront: slots)
    view.bringSubview(toFront: randomRestaurantButton)
    
  }
  
}
