import UIKit
import Flutter
import GoogleMaps
import Foundation



@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    // if let apiKey = ProcessInfo.processInfo.environment["API"] {
    //   print(apiKey)
    // } else {
    //   print("ERROR")
    // }
    // let apiKey = ProcessInfo.processInfo.environment["API"]!
    // print(ProcessInfo.processInfo.environment["API"])

    GMSServices.provideAPIKey("AIzaSyD6DNRH2SIEJwqG8aoq2XIu8nI9_c-6j54")

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
