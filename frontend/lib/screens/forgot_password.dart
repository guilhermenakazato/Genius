import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/genius_toast.dart';

class ForgotPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 300,
              height: 250,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/password.png'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text:
                            'Olá! Infelizmente, não temos como implementar essa função, pois envolve o uso de cartões de crédito e dinheiro que não temos. Felizmente, você pode '),
                    TextSpan(
                      text: 'falar com a gente',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blue,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          _handleLinkClick();
                        },
                    ),
                    TextSpan(
                        text:
                            ' pelo nosso Instagram e encontraremos uma solução!')
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleLinkClick() async {
    var instagramUrl = 'https://www.instagram.com/app.genius/';

    if (await canLaunch(instagramUrl)) {
      await launch(instagramUrl);
    } else {
      GeniusToast.showToast('Não foi possível abrir o link.');
    }
  }
}
