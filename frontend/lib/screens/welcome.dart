import 'package:flutter/material.dart';

import '../screens/ask_user.dart';
import '../utils/application_typography.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return AskUser();
        }));
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Align(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _welcomeText(context),
              _welcomeImage(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _welcomeText(BuildContext context) {
    return Text(
      'Bem\nVindo!',
      style: ApplicationTypography.welcomeTitle(context),
      textAlign: TextAlign.center,
    );
  }

  Widget _welcomeImage(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.longestSide * 0.6,
      height: 300 -  MediaQuery.of(context).size.longestSide * 0.05,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage('assets/mulher-cfolha.png'),
        ),
      ),
    );
  }
}
