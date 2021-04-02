import 'package:flutter/material.dart';

import '../../components/button_wrap.dart';
import '../../models/user.dart';
import '../../screens/signup/signup_formation.dart';

class SignUpType extends StatelessWidget {
  final User person;

  SignUpType(this.person);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Align(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Você é um professor ou um estudante?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                ),
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
            ),
          ],
        ),
      ),
    );
  }
}
