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
        backgroundColor: const Color(0xff000000),
        body: Align(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
               Text(
                'Bem\nVindo!',
                style: ApplicationTypography.welcomeText,
                textAlign: TextAlign.center,
              ),
              Container(
                width: 310.0,
                height: 320.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: const AssetImage('assets/mulher-cfolha.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
