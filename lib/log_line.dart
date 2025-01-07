import 'package:echo/ansi_color.dart';

class LogLine {
  final String content;
  final String tag;
  final ANSIColor color;

  LogLine({required this.content, required this.tag, required this.color});
}
