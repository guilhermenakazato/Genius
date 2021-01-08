import 'package:flutter/material.dart';
import 'package:Genius/screens/bem_vindo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Genius',
      theme: ThemeData(
        primaryColor: const Color(0xffab84e5),
        
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: "Gotham", 
      ),
      home: BemVindo(),
    );
  }
}
