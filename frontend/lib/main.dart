import 'package:flutter/material.dart';
import 'screens/determine_first_screen.dart';

import 'utils/application_themes.dart';
import 'package:flutter_portal/flutter_portal.dart';

void main() {
  runApp(Genius());
}

class Genius extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Portal(
      child: MaterialApp(
        theme: ApplicationThemes.defaultTheme,
        home: DetermineFirstScreen(),
      ),
    );
  }
}
