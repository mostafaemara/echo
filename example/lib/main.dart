import 'package:echo/echo.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

final echo = Echo(level: LogLevel.debug);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            List<Duck> a = [
              Duck(name: 'Donald', age: 3),
              Duck(name: 'Daisy', age: 2)
            ];
            echo.log(a, level: LogLevel.debug);
          },
          child: Icon(Icons.add),
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
