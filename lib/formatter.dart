import 'dart:convert';

import 'ansi_color.dart';
import 'log_level.dart';
import 'log_line.dart';

class LogFormatter {
  final ANSIColor errorColors;
  final ANSIColor debugColors;
  final ANSIColor infoColors;
  final ANSIColor warningColors;

  static const JsonEncoder _jsonEncoder = JsonEncoder.withIndent('  ');

  const LogFormatter({
    required this.errorColors,
    required this.debugColors,
    required this.infoColors,
    required this.warningColors,
  });

  List<LogLine> format(
    dynamic message, {
    required LogLevel logLevel,
    required String tag,
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    final formattedMessage = formatMessage(message);
    final formattedError = error != null ? formatError(error) : null;
    final formattedStackTrace =
        stackTrace != null ? formatStackTrace(stackTrace) : null;

    return decorateMessage(
      formattedMessage,
      logLevel,
      tag,
      time,
      formattedError,
      formattedStackTrace,
    );
  }

  String formatMessage(dynamic message) {
    if (message is Map || message is Iterable) {
      return _jsonEncoder.convert(message);
    }
    return message.toString();
  }

  String formatError(Object error) {
    return error.toString();
  }

  String formatStackTrace(StackTrace stackTrace) {
    return stackTrace.toString();
  }

  List<LogLine> decorateMessage(
    String formattedMessage,
    LogLevel logLevel,
    String tag,
    DateTime? time,
    String? formattedError,
    String? formattedStackTrace,
  ) {
    ANSIColor color;
    switch (logLevel) {
      case LogLevel.debug:
        color = debugColors;
        break;
      case LogLevel.info:
        color = infoColors;
        break;
      case LogLevel.warning:
        color = warningColors;
        break;
      case LogLevel.error:
        color = errorColors;
        break;
      default:
        color = ANSIColors.white;
    }

    final lines = <LogLine>[];
    final border = '  ${'─' * 80}';
    final header =
        'LEVEL: ${logLevel.name.toUpperCase()} - Time: ${time ?? DateTime.now()}';
    final decoratedHeader = ' | $header ${' ' * (77 - header.length)} |';

    lines.add(LogLine(content: border, tag: tag, color: color));
    lines.add(LogLine(content: decoratedHeader, tag: tag, color: color));
    lines.add(LogLine(content: border, tag: tag, color: color));

    for (var line in formattedMessage.split('\n')) {
      lines.add(LogLine(content: " | $line", tag: tag, color: color));
    }

    if (formattedError != null) {
      lines.add(LogLine(content: border, tag: tag, color: color));
      for (var line in formattedError.split('\n')) {
        lines.add(LogLine(content: " | $line", tag: tag, color: color));
      }
    }

    if (formattedStackTrace != null) {
      lines.add(LogLine(content: border, tag: tag, color: color));
      lines.add(LogLine(content: " | StackTrace: ", tag: tag, color: color));
      for (var line in formattedStackTrace.split('\n')) {
        lines.add(LogLine(content: " | $line", tag: tag, color: color));
      }
    }

    lines.add(LogLine(content: border, tag: tag, color: color));
    return lines;
  }
}
