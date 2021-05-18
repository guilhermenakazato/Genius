import 'package:flutter/material.dart';

import '../../../components/floating_button.dart';
import '../../../utils/application_typography.dart';

class EditSurveys extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingButton(onPressed: (){}, icon: Icons.add),
      body: Align(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'oi, questionarios',
              style: ApplicationTypography.testText
            ),
          ],
        ),
      ),
    );
  }
}