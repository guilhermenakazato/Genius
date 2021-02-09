import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genius/components/borderless_button.dart';
import 'package:genius/components/borderless_input.dart';
import 'package:genius/components/floating_button.dart';
import 'package:genius/models/user.dart';
import 'package:genius/screens/signup/cadastro_type.dart';
import 'package:genius/utils/navigator_util.dart';

class CadastroSenha extends StatefulWidget {
  final User p;

  CadastroSenha(this.p);

  @override
  _CadastroSenhaState createState() => _CadastroSenhaState();
}

class _CadastroSenhaState extends State<CadastroSenha> {
  final TextEditingController _passwordController = TextEditingController();
  final NavigatorUtil navigator = NavigatorUtil();
  bool _obscure = true;

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
        child: Stack(
          alignment: FractionalOffset.center,
          children: <Widget>[
            Transform.translate(
              offset: Offset(0, -20),
              child: Text(
                "Ótimo! Agora insira uma senha.",
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
                hint: "Senha",
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
                    text: "Mostrar\nsenha",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void verify(BuildContext context) {
    final String password = _passwordController.text;

    if (password.isEmpty) {
      showSnackBar("Preencha o campo de senha!", context);
    } else {
      widget.p.setPassword(password);
      navigator.navigate(context, CadastroType(widget.p));
    }
  }

  void showSnackBar(String text, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
    ));
  }
}
