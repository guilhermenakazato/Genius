import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../utils/application_colors.dart';
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
  final _nomeController = TextEditingController();
  final _navigator = NavigatorUtil();
  final person = User();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingButton(
        onPressed: () {
          _verifyInput(context);
        },icon: Icons.arrow_forward_ios,
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
                hint: 'Nome + sobrenome',
                controller: _nomeController,
                type: TextInputType.name,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _verifyInput(BuildContext context) {
    final _name = _nomeController.text.trimLeft();

    if (_name.isEmpty) {
      _showToast('Preencha o campo nome!');
    } else {
      person.setName(_name.trimRight());
      _navigator.navigate(context, SignUpEmail(person));
    }
  }

  void _showToast(String text) {
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: ApplicationColors.toastColor,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }
}
