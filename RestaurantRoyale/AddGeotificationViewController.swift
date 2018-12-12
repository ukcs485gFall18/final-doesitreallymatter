import UIKit
import MapKit
import Firebase

var reward = Bool(true)

class AddGeotificationViewController: UIViewController{
  
  var randomRestaurant = Restaurant()
  
  @IBOutlet weak var slots: UIImageView!
  @IBOutlet weak var background: UIImageView!
  @IBOutlet weak var randomRestaurantButton: UIButton!
  

  @IBAction func randomRestaurantButtonPressed(_ sender: Any) {
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    randomRestaurantButton.layer.cornerRadius = randomRestaurantButton.frame.size.height / 2
    
    background.loadGif(name: "money")
    slots.loadGif(name: "slots")
    view.bringSubview(toFront: slots)
    view.bringSubview(toFront: randomRestaurantButton)
    
  }
  
}
