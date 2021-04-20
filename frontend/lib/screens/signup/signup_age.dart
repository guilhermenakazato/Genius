import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../components/picker.dart';
import '../../components/floating_button.dart';
import '../../models/user.dart';
import '../../screens/signup/signup_local.dart';
import '../../utils/navigator_util.dart';
import '../../utils/application_typography.dart';

class SignUpAge extends StatefulWidget {
  final User person;

  SignUpAge(this.person);

  @override
  _SignUpAgeState createState() => _SignUpAgeState();
}

class _SignUpAgeState extends State<SignUpAge> {
  int _age = 0;
  final navigator = NavigatorUtil();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButton: FloatingButton(
        onPressed: () {
          _nextScreen(context);
        },
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Align(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Qual a sua idade?',
              textAlign: TextAlign.center,
              style: ApplicationTypography.primarySignUpText,
            ),
            Picker(
              onChanged: (int value) {
                _age = value;
              },
            ),
          ],
        ),
      ),
    );
  }

  void _nextScreen(BuildContext context) {
    widget.person.setAge((_age + 10).toString());
    navigator.navigate(context, SignUpLocal(widget.person));
  }
}
