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
            // This is the line that will be logged
            echo.d('Button pressed \n Hello World!', name: 'MainApp');
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
