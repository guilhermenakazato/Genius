import 'package:flutter/material.dart';

import '../components/button_wrap.dart';
import '../screens/intro_science.dart';
import '../screens/signup/signup_intro.dart';
import '../utils/application_typography.dart';

class QuestionScience extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 90.0),
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 290.0),
                child: Align(
                  alignment: FractionalOffset.center,
                  child: Container(
                    width: 220.0,
                    height: 200.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: const AssetImage(
                          'assets/iniciacao-cientifica.png',
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              child: Align(
                alignment: FractionalOffset.center,
                child: Text(
                  'Você sabe o que é\niniciação científica?',
                  style: ApplicationTypography.questionScienceText,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Positioned(
              child: Padding(
                padding: const EdgeInsets.only(top: 150.0),
                child: Align(
                  alignment: FractionalOffset.center,
                  child: ButtonWrap(
                    yesScreen: SignUpIntro(),
                    noScreen: IntroScience(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
