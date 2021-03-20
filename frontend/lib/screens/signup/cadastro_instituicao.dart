// TODO: documentar
import 'package:flutter/material.dart';
import 'package:genius/components/floating_button.dart';
import 'package:genius/models/user.dart';
import 'package:genius/screens/signup/cadastro_age.dart';
import 'package:genius/utils/navigator_util.dart';

class CadastroInstituicao extends StatelessWidget {
  final User p;
  final NavigatorUtil navigator = NavigatorUtil();

  CadastroInstituicao(this.p);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingButton(
        onPressed: () {
          nextScreen(context);
        },
      ),
      backgroundColor: Colors.black,
      body: Align(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Qual o nome da instituição\nque você dá aula/estuda?",
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
    p.setInstituicao("IFMS");
    navigator.navigate(context, CadastroAge(p));
  }
}
