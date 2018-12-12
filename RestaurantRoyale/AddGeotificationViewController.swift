import UIKit
import MapKit
import Firebase

class AddGeotificationViewController: UIViewController{
  
  var manager = RestaurantManager()
  var randomRestaurant = Restaurant()
  
  @IBOutlet weak var slots: UIImageView!
  @IBOutlet weak var background: UIImageView!
  @IBOutlet weak var randomRestaurantButton: UIButton!
  
  @IBAction func mexicanRestaurantRequest(_ sender: UIButton) {
    
    randomRestaurant = manager.GetRestaurantByCategory(category: "Mexican", completion: {
      self.randomRestaurant.openMapToRestaurant()
    })
    
  }
  
  @IBAction func randomRestaurantRequest(_ sender: UIButton) {
    
    randomRestaurant = manager.GetRandomRestaurant(completion: {
      self.randomRestaurant.openMapToRestaurant()
    })
    
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
