import 'package:flutter/material.dart';

import '../utils/application_typography.dart';
import '../utils/application_colors.dart';

class DataNotFound extends StatelessWidget {
  final String text;

  const DataNotFound({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.translate(
            offset: Offset(0, -30),
            child: Column(
              children: [
                Icon(
                  Icons.sentiment_very_dissatisfied,
                  size: 100,
                  color: ApplicationColors.notFoundColor,
                ),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: ApplicationTypography.notFoundText,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
