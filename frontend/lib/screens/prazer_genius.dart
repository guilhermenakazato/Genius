import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import "package:Genius/screens/sabe_iniciacao.dart";

class PrazerGenius extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navegarSabeIniciacao(context);
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          child: Stack(
            children: [
              Transform.translate(
                offset: Offset(40, 80),
                child: TypewriterAnimatedTextKit(
                  onTap: () {
                    navegarSabeIniciacao(context);
                  },
                  speed: Duration(milliseconds: 70),
                  text: [
                    "Prazer, Genius!\nEu amo a ciência.\nPor isso, amo\ndivulgá-la e\nconhecer suas\ndiferentes\nformas."
                        .toUpperCase()
                  ],
                  textStyle: TextStyle(
                    color: const Color(0xffab84e5),
                    fontSize: 23,
                    height: 2.2,
                    letterSpacing: 2,
                    fontFamily: "Gotham",
                    fontWeight: FontWeight.w900,
                  ),
                  totalRepeatCount: 1,
                ),
              ),
              Transform.translate(
                offset: Offset(-20, 300),
                child: Container(
                  width: 350.0,
                  height: 400.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: const AssetImage('assets/homem-sentado.png'),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void navegarSabeIniciacao(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return SabeIniciacao();
    }));
  }
}
