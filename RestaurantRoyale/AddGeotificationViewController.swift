import UIKit
import MapKit
import Firebase
import FirebaseFirestore

let db = Firestore.firestore()
let settings = db.settings

// Two values used to store the random location for the user
var restaurantID = String()
var restaurantName = String()


protocol AddGeotificationsViewControllerDelegate {
  func addGeotificationViewController(_ controller: AddGeotificationViewController, didAddCoordinate coordinate: CLLocationCoordinate2D, radius: Double, identifier: String, note: String, eventType: Geotification.EventType)
}

class AddGeotificationViewController: UIViewController{
  
  @IBOutlet weak var slots: UIImageView!
  @IBOutlet weak var background: UIImageView!
  @IBOutlet weak var randomRestaurant: UIButton!
  @IBAction func randomRestaurant(_ sender: UIButton) {
    //Perform all actions when a button is tapped
    //Want to generate a random number, link it to the index of a restaurant in the restaurants array
    //Use that restaurant to generate the next pin drop
    //Possibly bring out a text box stating which restaurant was chosen, then asking if user wants to go there
    //    or select again
   
    let randomIndex = Int.random(in: 0..<restaurants.count)
    restaurantID = restaurants[randomIndex].id
    
    let randomRestaurant = Restaurant(restaurantID: restaurantID)
    
    randomRestaurant.openMapToRestaurant()
    
  }
  
  var delegate: AddGeotificationsViewControllerDelegate?
  
  
  // List of restaurants in Alphabetical order
  var restaurants: [(name: String, id: String)] = [
    ("Canes", "6YI7ekMfD3xs6u04PVmC"),
    ("Chipotle", "bmnzNLBxZ9jshG7BpkEI"),
    ("Local Taco", "dUGaUGDC8xeSLpGICNpU"),
    ("McDonalds", "lj2aSybH94VKs1vrpGOy"),
    ("Pazzo's Pizza Pub", "nzkjAfMY4rvKayCuvsr7"),
    ("Tolly Ho", "rPyOHTck8RK2BPNIdrbF")
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    randomRestaurant.setTitle("Let's Eat!", for: .normal)
    randomRestaurant.layer.cornerRadius = 4
    restaurantID = restaurants[0].id // Sets the default value of the picker to be the first value in the array
    restaurantName = restaurants[0].name // Same ^^^
    
    background.loadGif(name: "money")
    slots.loadGif(name: "slots")
    view.bringSubview(toFront: slots)
    view.bringSubview(toFront: randomRestaurant)
  }
  
  @IBAction func onCancel(sender: AnyObject) {
    dismiss(animated: true, completion: nil)
  }
  
}
