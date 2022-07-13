import Flutter
import UIKit

public class SwiftBeldexCoinPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "beldex_coin", binaryMessenger: registrar.messenger())
        let instance = SwiftBeldexCoinPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
