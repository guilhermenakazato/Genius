import 'package:flutter/material.dart';
import 'screens/determine_first_screen.dart';
import 'utils/application_themes.dart';

void main() {
  runApp(Genius());
}

class Genius extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ApplicationThemes.defaultTheme,
      home: DetermineFirstScreen(),
    );
  }
}
