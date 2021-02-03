import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class IniciacaoCientifica extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: TypewriterAnimatedTextKit(
            text: [
              "Iniciação científica\n".toUpperCase() +
                  "é uma forma de colaboração\n".toUpperCase() +
                  "com a ciência através da\n".toUpperCase() +
                  "pesquisa. O objetivo é\n".toUpperCase() +
                  "atualizar o que já existe\n".toUpperCase() +
                  "e realizar descobertas.".toUpperCase()
            ],
            textStyle: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w900,
              height: 1.5,
              letterSpacing: 1,
            ),
            textAlign: TextAlign.center,
            speed: Duration(milliseconds: 70),
            totalRepeatCount: 1,
          ),
        ),
      ),
    );
  }
}
