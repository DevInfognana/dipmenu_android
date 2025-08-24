import UIKit
import Flutter
//import flutter_local_notifications

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate{
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
//    FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
//    GeneratedPluginRegistrant.register(with: registry)
      
//  }
      if #available(iOS 10.0, *) {
          UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
      }
//       WebViewController.register(with: controller.registrar(forPlugin: "com.demo.webview_channel")!)

    GeneratedPluginRegistrant.register(with: self)
      let controller = window?.rootViewController as! FlutterViewController
    WebViewController.register(with: controller.registrar(forPlugin: "com.demo.webview_channel")!)
//    request.earliestBeginDate = Date(timeIntervalSinceNow: 60)

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
