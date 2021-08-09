import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/application_typography.dart';
import 'application_colors.dart';

class ApplicationThemes {
  static final defaultTheme = ThemeData(
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      brightness: Brightness.dark,
      textTheme: TextTheme(
        headline6: ApplicationTypography.appBar,
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
        size: 30,
      ),
    ),
    primaryColor: ApplicationColors.primary,
    colorScheme: ColorScheme(
      primary: ApplicationColors.primary,
      primaryVariant: ApplicationColors.primary,
      secondary: ApplicationColors.primary,
      background: ApplicationColors.primary,
      onBackground: ApplicationColors.primary,
      brightness: Brightness.dark,
      error: ApplicationColors.primary,
      onError: ApplicationColors.primary,
      onPrimary: ApplicationColors.primary,
      onSecondary: ApplicationColors.primary,
      onSurface: ApplicationColors.primary,
      secondaryVariant: ApplicationColors.primary,
      surface: ApplicationColors.primary,
    ),
    cardColor: ApplicationColors.cardColor,
    scaffoldBackgroundColor: ApplicationColors.scaffoldBackground,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ApplicationColors.navigatorBackgroundColor,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: 'Gotham',
    textSelectionTheme: TextSelectionThemeData(
      selectionHandleColor: ApplicationColors.primary,
    ),
  );
}
