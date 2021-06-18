import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../../screens/signup/signup_name.dart';
import '../../utils/navigator_util.dart';
import '../../utils/application_typography.dart';

class SignUpIntro extends StatelessWidget {
  final _navigator = NavigatorUtil();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _navigator.navigate(context, SignUpName());
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: TypewriterAnimatedTextKit(
              text: [
                'Agora que te apresentamos o Genius, gostaríamos de saber um pouco mais sobre você!'
              ],
              onFinished: () {
                Future.delayed(Duration(seconds: 1), () {
                  _navigator.navigate(context, SignUpName());
                });
              },
              onTap: () {
                _navigator.navigate(context, SignUpName());
              },
              textStyle: ApplicationTypography.signUpIntro,
              textAlign: TextAlign.center,
              speed: Duration(milliseconds: 70),
              totalRepeatCount: 1,
              repeatForever: false,
            ),
          ),
        ),
      ),
    );
  }
}
