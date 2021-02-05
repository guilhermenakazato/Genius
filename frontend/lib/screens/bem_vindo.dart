import 'package:flutter/material.dart';
import 'package:Genius/screens/pergunta_usuario.dart';

class BemVindo extends StatelessWidget {
  BemVindo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PerguntaUsuario();
        }));
      },
      child: Scaffold(
        backgroundColor: const Color(0xff000000),
        body: Stack(
          children: <Widget>[
            Transform.translate(
              offset: Offset(15.0, 280.0),
              child: Container(
                width: 310.0,
                height: 320.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: const AssetImage('assets/mulher-cfolha.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(0, 130.0),
              child: SizedBox(
                width: 410.0,
                child: Text(
                  'Bem\nVindo!',
                  style: TextStyle(
                    fontFamily: 'Gotham',
                    fontSize: 70,
                    letterSpacing: 1.5,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w900,
                    height: 1.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
