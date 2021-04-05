import 'package:flutter/material.dart';

import '../components/button_wrap.dart';
import '../screens/login.dart';
import '../screens/presentation.dart';
import '../utils/application_typography.dart';

class AskUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff000000),
      body: Stack(
        children: <Widget>[
          Positioned(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 192.0),
              child: Align(
                alignment: FractionalOffset.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/homem.png',
                      width: 140,
                      height: 140,
                    ),
                    Image.asset(
                      'assets/mulher.png',
                      width: 140,
                      height: 140,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            child: Align(
              alignment: FractionalOffset.center,
              child: Text(
                'Você já é usuário\ndo Genius?',
                style: ApplicationTypography.askUserText,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Positioned(
            child: Padding(
              padding: const EdgeInsets.only(top: 136.0),
              child: Align(
                alignment: FractionalOffset.center,
                child: ButtonWrap(
                  yesScreen: Login(),
                  noScreen: Presentation(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
