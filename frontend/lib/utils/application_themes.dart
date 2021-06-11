import 'package:flutter/material.dart';

import '../utils/application_typography.dart';
import 'application_colors.dart';

class ApplicationThemes {
  static final defaultTheme = ThemeData(
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      textTheme: TextTheme(
        headline6: ApplicationTypography.appBar,
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
        size: 30,
      ),
    ),
    primaryColor: ApplicationColors.primary,
    accentColor: ApplicationColors.accent,
    cardColor: ApplicationColors.cardColor,
    textTheme: TextTheme(
      bodyText1: TextStyle(
        color: ApplicationColors.secondaryTextColor,
      ),
    ),
    scaffoldBackgroundColor: ApplicationColors.scaffoldBackground,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ApplicationColors.navigatorBackgroundColor,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: 'Gotham',
    textSelectionTheme: TextSelectionThemeData(
      selectionHandleColor: ApplicationColors.accent,
    ),
  );
}
