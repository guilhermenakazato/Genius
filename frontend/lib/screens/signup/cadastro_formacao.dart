//TODO: documentar
import 'package:flutter/material.dart';
import 'package:genius/components/floating_button.dart';
import 'package:genius/models/user.dart';
import 'package:genius/screens/signup/cadastro_instituicao.dart';
import 'package:genius/utils/navigator_util.dart';

class CadastroFormacao extends StatelessWidget {
  final User p;
  final NavigatorUtil navigator = NavigatorUtil();

  CadastroFormacao(this.p);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingButton(
        onPressed: () {
          nextScreen(context);
        },
      ),
      body: Align(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Qual a sua\nformação acadêmica?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w900,
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void nextScreen(BuildContext context) {
    p.setFormacao('Segundo grau incompleto');
    navigator.navigate(context, CadastroInstituicao(p));
  }
}
