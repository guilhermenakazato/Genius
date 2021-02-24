import 'dart:async';

import 'package:genius/components/button.dart';
import 'package:genius/components/input.dart';
import 'package:genius/http/exceptions/http_exception.dart';
import 'package:genius/http/webclients/login_webclient.dart';
import 'package:genius/models/auth.dart';
import 'package:genius/models/token.dart';
import 'package:genius/utils/navigator_util.dart';
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
      borderColor: Theme.of(context).primaryColor,
      indicatorWidget: SpinKitPouringHourglass(
        color: Theme.of(context).primaryColor,
      ),
      child: Builder(
        builder: (context) => _LoginStateContent(),
      ),
    );
  }
}

class _LoginStateContent extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                    "Login",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 60,
                      fontWeight: FontWeight.w900,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Input(
              controller: _emailController,
              hint: "E-mail",
              type: TextInputType.emailAddress
            ),
            Input(
              controller: _passwordController,
              hint: "Senha",
              obscure: true,
              type: TextInputType.text,
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

  void handleLogin(BuildContext context) {
    verifyInput(context);
  }

  void verifyInput(BuildContext context) {
    final String email = _emailController.text;
    final String senha = _passwordController.text;

    // talvez tenham mais exceções, mas por enquanto é isso
    if (email.contains(" ") || senha.contains(" ")) {
      showSnackBar("Preencha os campos acima sem espaços em branco!", context);
    } else if (email.isEmpty || senha.isEmpty) {
      showSnackBar("Preencha os campos acima!", context);
    } else {
      authenticate(email, senha, context);
    }
  }

  void authenticate(String email, String senha, BuildContext context) async {
    final LoginWebClient _webClient = LoginWebClient();
    final progress = ProgressHUD.of(context);

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
      debugPrint(e.toString());
    });

    // Passa o token pra API 
    bool logged = await _webClient.logged(token.token);
    progress.dismiss();

    enter(logged, context);
  }

  void enter(bool logged, BuildContext context) {
    final NavigatorUtil navigator = NavigatorUtil();

    // Entra na tela principal
    if (logged) {
      navigator.navigateAndRemove(context, TelaPrincipal());
    }
  }

  // Mostra uma SnackBar (textinho de aviso)
  void showSnackBar(String text, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
    ));
  }
}
