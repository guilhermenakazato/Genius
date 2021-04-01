import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../components/borderless_button.dart';
import '../../components/borderless_input.dart';
import '../../components/floating_button.dart';
import '../../models/user.dart';
import '../../screens/signup/signup_type.dart';
import '../../utils/navigator_util.dart';

class SignUpPassword extends StatefulWidget {
  final User person;

  SignUpPassword(this.person);

  @override
  _SignUpPasswordState createState() => _SignUpPasswordState();
}

class _SignUpPasswordState extends State<SignUpPassword> {
  final TextEditingController _passwordController = TextEditingController();
  final NavigatorUtil navigator = NavigatorUtil();
  bool _obscure = true;

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
        child: Stack(
          alignment: FractionalOffset.center,
          children: <Widget>[
            Transform.translate(
              offset: Offset(0, -20),
              child: Text(
                'Ótimo! Agora insira uma senha.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                ),
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

  void verifyInput(BuildContext context) {
    final password = _passwordController.text.trimLeft();

    if (password.isEmpty) {
      showSnackBar('Preencha o campo de senha!', context);
    } else if (password.length <= 7) {
      showSnackBar('Insira uma senha de pelo menos 8 caracteres!', context);
    } else if (password.contains(' ')) {
      showSnackBar('A sua senha não pode conter um espaço em branco!', context);
    } else {
      widget.person.setPassword(password);
      navigator.navigate(context, SignUpType(widget.person));
    }
  }

  void showSnackBar(String text, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
    ));
  }
}
