library;

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'ansi_color.dart';

class Echo {
  final LogLevel level;

  Echo({required this.level});

  void log(
    dynamic message, {
    required LogLevel level,
    String tag = 'Echo',
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    final formatter = LogFormatter();
    final lines = formatter.formate(
      message,
      level: level,
      tag: tag,
      time: time,
      error: error,
      stackTrace: stackTrace,
    );

    for (var line in lines) {
      _logLine(
        content: line.formattedContent,
        tag: line.tag,
        color: line.color,
      );
    }

    //TODO: 1. filter the message based on the log level
    //TODO: 2. format the message
    //TODO: 3. decorate the message with border and time stamp and log level
    //TODO: 4. print the message to the console
  }

  void d(String message,
      {String? name, DateTime? time, Object? error, StackTrace? stackTrace}) {}

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
  get formattedContent =>
      '\x1B[${color.foreground}m[$tag]$content\x1B[${color.background}m';
  LogLine({required this.content, required this.tag, required this.color});
}

class LogFormatter {
  List<LogLine> formate(
    dynamic message, {
    required LogLevel level,
    required String tag,
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    final lines = <LogLine>[];

    final formattedMessage = formatMessage(message);

    return decorateMessage(
        formattedMessage, level, tag, time, error, stackTrace);
  }

  String formatMessage(dynamic message) {
    if (message is Map || message is Iterable) {
      final formattedMessage = JsonEncoder.withIndent(
        '  ',
        (object) => object.toString(),
      );
      return formattedMessage.convert(message);
    }
    return message.toString();
  }

  List<LogLine> decorateMessage(String formattedMessage, LogLevel level,
      String tag, DateTime? time, Object? error, StackTrace? stackTrace) {
    final lines = <LogLine>[];

    final border = '  ${'─' * 80}';
    final header = 'LEVEL: $level - Time: ${time ?? DateTime.now()}';
    final decoratedHeader = ' | $header ${' ' * (77 - header.length)} |';
    lines.add(LogLine(
      content: border,
      tag: tag,
      color: ANSIColors.cyan,
    ));
    lines.add(LogLine(
      content: decoratedHeader,
      tag: tag,
      color: ANSIColors.cyan,
    ));
    lines.add(LogLine(
      content: border,
      tag: tag,
      color: ANSIColors.cyan,
    ));

    for (var line in formattedMessage.split('\n')) {
      lines.add(LogLine(
        content: " | $line",
        tag: tag,
        color: ANSIColors.cyan,
      ));
    }
    lines.add(LogLine(
      content: border,
      tag: tag,
      color: ANSIColors.cyan,
    ));
    return lines;
  }
}
