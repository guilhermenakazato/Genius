import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/genius_toast.dart';

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
                'Ótimo! Agora insira uma senha.',
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
    } else if (password.length <= 7) {
      GeniusToast.showToast('Insira uma senha de pelo menos 8 caracteres!');
    } else if (password.contains(' ')) {
      GeniusToast.showToast(
        'A sua senha não pode conter um espaço em branco!',
      );
    } else {
      widget.person.setPassword(password);
      _navigator.navigate(context, SignUpType(widget.person));
    }
  }
}
