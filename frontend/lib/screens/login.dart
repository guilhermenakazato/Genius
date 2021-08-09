import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../utils/genius_toast.dart';
import '../components/borderless_button.dart';
import 'forgot_password.dart';
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

class _LoginStateContent extends StatefulWidget {
  @override
  __LoginStateContentState createState() => __LoginStateContentState();
}

class __LoginStateContentState extends State<_LoginStateContent> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscure = true;
  final _navigator = NavigatorUtil();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          child: Align(
            alignment: FractionalOffset.center,
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      child: Text(
                        'Login',
                        style: ApplicationTypography.loginTitle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Input(
                      controller: _emailController,
                      hint: 'E-mail',
                      type: TextInputType.emailAddress,
                    ),
                    Input(
                      controller: _passwordController,
                      hint: 'Senha',
                      obscure: _obscure,
                      type: TextInputType.text,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Button(
                        text: 'Login',
                        width: 200 - MediaQuery.of(context).size.shortestSide * 0.11,
                        height: 50,
                        onClick: () {
                          _verifyInput(context);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 8, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BorderlessButton(
                    onPressed: () {
                      setState(() {
                        _obscure = !_obscure;
                      });
                    },
                    color: Theme.of(context).primaryColor,
                    text: 'Mostrar\nsenha',
                  ),
                  BorderlessButton(
                    onPressed: () {
                      _navigator.navigate(context, ForgotPassword());
                    },
                    text: 'Esqueci\na senha',
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  void _verifyInput(BuildContext context) {
    final email = _emailController.text;
    final password = _passwordController.text;

    if (email.contains(' ') || password.contains(' ')) {
      GeniusToast.showToast('Preencha os campos acima sem espaços em branco!');
    } else if (email.isEmpty || password.isEmpty) {
      GeniusToast.showToast('Preencha os campos acima!');
    } else {
      _authenticate(email, password, context);
    }
  }

  void _authenticate(String email, String senha, BuildContext context) async {
    final loginWebClient = LoginWebClient();
    final progress = ProgressHUD.of(context);

    progress.show();

    var token = await loginWebClient.login(Auth(email, senha)).catchError((error) {
      progress.dismiss();
      GeniusToast.showToast(error.message);
    }, test: (error) => error is HttpException).catchError((error) {
      progress.dismiss();
      GeniusToast.showToast(
          'Erro: o tempo para fazer login excedeu o esperado.');
    }, test: (error) => error is TimeoutException).catchError((error) {
      progress.dismiss();
      GeniusToast.showToast('Erro desconhecido.');
    });

    var logged = await loginWebClient.userIsLogged(token.token) ?? false;
    progress.dismiss();

    _enterMainScreen(logged, context);
  }

  void _enterMainScreen(bool logged, BuildContext context) {
    if (logged) {
      _navigator.navigateAndRemove(context, MainScreen());
    }
  }
}
