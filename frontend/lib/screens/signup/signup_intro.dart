import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../../screens/signup/signup_name.dart';
import '../../utils/navigator_util.dart';

class SignUpIntro extends StatelessWidget {
  final NavigatorUtil navigator = NavigatorUtil();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigator.navigate(context, SignUpName());
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: TypewriterAnimatedTextKit(
            text: [
              'Agora que te apresentamos o Genius, gostaríamos de saber um pouco mais sobre você!'
            ],
            onFinished: () {
              Future.delayed(Duration(seconds: 1), () {
                navigator.navigate(context, SignUpName());
              });
            },
            onTap: () {
              navigator.navigate(context, SignUpName());
            },
            textStyle: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 24,
              fontWeight: FontWeight.w900,
              height: 1.2,
              fontFamily: 'Gotham'
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
