import 'package:flutter/material.dart';
import 'package:genius/components/button_wrap.dart';
import 'package:genius/models/user.dart';
import 'package:genius/screens/signup/cadastro_age.dart';
import 'package:genius/utils/navigator_util.dart';

class CadastroType extends StatelessWidget {
  final User p;
  final NavigatorUtil navigator = NavigatorUtil();

  CadastroType(this.p);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Align(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Você é um professor ou um estudante?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                ),
              ),
            ),
            ButtonWrap(
              simScreen: CadastroAge(p),
              naoScreen: CadastroAge(p),
              textSim: "Estudante",
              textNao: "Professor",
              width: 130,
              addYesFunction: () {
                p.setType("Estudante");
              },
              addNoFunction: () {
                p.setType("Professor");
              },
            ),
          ],
        ),
      ),
    );
  }
}
