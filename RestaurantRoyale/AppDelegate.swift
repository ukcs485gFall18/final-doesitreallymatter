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
    locationManager.delegate = self
    locationManager.requestAlwaysAuthorization()
    let options: UNAuthorizationOptions = [.badge, .sound, .alert]
    UNUserNotificationCenter.current()
      .requestAuthorization(options: options) { success, error in
        if let error = error {
          print("Error: \(error)")
        }
    }
    return true
  }
  
  func applicationDidBecomeActive(_ application: UIApplication) {
    application.applicationIconBadgeNumber = 0
    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    UNUserNotificationCenter.current().removeAllDeliveredNotifications()
  }
  
  func handleEvent(for region: CLRegion!) {
    print("Geofence triggered!")
    // Show an alert if application is active
    if UIApplication.shared.applicationState == .active {
      guard let message = note(from: region.identifier) else { return }
      window?.rootViewController?.showAlert(withTitle: nil, message: message)
    } else {
      // Otherwise present a local notification
      guard let body = note(from: region.identifier) else { return }
      let notificationContent = UNMutableNotificationContent()
      notificationContent.body = body
      notificationContent.sound = UNNotificationSound.default()
      notificationContent.badge = UIApplication.shared.applicationIconBadgeNumber + 1 as NSNumber
      let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
      let request = UNNotificationRequest(identifier: "location_change",
                                          content: notificationContent,
                                          trigger: trigger)
      UNUserNotificationCenter.current().add(request) { error in
        if let error = error {
          print("Error: \(error)")
        }
      }
    }
  }
  
  func note(from identifier: String) -> String? {
    let geotifications = Geotification.allGeotifications()
    guard let matched = geotifications.filter({
      $0.identifier == identifier
    }).first else { return nil }
    return matched.note
  }
  
}

extension AppDelegate: CLLocationManagerDelegate {
  
  func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
    if region is CLCircularRegion {
      handleEvent(for: region)
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
    if region is CLCircularRegion {
      handleEvent(for: region)
    }
  }
}

