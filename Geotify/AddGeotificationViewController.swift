/// Copyright (c) 2018 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

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
    
    print("Inside Random Restauraunt")
    print(restaurants.count)
    let randomIndex = Int.random(in: 0..<restaurants.count)
    print(randomIndex)
    restaurantID = restaurants[randomIndex].id
    restaurantName = restaurants[randomIndex].name
    
    //TODO: Add an popup window that asks if the user would like to go to selected restaurant
    //TODO: If yes, add the restaurant. If no, do nothing and take back to the add screen
    
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
