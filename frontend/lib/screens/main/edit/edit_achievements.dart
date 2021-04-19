import 'package:flutter/material.dart';

import '../../../utils/application_typography.dart';

class EditConquistas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'oi, conquistas',
              style: ApplicationTypography.testText
            ),
          ],
        ),
      ),
    );
  }
}