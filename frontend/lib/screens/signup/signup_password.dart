import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../components/borderless_button.dart';
import '../../components/borderless_input.dart';
import '../../components/floating_button.dart';
import '../../models/user.dart';
import '../../screens/signup/signup_type.dart';
import '../../utils/navigator_util.dart';
import '../../utils/application_typography.dart';

class SignUpPassword extends StatefulWidget {
  final User person;

  SignUpPassword(this.person);

  @override
  _SignUpPasswordState createState() => _SignUpPasswordState();
}

class _SignUpPasswordState extends State<SignUpPassword> {
  final _passwordController = TextEditingController();
  final _navigator = NavigatorUtil();
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingButton(
        onPressed: () {
          _verifyInput(context);
        },
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Align(
        child: Stack(
          alignment: FractionalOffset.center,
          children: <Widget>[
            Transform.translate(
              offset: Offset(0, -20),
              child: Text(
                'Ótimo! Agora insira uma senha.',
                textAlign: TextAlign.center,
                style: ApplicationTypography.primarySignUpText,
              ),
            ),
            Transform.translate(
              offset: Offset(0, 15),
              child: BorderlessInput(
                hint: 'Senha',
                controller: _passwordController,
                type: TextInputType.text,
                obscure: _obscure,
              ),
            ),
            Positioned(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 20, 19),
                child: Align(
                  alignment: FractionalOffset.bottomLeft,
                  child: BorderlessButton(
                    onPressed: () {
                      setState(() {
                        _obscure = !_obscure;
                      });
                    },
                    text: 'Mostrar\nsenha',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _verifyInput(BuildContext context) {
    final _password = _passwordController.text.trimLeft();

    if (_password.isEmpty) {
      _showSnackBar('Preencha o campo de senha!', context);
    } else if (_password.length <= 7) {
      _showSnackBar('Insira uma senha de pelo menos 8 caracteres!', context);
    } else if (_password.contains(' ')) {
      _showSnackBar(
          'A sua senha não pode conter um espaço em branco!', context);
    } else {
      widget.person.setPassword(_password);
      _navigator.navigate(context, SignUpType(widget.person));
    }
  }

  void _showSnackBar(String text, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
    ));
  }
}
