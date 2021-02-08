import 'package:genius/components/button_row.dart';
import 'package:genius/screens/iniciacao_cientifica.dart';
import 'package:genius/screens/signup/cadastro_intro.dart';
import 'package:flutter/material.dart';

class SabeIniciacao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff000000),
      body: Transform.translate(
        offset: Offset(0, 70),
        child: Stack(
          children: <Widget>[
            Transform.translate(
              offset: Offset(70, 100),
              child: Container(
                width: 220.0,
                height: 200.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: const AssetImage('assets/iniciacao-cientifica.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                "Você sabe o que é\niniciação científica?",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontFamily: 'Gotham',
                  fontWeight: FontWeight.w900,
                  fontSize: 28,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Transform.translate(
              offset: Offset(0, 390),
              child: ButtonRow(
                simScreen: CadastroIntro(),
                naoScreen: IniciacaoCientifica(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
