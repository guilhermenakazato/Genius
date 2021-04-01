import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../screens/signup/signup_intro.dart';
import '../utils/navigator_util.dart';

class IntroScience extends StatelessWidget {
  final NavigatorUtil navigator = NavigatorUtil();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigator.navigate(context, SignUpIntro());
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: TypewriterAnimatedTextKit(
            text: [
              'Iniciação científica\n é uma forma de colaboração\n com a ciência através da\n pesquisa. O objetivo é\n atualizar o que já existe\n e realizar descobertas.'
            ],
            onTap: () {
              navigator.navigate(context, SignUpIntro());
            },
            textStyle: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 24,
              fontWeight: FontWeight.w900,
              fontFamily: 'Gotham',
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
