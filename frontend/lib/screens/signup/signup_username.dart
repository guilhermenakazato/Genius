import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../components/borderless_input.dart';
import '../../utils/application_typography.dart';
import '../../components/floating_button.dart';
import '../../utils/application_colors.dart';
import '../../utils/navigator_util.dart';
import '../../models/user.dart';
import 'signup_password.dart';

class SignUpUsername extends StatefulWidget {
  final User person;

  SignUpUsername(this.person);

  @override
  _SignUpUsernameState createState() => _SignUpUsernameState();
}

class _SignUpUsernameState extends State<SignUpUsername> {
  final _navigator = NavigatorUtil();
  final _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingButton(
        onPressed: () {
          _verifyInput(context);
        },
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
                      'Legal! Agora, digite um\nnome de usuário.',
                      textAlign: TextAlign.center,
                      style: ApplicationTypography.primarySignUpText,
                    ),
                  ),
                ),
              ),
              BorderlessInput(
                hint: '@nome',
                controller: _usernameController,
                type: TextInputType.name,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _verifyInput(BuildContext context) {
    final _name = _usernameController.text.trimLeft();

    if (_name.isEmpty) {
      _showToast('Preencha o campo nome!');
    } else {
      widget.person.setUsername(_name.trimRight());
      _navigator.navigate(context, SignUpPassword(widget.person));
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
