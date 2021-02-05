import 'package:Genius/components/button_row.dart';
import 'package:flutter/material.dart';
import "package:Genius/screens/login.dart";
import 'package:Genius/screens/prazer_genius.dart';

class PerguntaUsuario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff000000),
      body: Stack(
        children: <Widget>[
          Transform.translate(
            offset: Offset(0, 160),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: new AssetImage("assets/homem.png"),
                    ),
                  ),
                ),
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: new AssetImage("assets/mulher.png"),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Text(
              "Você já é usuário\ndo Genius?",
              style: TextStyle(
                color:  Theme.of(context).primaryColor,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Transform.translate(
            offset: Offset(0, 390),
            child: ButtonRow(
              simScreen: Login(),
              naoScreen: PrazerGenius(),
            ),
          ),
        ],
      ),
    );
  }
}
