import 'dart:io';

import 'ansi_color.dart';
import 'formatter.dart';
import 'log_level.dart';

import 'package:flutter/foundation.dart';
export 'log_level.dart';
export 'ansi_color.dart';
export 'formatter.dart';

class Echo {
  final LogFormatter formatter;
  final LogLevel level;

  Echo({
    this.level = LogLevel.all,
    this.formatter = const LogFormatter(
      errorColors: ANSIColors.red,
      debugColors: ANSIColors.green,
      infoColors: ANSIColors.blue,
      warningColors: ANSIColors.yellow,
    ),
  });

  void log(
    dynamic message, {
    required LogLevel logLevel,
    String tag = 'Echo',
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (logLevel.index < level.index || !kDebugMode) {
      return;
    }
    final lines = formatter.format(
      message,
      logLevel: logLevel,
      tag: tag,
      time: time,
      error: error,
      stackTrace: stackTrace,
    );

    for (var line in lines) {
      _logLine(
        content: line.content,
        tag: line.tag,
        color: line.color,
      );
    }
  }

  void _log(
    String message, {
    required LogLevel logLevel,
    String tag = 'Echo',
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    log(
      message,
      logLevel: logLevel,
      tag: tag,
      time: time,
      error: error,
      stackTrace: stackTrace,
    );
  }

  void d(
    String message, {
    String tag = 'Echo',
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(
      message,
      logLevel: LogLevel.debug,
      tag: tag,
      time: time,
      error: error,
      stackTrace: stackTrace,
    );
  }

  void i(
    String message, {
    String tag = 'Echo',
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(
      message,
      logLevel: LogLevel.info,
      tag: tag,
      time: time,
      error: error,
      stackTrace: stackTrace,
    );
  }

  void w(
    String message, {
    String tag = 'Echo',
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(
      message,
      logLevel: LogLevel.warning,
      tag: tag,
      time: time,
      error: error,
      stackTrace: stackTrace,
    );
  }

  void e(
    String message, {
    String tag = 'Echo',
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(
      message,
      logLevel: LogLevel.error,
      tag: tag,
      time: time,
      error: error,
      stackTrace: stackTrace,
    );
  }

  void _logLine({
    required String content,
    required String tag,
    required ANSIColor color,
  }) {
    final formattedTag = tag.isNotEmpty ? '[$tag]' : '';
    final lineContent = kIsWeb || stdout.supportsAnsiEscapes
        ? '\x1B[${color.foreground}m$formattedTag$content\x1B[0m'
        : '$formattedTag$content';
    if (kIsWeb || Platform.isAndroid || Platform.isIOS) {
      print(lineContent);

      return;
    }

    stdout.writeln(
      lineContent,
    );
  }
}
