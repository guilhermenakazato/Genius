import 'package:flutter/material.dart';

import '../utils/application_colors.dart';
import '../utils/application_typography.dart';

class GradientButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final double width, height;
  final EdgeInsets padding;

  const GradientButton({
    Key key,
    @required this.onPressed,
    @required this.text,
    this.width,
    this.height, this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(33.0),
        gradient: LinearGradient(
          colors: ApplicationColors.gradientButtonColors,
          begin: Alignment.bottomRight,
          end: Alignment.centerLeft,
        ),
      ),
      padding: padding,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(33.0),
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
