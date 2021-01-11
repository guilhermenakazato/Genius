import 'dart:async';

import 'package:Genius/components/button.dart';
import 'package:Genius/components/input.dart';
import 'package:Genius/http/webclients/login_webclient.dart';
import 'package:Genius/models/auth.dart';
import 'package:Genius/models/token.dart';
import 'package:Genius/utils/navigator_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'main/tela_principal.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff000000),
      body: _LoginStateBody(),
    );
  }
}

class _LoginStateBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      borderColor: const Color(0xffab84e5),
      indicatorWidget: SpinKitPouringHourglass(
        color: const Color(0xffab84e5),
      ),
      child: Builder(
        builder: (context) => _LoginStateContent(context),
      ),
    );
  }
}

class _LoginStateContent extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final BuildContext progressContext;

  _LoginStateContent(this.progressContext);

  @override
  Widget build(BuildContext context) {
    return Align(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Transform.translate(
              offset: Offset(0, -10),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
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
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Button(
                text: "Login",
                width: 150,
                height: 50,
                onClick: () {
                  handleLogin(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void handleLogin(BuildContext context) async {
    // Só pra não ter q escrever td a variável dnv
    final String email = _emailController.text;
    final String senha = _passwordController.text;
    final LoginWebClient _webClient = LoginWebClient();
    final NavigatorUtil navigator = NavigatorUtil();
    final progress = ProgressHUD.of(context);

    // talvez tenham mais exceções, mas por enquanto é isso
    if (email.contains(" ") || senha.contains(" ")) {
      showSnackBar("Preencha os campos acima sem espaços em branco!", context);
    } else if (email.isEmpty || senha.isEmpty) {
      showSnackBar("Preencha os campos acima!", context);
    } else {
      progress.show();

      // Faz login e pega um token
      Token token = await _webClient.login(Auth(email, senha)).catchError((e) {
        progress.dismiss();
        showSnackBar(e.message, context);
      }, test: (e) => e is HttpException).catchError((e) {
        progress.dismiss();
        showSnackBar(
            "Erro: o tempo para fazer login excedeu o esperado.", context);
      }, test: (e) => e is TimeoutException).catchError((e) {
        progress.dismiss();
        showSnackBar("Erro desconhecido.", context);
      });

      // Passa o token pra API
      bool logged = await _webClient.logged(token.token);
      progress.dismiss();

      // Entra na tela principal
      if (logged) {
        navigator.navigate(context, TelaPrincipal());
      }
    }
  }

  // Mostra uma SnackBar (textinho de aviso)
  void showSnackBar(String text, BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(text),
    ));
  }
}
