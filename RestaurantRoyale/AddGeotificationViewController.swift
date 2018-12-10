import UIKit
import MapKit
import FirebaseFirestore

let db = Firestore.firestore()
let settings = db.settings

var reward = Bool(true)

class AddGeotificationViewController: UIViewController{
  
  @IBOutlet weak var slots: UIImageView!
  @IBOutlet weak var background: UIImageView!
  @IBOutlet weak var randomRestaurantButton: UIButton!
  @IBAction func randomRestaurantRequest(_ sender: UIButton) {
    //Perform all actions when a button is tapped
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    randomRestaurantButton.setTitle("Let's Eat!", for: .normal)
    randomRestaurantButton.layer.cornerRadius = 4
    background.loadGif(name: "money")
    slots.loadGif(name: "slots")
    view.bringSubview(toFront: slots)
    view.bringSubview(toFront: randomRestaurantButton)
    
    print(self)
    
  }
  
}
