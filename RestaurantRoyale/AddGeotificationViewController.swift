import UIKit
import MapKit
import Firebase

var reward = Bool(true)

class AddGeotificationViewController: UIViewController{
  
  var manager = RestaurantManager()
  var randomRestaurant = Restaurant()
  
  @IBOutlet weak var dessertButton: UIButton!
  @IBOutlet weak var FastFoodButton: UIButton!
  @IBOutlet weak var slots: UIImageView!
  @IBOutlet weak var background: UIImageView!
  @IBOutlet weak var randomRestaurantButton: UIButton!
  
  @IBAction func dessertRestaurantRequest(_ sender: UIButton) {
    
    randomRestaurant = manager.GetRestaurantByCategory(category: "Desserts", completion: {
      self.performSegue(withIdentifier: "showReward", sender: self)
    })
    
  }
  
  @IBAction func fastFoodRestaurantRequest(_ sender: UIButton) {
    
    randomRestaurant = manager.GetRestaurantByCategory(category: "Fast Food", completion: {
      self.performSegue(withIdentifier: "showReward", sender: self)
    })
    
  }
  
  @IBAction func randomRestaurantRequest(_ sender: UIButton) {
    
    randomRestaurant = manager.GetRandomRestaurant(completion: {
      self.performSegue(withIdentifier: "showReward", sender: self)
    })
    
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let rewardController = segue.destination as! RewardsViewController
    rewardController.selectedRestaurant = randomRestaurant
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    randomRestaurantButton.layer.cornerRadius = randomRestaurantButton.frame.size.height / 2
    randomRestaurantButton.layer.masksToBounds = true
    randomRestaurantButton.layer.borderWidth = 1
    
    dessertButton.layer.cornerRadius = dessertButton.frame.size.height / 2
    dessertButton.layer.masksToBounds = true
    dessertButton.layer.borderWidth = 1
    
    FastFoodButton.layer.cornerRadius = FastFoodButton.frame.size.height / 2
    FastFoodButton.layer.masksToBounds = true
    FastFoodButton.layer.borderWidth = 1
    
    background.loadGif(name: "money")
    slots.loadGif(name: "slots")
    view.bringSubview(toFront: slots)
    view.bringSubview(toFront: randomRestaurantButton)
    
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    randomRestaurantButton.setGradientBackground(colorOne: Colors.DeepLemon, colorTwo: Colors.SunsetOrange)
    
    FastFoodButton.setGradientBackground(colorOne: Colors.Mantis, colorTwo: Colors.PastelGreen)
    
    dessertButton.setGradientBackground(colorOne: Colors.FrenchPink, colorTwo: Colors.Mauvelous)
    
  }
  
}
