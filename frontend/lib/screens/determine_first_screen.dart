import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../utils/application_colors.dart';
import '../models/token.dart';
import '../http/webclients/login_webclient.dart';
import 'main/main_screen.dart';
import '../screens/welcome.dart';

class DetermineFirstScreen extends StatelessWidget {
  final _tokenObject = Token();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: verifyToken(),
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

  Future<String> verifyToken() async {
    final _token = await _tokenObject.getToken();
    final _webClient = LoginWebClient();

    if (_token == 'none') {
      return _token;
    } else {
      final isValid = await _webClient.check(_token).catchError((error) {
        return false;
      }, test: (error) => error is TimeoutException);

      if (isValid) {
        return _token;
      } else {
        await _tokenObject.removeToken();
        final _token = await _tokenObject.getToken();
        return _token;
      }
    }
  }
}
