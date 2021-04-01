import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

import '../../components/borderless_input.dart';
import '../../components/floating_button.dart';
import '../../models/user.dart';
import '../../screens/signup/signup_password.dart';
import '../../utils/navigator_util.dart';

class SignUpEmail extends StatefulWidget {
  final User person;

  SignUpEmail(this.person);

  @override
  _SignUpEmailState createState() => _SignUpEmailState();
}

class _SignUpEmailState extends State<SignUpEmail> {
  final NavigatorUtil navigator = NavigatorUtil();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingButton(
        onPressed: () {
          verifyInput(context);
        },
      ),
      backgroundColor: Colors.black,
      body: Align(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Prazer em te conhecer,\n' +
                  widget.person.username +
                  '!\nQual o seu email?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w900,
                fontSize: 20,
              ),
            ),
            BorderlessInput(
              hint: 'Email',
              controller: _emailController,
              type: TextInputType.emailAddress,
            )
          ],
        ),
      ),
    );
  }

  void verifyInput(BuildContext context) {
    final email = _emailController.text.trimLeft();

    if (email.isEmpty) {
      showSnackBar('Preencha o campo email!', context);
    } else if (!EmailValidator.validate(email)) {
      showSnackBar('Insira um e-mail válido!', context);
    } else {
      widget.person.setEmail(email);
      navigator.navigate(context, SignUpPassword(widget.person));
    }
  }
}

void showSnackBar(String text, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
  ));
}
