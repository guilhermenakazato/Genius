import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'main/main_screen.dart';
import '../components/button.dart';
import '../components/input.dart';
import '../http/exceptions/http_exception.dart';
import '../http/webclients/login_webclient.dart';
import '../models/auth.dart';
import '../utils/navigator_util.dart';
import '../utils/application_typography.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                    'Login',
                    style: ApplicationTypography.loginTitle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Input(
              controller: _emailController,
              hint: 'E-mail',
              type: TextInputType.emailAddress
            ),
            Input(
              controller: _passwordController,
              hint: 'Senha',
              obscure: true,
              type: TextInputType.text,
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Button(
                text: 'Login',
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
    final email = _emailController.text;
    final senha = _passwordController.text;

    if (email.contains(' ') || senha.contains(' ')) {
      showSnackBar('Preencha os campos acima sem espaços em branco!', context);
    } else if (email.isEmpty || senha.isEmpty) {
      showSnackBar('Preencha os campos acima!', context);
    } else {
      authenticate(email, senha, context);
    }
  }

  void authenticate(String email, String senha, BuildContext context) async {
    final _webClient = LoginWebClient();
    final progress = ProgressHUD.of(context);

    progress.show();

    var token = await _webClient.login(Auth(email, senha)).catchError((error) {
      progress.dismiss();
      showSnackBar(error.message, context);
    }, test: (error) => error is HttpException).catchError((error) {
      progress.dismiss();
      showSnackBar(
          'Erro: o tempo para fazer login excedeu o esperado.', context);
    }, test: (error) => error is TimeoutException).catchError((error) {
      progress.dismiss();
      showSnackBar('Erro desconhecido.', context);
    });

    var logged = await _webClient.userIsLogged(token.token);
    progress.dismiss();

    enterMainScreen(logged, context);
  }

  void enterMainScreen(bool logged, BuildContext context) {
    final navigator = NavigatorUtil();

    if (logged) {
      navigator.navigateAndRemove(context, MainScreen());
    }
  }

  void showSnackBar(String text, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
    ));
  }
}
