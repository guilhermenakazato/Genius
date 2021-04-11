import 'package:flutter/material.dart';

import '../../../utils/application_typography.dart';

class Followers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'vc ainda nao tem seguidores',
              style: ApplicationTypography.testText,
            ),
          ],
        ),
      ),
    );
  }
}
