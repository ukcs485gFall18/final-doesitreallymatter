import UIKit
import CoreLocation
import UserNotifications
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  let locationManager = CLLocationManager()
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:[UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
    // Initializes the Firebase App using GoogleService-Info.plist - Kenton
    FirebaseApp.configure()
    locationManager.requestAlwaysAuthorization()
    return true
  }
  
}
