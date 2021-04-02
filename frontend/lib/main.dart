import 'dart:async';
import 'package:flutter/material.dart';

import 'screens/welcome.dart';
import 'screens/main/main_screen.dart';
import 'utils/local_store.dart';
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
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xffab84e5),
        accentColor: const Color(0xffab84e5),
        cardColor: const Color(0xFF3D3B8E),
        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: const Color(0xFFEEE5D6),
          ),
        ),
        scaffoldBackgroundColor: const Color((0xFF131313)),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: const Color(0xFF312F72),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Gotham',
        textSelectionTheme: TextSelectionThemeData(
          selectionHandleColor: const Color(0xffab84e5),
        ),
      ),

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
    final token = await localStore.getToken();
    final _webClient = LoginWebClient();

    if (token == 'none') {
      return token;
    } else {
      final isValid = await _webClient.check(token).catchError((error) {
        return false;
      }, test: (error) => error is TimeoutException);

      if (isValid) {
        return token;
      } else {
        localStore.removeToken();
        final token = await localStore.getToken();
        return token;
      }
    }
  }
}
