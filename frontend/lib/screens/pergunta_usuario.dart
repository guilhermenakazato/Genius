import 'package:flutter/material.dart';
import 'package:genius/components/button_wrap.dart';
import 'package:genius/screens/login.dart';
import 'package:genius/screens/prazer_genius.dart';

class PerguntaUsuario extends StatelessWidget {
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
                    Image.asset('assets/homem.png', width: 140, height: 140,),
                    Image.asset('assets/mulher.png', width: 140, height: 140,),
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
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
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
                  simScreen: Login(),
                  naoScreen: PrazerGenius(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
