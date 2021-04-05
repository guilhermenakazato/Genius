import 'dart:async';
import 'package:flutter/material.dart';

import 'screens/welcome.dart';
import 'screens/main/main_screen.dart';
import 'utils/local_store.dart';
import 'utils/application_themes.dart';
import 'http/webclients/login_webclient.dart';

void main() {
  runApp(Genius());
}

class Genius extends StatelessWidget {
  final localStore = LocalStore();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Genius',
      theme: ApplicationThemes.defaultTheme,
      home: FutureBuilder<String>(
        future: verifyToken(),
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == 'none') {
              return Welcome();
            } else {
              return MainScreen();
            }
          }
          return Container();
        },
      ),
    );
  }

  Future<String> verifyToken() async {
    final _token = await localStore.getToken();
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
        localStore.removeToken();
        final token = await localStore.getToken();
        return token;
      }
    }
  }
}
