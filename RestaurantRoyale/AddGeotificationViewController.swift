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
      self.performSegue(withIdentifier: "showRewardsView", sender: self)
    })
    
  }
  
  @IBAction func randomRestaurantRequest(_ sender: UIButton) {
    
    randomRestaurant = manager.GetRandomRestaurant(completion: {
      self.performSegue(withIdentifier: "showRewardsView", sender: self)
    })
    
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let rewardController = segue.destination as! RewardsViewController
    rewardController.selectedRestaurant = randomRestaurant
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
