import UIKit
import Flutter

import flutter_local_notifications

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

  FlutterLocalNotificationsPlugin.setPluginRegistrantCallback{(registry) in
  GeneratedPluginRegistrant.register(with:registry)}

  GeneratedPluginRegistrant.register(with : self)

  if #available(iOS 10.0 , *){
  UNUserNotificationCenter.current().delegate = self as ? UNUserNotificationCenterDelegate
  }

    GMSServices.provideAPIKey("AIzaSyAMPA3WK_y4Q4QRUrsejPy4J_K4BnvArtE")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
