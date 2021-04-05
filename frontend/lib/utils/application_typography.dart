import 'package:flutter/material.dart';

import 'application_colors.dart';

class ApplicationTypography {
  static final welcomeText = TextStyle(
    fontFamily: 'Gotham',
    fontSize: 70,
    letterSpacing: 1.5,
    color: ApplicationColors.primary,
    fontWeight: FontWeight.w900,
    height: 1.0,
  );

  static final askUserText = TextStyle(
    color: ApplicationColors.primary,
    fontSize: 32,
    fontWeight: FontWeight.bold,
  );
}
