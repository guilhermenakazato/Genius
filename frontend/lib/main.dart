import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
        locale: Locale('pt', 'BR'),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('pt', 'BR'),
        ],
        theme: ApplicationThemes.defaultTheme,
        home: DetermineFirstScreen(),
      ),
    );
  }
}
