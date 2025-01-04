class ANSIColor {
  final int foreground;
  final int background;
  const ANSIColor({required this.foreground, required this.background});
}

abstract class ANSIColors {
  static const black = ANSIColor(foreground: 30, background: 40);
  static const red = ANSIColor(foreground: 31, background: 41);
  static const green = ANSIColor(foreground: 32, background: 42);
  static const yellow = ANSIColor(foreground: 33, background: 43);
  static const blue = ANSIColor(foreground: 34, background: 44);
  static const magenta = ANSIColor(foreground: 35, background: 45);
  static const cyan = ANSIColor(foreground: 36, background: 46);
  static const white = ANSIColor(foreground: 37, background: 47);
  static const brightBlack = ANSIColor(foreground: 90, background: 100);
  static const brightRed = ANSIColor(foreground: 91, background: 101);
  static const brightGreen = ANSIColor(foreground: 92, background: 102);
  static const brightYellow = ANSIColor(foreground: 93, background: 103);
  static const brightBlue = ANSIColor(foreground: 94, background: 104);
  static const brightMagenta = ANSIColor(foreground: 95, background: 105);
  static const brightCyan = ANSIColor(foreground: 96, background: 106);
  static const brightWhite = ANSIColor(foreground: 97, background: 107);
}
