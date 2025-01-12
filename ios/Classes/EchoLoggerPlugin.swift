import Flutter
import UIKit

public class EchoLoggerPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "echo_logger", binaryMessenger: registrar.messenger())
    let instance = EchoLoggerPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "log":
      if let message = call.arguments as? String {
        // Log the message using NSLog
        NSLog("%@", "sasas")
        result(true) // Return success
      } else {
        result(FlutterError(code: "INVALID_ARGUMENT",
                            message: "Message argument is missing or invalid",
                            details: nil))
      }
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}