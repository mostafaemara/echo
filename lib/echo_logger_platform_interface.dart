import 'dart:io';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'echo_logger_method_channel.dart';

abstract class EchoLoggerPlatform extends PlatformInterface {
  /// Constructs a EchoLoggerPlatform.
  EchoLoggerPlatform() : super(token: _token);

  static final Object _token = Object();

  static EchoLoggerPlatform _instance = MethodChannelEchoLogger();

  /// The default instance of [EchoLoggerPlatform] to use.
  ///
  /// Defaults to [MethodChannelEchoLogger].
  static EchoLoggerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [EchoLoggerPlatform] when
  /// they register themselves.
  static set instance(EchoLoggerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> platformLog(String message) async {
    throw UnimplementedError('platformLog() has not been implemented.');
  }
}
