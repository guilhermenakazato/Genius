import 'package:flutter/material.dart';
import 'package:genius/components/borderless_button.dart';
import 'package:genius/components/borderless_input.dart';
import 'package:genius/components/floating_button.dart';
import 'package:genius/models/user.dart';
import 'package:genius/screens/signup/signup_type.dart';
import 'package:genius/utils/application_typography.dart';
import 'package:genius/utils/genius_toast.dart';
import 'package:genius/utils/navigator_util.dart';

class SignUpConfirmPassword extends StatefulWidget {
  final User person;

  SignUpConfirmPassword(this.person);

  @override
  _SignUpConfirmPasswordState createState() => _SignUpConfirmPasswordState();
}

class _SignUpConfirmPasswordState extends State<SignUpConfirmPassword> {
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
        icon: Icons.arrow_forward_ios,
        text: 'Prosseguir',
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Align(
        child: Stack(
          alignment: FractionalOffset.center,
          children: <Widget>[
            Transform.translate(
              offset: Offset(0, -20),
              child: Text(
                'Por favor, confirme sua senha.',
                textAlign: TextAlign.center,
                style: ApplicationTypography.primarySignUpText,
              ),
            ),
            Transform.translate(
              offset: Offset(0, 15),
              child: BorderlessInput(
                hint: 'Senha',
                onSubmit: () {
                  _verifyInput(context);
                },
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
                    color: Theme.of(context).primaryColor,
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
    final password = _passwordController.text.trim();

    if (password.isEmpty) {
      GeniusToast.showToast('Preencha o campo de senha!');
    } else if (password != widget.person.password) {
      GeniusToast.showToast(
        'Você inseriu sua senha incorretamente! Tente de novo.',
      );
    } else {
      _navigator.navigate(context, SignUpType(widget.person));
    }
  }
}
