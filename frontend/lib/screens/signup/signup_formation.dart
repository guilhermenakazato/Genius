import 'package:flutter/material.dart';

import '../../components/floating_button.dart';
import '../../models/user.dart';
import '../../screens/signup/signup_institution.dart';
import '../../utils/navigator_util.dart';

class SignUpFormation extends StatelessWidget {
  final User person;
  final NavigatorUtil navigator = NavigatorUtil();

  SignUpFormation(this.person);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingButton(
        onPressed: () {
          nextScreen(context);
        },
      ),
      body: Align(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Qual a sua\nformação acadêmica?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w900,
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void nextScreen(BuildContext context) {
    person.setFormation('Segundo grau incompleto');
    navigator.navigate(context, SignUpInstitution(person));
  }
}
