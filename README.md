# Echo Logger - Custom Logging for Flutter

**Echo Logger** is a powerful and flexible logging utility for Flutter that allows developers to log messages with custom tags, colors, and severity levels. It is designed to make debugging and monitoring easier by providing a highly customizable logging experience.

---

## Table of Contents

- [Echo Logger - Custom Logging for Flutter](#echo-logger---custom-logging-for-flutter)
  - [Table of Contents](#table-of-contents)
  - [Installation](#installation)
  - [Usage](#usage)
    - [Basic Usage](#basic-usage)
    - [Custom Tags](#custom-tags)
    - [Custom Colors for Each Log Level](#custom-colors-for-each-log-level)
    - [Log Levels](#log-levels)
  - [Features](#features)
  - [Screenshots](#screenshots)
    - [Available ANSI Color Codes](#available-ansi-color-codes)

---

## Installation

Add `echo_logger` to your `pubspec.yaml` file:

```yaml
dependencies:
  echo_logger: ^0.0.4
```

Then run:

```bash
flutter pub get
```

---

## Usage

### Basic Usage

Import the package and start logging:

```dart
import 'package:echo_logger/echo_logger.dart';

void main() {
  final echo = Echo(
    level: LogLevel.all,
    formatter: LogFormatter(
      errorColors: ANSIColors.red,
      debugColors: ANSIColors.green,
      infoColors: ANSIColors.blue,
      warningColors: ANSIColors.yellow,
    ),
  );

  echo.d('This is a debug message');
  echo.i('This is an info message');
  echo.w('This is a warning message');
  echo.e('This is an error message');
}
```

### Custom Tags

Override the default tag (`Echo`) with your own custom tag:

```dart
echo.d('Debug message with custom tag', name: 'MyTag');
```

### Custom Colors for Each Log Level

You can customize the colors for each log level by passing a `LogFormatter` with predefined or custom `ANSIColor` instances to the `Echo` constructor:

```dart
import 'package:echo_logger/echo_logger.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

// Create an Echo instance with custom colors for each log level
final echo = Echo(
  level: LogLevel.all,
  formatter: LogFormatter(
    errorColors: ANSIColors.red,       // Custom color for error logs
    debugColors: ANSIColors.green,     // Custom color for debug logs
    infoColors: ANSIColors.blue,       // Custom color for info logs
    warningColors: ANSIColors.yellow,  // Custom color for warning logs
  ),
);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            try {
              List<Duck> a = [
                Duck(name: 'Donald', age: 3),
                Duck(name: 'Daisy', age: 2)
              ];

              Map<String, Duck> b = {
                'Donald': Duck(name: 'Donald', age: 3),
                'Daisy': Duck(name: 'Daisy', age: 2)
              };

              Set<Duck> c = {
                Duck(name: 'Donald', age: 3),
                Duck(name: 'Daisy', age: 2)
              };

              echo.d(a.toString()); // Debug log with custom color
              echo.i(b.toString()); // Info log with custom color
              echo.w(c.toString()); // Warning log with custom color

              echo.d('This is a custom tag message \n with a new line',
                  tag: "Repository");

              echo.d('This is a custom tag message \n with a new line',
                  tag: "Auth Bloc");

              echo.d('This is a custom tag message \n with a new line',
                  tag: "Database");

              throw Exception('This is an exception');
            } catch (e, s) {
              echo.e(
                'This is an error message',
                error: e,
                stackTrace: s,
              );
            }
          },
          child: Icon(Icons.send),
        ),
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}

class Duck {
  final String name;
  final int age;

  Duck({required this.name, required this.age});

  @override
  String toString() {
    return 'Duck{name: $name, age: $age}';
  }
}
```

### Log Levels

Filter logs based on severity levels:

```dart
Echo(
  level: LogLevel.debug, // Only logs with level >= debug will be shown
).log('This is a debug log', level: LogLevel.debug);
```

Available log levels:

- `LogLevel.all` (show all logs)
- `LogLevel.debug`
- `LogLevel.info`
- `LogLevel.warning`
- `LogLevel.error`
- `LogLevel.none` (disable all logs)

---

## Features

- **Custom Tags:** Override the default tag with your own.
- **Custom Colors:** Fully customizable colors for each log level.
- **Log Levels:** Filter logs based on severity.
- **ANSI Colors:** Colored logs for better readability in terminals.
- **Platform Compatibility:** Works on all Flutter-supported platforms (Android, iOS, web, Windows, macOS, Linux).

---

## Screenshots

![Screenshot Placeholder](https://github.com/mostafaemara/echo/blob/main/example.png?raw=true)

*Replace the above link with the actual image path or URL.*

---

### Available ANSI Color Codes

You can use the following predefined `ANSIColor` constants or create your own:

```dart
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
```

---

**Echo Logger** - Simplify your logging with custom tags, colors, and levels. 🚀
