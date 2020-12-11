import 'package:Genius/components/button_row.dart';
import 'package:Genius/screens/cadastro.dart';
import 'package:Genius/screens/iniciacao_cientifica.dart';
import 'package:flutter/material.dart';

class SabeIniciacao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
                "Você sabe o que é\niniciação científica?".toUpperCase(),
                style: TextStyle(
                  color: const Color(0xffab84e5),
                  fontFamily: 'Gotham',
                  fontWeight: FontWeight.w900,
                  fontSize: 21,
                  height: 1.3,
                  letterSpacing: 3,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Transform.translate(
              offset: Offset(0, 390),
              child: ButtonRow(
                simScreen: Cadastro(),
                naoScreen: IniciacaoCientifica(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
