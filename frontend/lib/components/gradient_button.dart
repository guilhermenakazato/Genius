import 'package:flutter/material.dart';

import '../utils/application_colors.dart';
import '../utils/application_typography.dart';

class GradientButton extends StatelessWidget {
  final Function onPressed;
  final String text;

  const GradientButton({
    Key key,
    @required this.onPressed,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.0),
        gradient: LinearGradient(
          colors: ApplicationColors.gradientButtonColors,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(32.0),
          onTap: onPressed,
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: ApplicationTypography.gradientButton,
            ),
          ),
        ),
      ),
    );
  }
}
