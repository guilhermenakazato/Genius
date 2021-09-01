import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../utils/application_colors.dart';
import '../models/jwt_token.dart';
import '../http/webclients/login_webclient.dart';
import 'main/main_screen.dart';
import '../screens/welcome.dart';

class DetermineFirstScreen extends StatelessWidget {
  final _tokenObject = JwtToken();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _verifyIfTokenIsValid(),
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == 'none') {
            return Welcome();
          } else {
            return MainScreen();
          }
        }
        return SpinKitFadingCube(color: ApplicationColors.primary);
        
      },
    );
  }

  Future<String> _verifyIfTokenIsValid() async {
    final token = await _tokenObject.getToken();
    final loginWebClient = LoginWebClient();

    if (token == 'none') {
      return token;
    } else {
      final isValid = await loginWebClient.check(token).catchError((error) {
        return false;
      }, test: (error) => error is TimeoutException);

      if (isValid) {
        return token;
      } else {
        await _tokenObject.eraseToken();
        final token = await _tokenObject.getToken();
        return token;
      }
    }
  }
}
