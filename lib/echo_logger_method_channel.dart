import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'echo_logger_platform_interface.dart';

/// An implementation of [EchoLoggerPlatform] that uses method channels.
class MethodChannelEchoLogger extends EchoLoggerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel("echo_logger");

  @override
  Future<void> platformLog(String message) async {
    try {
      await methodChannel.invokeMethod("log", message);
    } catch (e) {
      print("Failed to log: '$e'.");
    }
  }
}
