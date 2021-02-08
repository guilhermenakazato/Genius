import 'package:genius/screens/signup/cadastro_nome.dart';
import 'package:genius/utils/navigator_util.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class CadastroIntro extends StatelessWidget {
  final NavigatorUtil navigator = NavigatorUtil();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigator.navigate(context, CadastroNome());
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: TypewriterAnimatedTextKit(
            text: [
              "Agora que te apresentamos o Genius, gostaríamos de saber um pouco mais sobre você!"
            ],
            onFinished: () {
              Future.delayed(Duration(seconds: 1), () {
                navigator.navigate(context, CadastroNome());
              });
            },
            onTap: () {
              navigator.navigate(context, CadastroNome());
            },
            textStyle: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 24,
              fontWeight: FontWeight.w900,
              height: 1.2,
            ),
            textAlign: TextAlign.center,
            speed: Duration(milliseconds: 70),
            totalRepeatCount: 1,
            repeatForever: false,
          ),
        ),
      ),
    );
  }
}
