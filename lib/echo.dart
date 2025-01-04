library;

import 'dart:io';

import 'ansi_color.dart';

class Echo {
  final LogLevel level;

  Echo({required this.level});

  void d(String message,
      {String? name, DateTime? time, Object? error, StackTrace? stackTrace}) {
    if (level.index <= LogLevel.debug.index) {
      _log(message, level: LogLevel.debug, tag: name ?? 'Echo', time: time);
    }
  }

  void i(
    String message, {
    String? name,
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {}

  void w(String message,
      {String? name, DateTime? time, Object? error, StackTrace? stackTrace}) {}

  void e(String message,
      {String? name, DateTime? time, Object? error, StackTrace? stackTrace}) {}
  void _log(
    String message, {
    required LogLevel level,
    String tag = 'Echo',
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    final logLines = _prettyFormat(message,
        level: level,
        tag: tag,
        time: time,
        error: error,
        stackTrace: stackTrace);
    for (var line in logLines) {
      _logLine(content: line.content, tag: line.tag, color: line.color);
    }
  }

  void _logLine({
    required String content,
    required String tag,
    required ANSIColor color,
  }) {
    stdout.writeln(
        '\x1B[${color.foreground}m[$tag]$content\x1B[${color.background}m');
  }
}

enum LogLevel { debug, info, warning, error, all, none }

class LogLine {
  final String content;
  final String tag;
  final ANSIColor color;

  LogLine({required this.content, required this.tag, required this.color});
}

List<LogLine> _prettyFormat(
  String message, {
  required LogLevel level,
  required String tag,
  DateTime? time,
  Object? error,
  StackTrace? stackTrace,
}) {
  final List<LogLine> logLines = [];
  final lineLength = 80;
  final String border = '-' * lineLength;
  final formattedTime =
      time?.toIso8601String() ?? DateTime.now().toIso8601String();
  final String header =
      '${time?.toIso8601String() ?? DateTime.now().toIso8601String()} | ${level.toString().toUpperCase()}';

  logLines.add(LogLine(content: header, tag: tag, color: ANSIColors.cyan));
  for (var line in message.split('\n')) {
    logLines.add(LogLine(content: "| $line", tag: tag, color: ANSIColors.cyan));
  }
  logLines.add(LogLine(content: border * 2, tag: tag, color: ANSIColors.cyan));
  return logLines;
}
