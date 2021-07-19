import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:sizer/sizer.dart';

import 'screens/determine_first_screen.dart';
import 'utils/application_themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Genius());
}

class Genius extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Portal(
      child: Sizer(
        builder: (
          BuildContext context,
          Orientation orientation,
          DeviceType deviceType,
        ) {
          return MaterialApp(
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
          );
        },
      ),
    );
  }
}
