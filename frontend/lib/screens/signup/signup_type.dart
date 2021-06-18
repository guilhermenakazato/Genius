import 'package:flutter/material.dart';

import '../../components/button.dart';
import '../../utils/navigator_util.dart';
import '../../components/button_wrap.dart';
import '../../models/user.dart';
import '../../screens/signup/signup_formation.dart';
import '../../utils/application_typography.dart';

class SignUpType extends StatelessWidget {
  final User person;
  final navigator = NavigatorUtil();

  SignUpType(this.person);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Align(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Você é um professor, um estudante ou um cidadão?',
                textAlign: TextAlign.center,
                style: ApplicationTypography.primarySignUpText,
              ),
            ),
            ButtonWrap(
              yesScreen: SignUpFormation(person),
              noScreen: SignUpFormation(person),
              textYes: 'Estudante',
              textNo: 'Professor',
              width: 130,
              addYesFunction: () {
                person.setType('Estudante');
              },
              addNoFunction: () {
                person.setType('Professor');
              },
              additionalWidget: Button(
                width: 130,
                text: 'Cidadão',
                onClick: () {
                  person.setType('Cidadão');
                  navigator.navigate(context, SignUpFormation(person));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
