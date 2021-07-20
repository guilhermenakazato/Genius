import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../components/button_wrap.dart';
import '../screens/login.dart';
import '../screens/presentation.dart';
import '../utils/application_typography.dart';

class AskUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: <Widget>[
          Transform.translate(
            offset: Offset(0, -30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Image.asset(
                        'assets/homem.png',
                        width: 16.h,
                        height: 16.h,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Image.asset(
                        'assets/mulher.png',
                        width: 16.h,
                        height: 16.h,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Você já é usuário\ndo Genius?',
                    style: ApplicationTypography.askUserText,
                    textAlign: TextAlign.center,
                  ),
                ),
                ButtonWrap(
                  width: 40.w,
                  yesScreen: Login(),
                  noScreen: Presentation(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
