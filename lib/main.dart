import 'package:flutter/material.dart';
import 'Root.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: const Color(0xFF530B51),
        accentColor: const Color(0xFF58CDCD)
      ),
      home: Root(),
    );
  }
}



