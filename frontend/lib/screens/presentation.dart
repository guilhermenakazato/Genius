import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:sizer/sizer.dart';

import '../screens/question_science.dart';
import '../utils/navigator_util.dart';
import '../utils/application_typography.dart';

class Presentation extends StatelessWidget {
  final navigator = NavigatorUtil();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigator.navigate(context, QuestionScience());
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Stack(
          children: [
            Positioned(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 8.h,
                  horizontal: 4.5.h,
                ),
                child: Align(
                  alignment: FractionalOffset.topLeft,
                  child: TypewriterAnimatedTextKit(
                    onTap: () {
                      navigator.navigate(context, QuestionScience());
                    },
                    speed: Duration(milliseconds: 70),
                    text: [
                      'Prazer, Genius!\nEu amo a ciência.\nPor isso, amo\ndivulgá-la e\nconhecer suas\ndiferentes\nformas.'
                    ],
                    textStyle: ApplicationTypography.presentationText,
                    totalRepeatCount: 1,
                    repeatForever: false,
                  ),
                ),
              ),
            ),
            Positioned(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 8.h,
                  horizontal: 4.h,
                ),
                child: Align(
                  alignment: FractionalOffset.bottomRight,
                  child: Image.asset(
                    'assets/homem-sentado.png',
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
