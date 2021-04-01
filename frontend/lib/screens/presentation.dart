import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../screens/question_science.dart';
import '../utils/navigator_util.dart';

class Presentation extends StatelessWidget {
  final NavigatorUtil navigator = NavigatorUtil();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigator.navigate(context, QuestionScience());
      },
      child: Scaffold(
        backgroundColor: const Color(0xff000000),
        body: Stack(
          children: [
            Positioned(
              child: Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1,
                  top: MediaQuery.of(context).size.height * 0.03,
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
                    textStyle: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: MediaQuery.of(context).size.height * 0.05,
                      height: 2,
                      fontFamily: 'Gotham',
                      fontWeight: FontWeight.w900,
                    ),
                    totalRepeatCount: 1,
                    repeatForever: false,
                  ),
                ),
              ),
            ),
            Positioned(
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: 72.0,
                  right: MediaQuery.of(context).size.width * 0.07,
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
