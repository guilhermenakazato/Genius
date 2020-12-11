import 'package:Genius/components/input.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Align(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Transform.translate(
                offset: Offset(0, -10),
                child: Container(
                  width: double.infinity,
                  child: Text(
                    "Login".toUpperCase(),
                    style: TextStyle(
                      color: const Color(0xffab84e5),
                      fontSize: 20,
                      letterSpacing: 7,
                      fontWeight: FontWeight.w900,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(0, -10),
                child: Container(
                  width: 250,
                  child: Divider(
                    color: const Color(0xffab84e5),
                  ),
                ),
              ),
              Input(
                controller: _emailController,
                hint: "E-mail",
              ),
              Input(
                controller: _passwordController,
                hint: "Senha",
                obscure: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
