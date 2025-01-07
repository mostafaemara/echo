import 'package:echo/echo.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

final echo = Echo(
    level: LogLevel.all,
    formatter: LogFormatter(
      errorColors: ANSIColors.red,
      debugColors: ANSIColors.green,
      infoColors: ANSIColors.blue,
      warningColors: ANSIColors.yellow,
    ));

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
              echo.d(a.toString());
              echo.i(b.toString());
              echo.w(c.toString());
              echo.d('This is an Custom Tag message \n with a new line',
                  tag: "Repository");
              echo.d('This is an Custom Tag message \n with a new line',
                  tag: "Auth Bloc");

              echo.d('This is an Custom Tag message \n with a new line',
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
