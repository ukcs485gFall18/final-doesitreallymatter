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

class AddGeotificationViewController: UITableViewController{
  
  @IBOutlet var addButton: UIBarButtonItem!
  @IBOutlet var zoomButton: UIBarButtonItem!
  @IBOutlet weak var eventTypeSegmentedControl: UISegmentedControl!
  @IBOutlet weak var radiusTextField: UITextField!
  //@IBOutlet weak var noteTextField: UITextField! Removed the text field to add a message to the geofence - Chelina
  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var Picker1: UIPickerView!
  @IBOutlet weak var randomRestaurant: UIButton!
  @IBAction func randomRestaurant(_ sender: UIButton) {
    //Perform all actions when a button is tapped
    //Want to generate a random number, link it to the index of a restaurant in the restaurants array
    //Use that restaurant to generate the next pin drop
    //Possibly bring out a text box stating which restaurant was chosen, then asking if user wants to go there
    //    or select again
   
    let randomIndex = Int.random(in: 0..<restaurants.count)
    print(randomIndex)
    restaurantID = restaurants[randomIndex].id
    restaurantName = restaurants[randomIndex].name
    
    // Moved all the code from the onAdd function to here to trigger the add action once the button is selected
    settings.areTimestampsInSnapshotsEnabled = true
    db.settings = settings
    
    var coordinate = CLLocationCoordinate2D()
    let radius = 20
    var pointSum: Int = 0 // Var that will change every time we create a new geofence (adds on point per new geofence) - Chelina
    let point = 5 // every new Geofence will be worth 5 points - Chelina
    pointSum += point // Add points earned to the total count in the identifier - Chelina
    
    
    let identifier = NSUUID().uuidString
    let points = [identifier : pointSum]
    let note = "You have arrived at " + restaurantName + ", you get \(points[identifier] ?? 0) points!" // add the point to the notification of entering the geofence to the user - Chelina
    let eventType: Geotification.EventType = (eventTypeSegmentedControl.selectedSegmentIndex == 0) ? .onEntry : .onExit
    
    let docRef = db.collection("restaurants").document(restaurantID)
    
    docRef.getDocument { (document, error) in
      if let document = document, document.exists {
        // let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
        // From https://stackoverflow.com/questions/52374315/swift-retrieving-geopoints-from-firestore-how-to-show-them-as-map-annotations/52375416
        if let coords = document.get("location") {
          let point = coords as! GeoPoint
          let lat = point.latitude
          let lon = point.longitude
          print(lat, lon) //here you can
          coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        }
        print("Coordinate: \(coordinate) Note: \(String(describing: note))")
        self.delegate?.addGeotificationViewController(self, didAddCoordinate: coordinate, radius: Double(radius), identifier: identifier, note: note, eventType: eventType)
      } else {
        print("Document does not exist")
      }
    }
    print(coordinate)
    
  }
  
  var delegate: AddGeotificationsViewControllerDelegate?
  
  // Function used to read in all the restaurant values
  // Later on, could vary this by only reading in restaurants within a certain distance of the user (Ex: 5mi radius)
  func getRestaurantData () {
    
  }
  
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
    navigationItem.rightBarButtonItems = [addButton, zoomButton]
    addButton.isEnabled = true
     randomRestaurant.setTitle("Let's Eat!", for: .normal)
    restaurantID = restaurants[0].id // Sets the default value of the picker to be the first value in the array
    restaurantName = restaurants[0].name // Same ^^^
    
  }
  
  @IBAction func onCancel(sender: AnyObject) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction private func onAdd(sender: AnyObject) {

    
  }
  
  @IBAction private func onZoomToCurrentLocation(sender: AnyObject) {
    mapView.zoomToUserLocation()
  }
}
