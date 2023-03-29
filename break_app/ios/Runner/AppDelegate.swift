import UIKit
import Flutter
import GoogleMaps
import Foundation
import os



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

    GMSServices.provideAPIKey("AIzaSyARJ20gb_jW3GOelj_jtsDjol3WL7ecPhM")

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
