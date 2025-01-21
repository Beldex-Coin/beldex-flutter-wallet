import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let myChannel = FlutterMethodChannel(
        name: "io.beldex.wallet/beldex_wallet_channel",
        binaryMessenger: controller.binaryMessenger)

    myChannel.setMethodCallHandler({
        (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in

       if(call.method == "email"){
          let args = call.arguments as? Dictionary<String, Any>
          let emailId = args?["email_id"] as! String
          if let url = URL(string: "mailto:\(emailId)") {
              UIApplication.shared.open(url, options: [:], completionHandler: nil)
          }
          let finalResult: [String: String] = ["test" : ""]
          result(finalResult)
       }else if(call.method == "action_view"){
          let args = call.arguments as? Dictionary<String, Any>
          let url = args?["url"] as! String
          if let urlToOpen = URL(string: url) {
              UIApplication.shared.open(urlToOpen, options: [:], completionHandler: nil)
          }
          let finalResult: [String: String] = ["test" : ""]
          result(finalResult)
       }else{
          result(FlutterMethodNotImplemented)
       }
    })
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
