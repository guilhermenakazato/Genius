import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../components/button_wrap.dart';
import '../screens/intro_science.dart';
import '../screens/signup/signup_intro.dart';
import '../utils/application_typography.dart';

class QuestionScience extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Stack(
          children: <Widget>[
            Transform.translate(
              offset: Offset(0, -30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 35.h,
                    height: 30.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: const AssetImage(
                          'assets/iniciacao-cientifica.png',
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Você sabe o que é\niniciação científica?',
                      style: ApplicationTypography.questionScienceText,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ButtonWrap(
                    yesScreen: SignUpIntro(),
                    noScreen: IntroScience(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
