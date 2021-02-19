import 'package:flutter/services.dart';
import 'package:genius/components/borderless_input.dart';
import 'package:genius/components/floating_button.dart';
import 'package:genius/models/user.dart';
import 'package:flutter/material.dart';
import 'package:genius/screens/signup/cadastro_senha.dart';
import 'package:genius/utils/navigator_util.dart';
import 'package:email_validator/email_validator.dart';

class CadastroEmail extends StatefulWidget {
  final User p;

  CadastroEmail(this.p);

  @override
  _CadastroEmailState createState() => _CadastroEmailState();
}

class _CadastroEmailState extends State<CadastroEmail> {
  final NavigatorUtil navigator = NavigatorUtil();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingButton(
        onPressed: () {
          verify(context);
        },
      ),
      backgroundColor: Colors.black,
      body: Align(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Text(
                "Prazer em te conhecer, " +
                    widget.p.username +
                    "!\nQual o seu email?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                ),
              ),
            ),
            BorderlessInput(
              hint: "Email",
              controller: _emailController,
              type: TextInputType.emailAddress,
            )
          ],
        ),
      ),
    );
  }

  void verify(BuildContext context) {
    final String email = _emailController.text;

    if (email.isEmpty) {
      showSnackBar("Preencha o campo email!", context);
    } else if (!EmailValidator.validate(email)) {
      showSnackBar("Insira um e-mail válido!", context);
    } else {
      widget.p.setEmail(email);
      navigator.navigate(context, CadastroSenha(widget.p));
    }
  }
}

void showSnackBar(String text, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
  ));
}
