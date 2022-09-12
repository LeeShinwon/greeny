import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    // TODO: Add your Google Maps API key
        GMSServices.provideAPIKey("AIzaSyBn86f1BiY0Zw-btTNjC_9zuDj4hJUfCRY")


    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
