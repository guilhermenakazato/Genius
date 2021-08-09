import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import '../../utils/genius_toast.dart';

import '../../components/borderless_input.dart';
import '../../components/floating_button.dart';
import '../../models/user.dart';
import '../../screens/signup/signup_email.dart';
import '../../utils/navigator_util.dart';
import '../../utils/application_typography.dart';

class SignUpName extends StatefulWidget {
  @override
  _SignUpNameState createState() => _SignUpNameState();
}

class _SignUpNameState extends State<SignUpName> {
  final _nameController = TextEditingController();
  final _navigator = NavigatorUtil();
  final person = User();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingButton(
        onPressed: () {
          _verifyInput(context);
        },
        icon: Icons.arrow_forward_ios,
        text: 'Prosseguir',
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Align(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Transform.translate(
                offset: Offset(0, -10),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      'Qual é o seu nome?',
                      textAlign: TextAlign.center,
                      style: ApplicationTypography.primarySignUpText,
                    ),
                  ),
                ),
              ),
              BorderlessInput(
                onSubmit: () {
                  _verifyInput(context);
                },
                hint: 'Nome + sobrenome',
                controller: _nameController,
                type: TextInputType.name,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _verifyInput(BuildContext context) {
    final name = _nameController.text.trimLeft();

    if (name.isEmpty) {
      GeniusToast.showToast('Preencha o campo nome!');
    } else {
      person.setName(name.trimRight());
      _navigator.navigate(context, SignUpEmail(person));
    }
  }
}
