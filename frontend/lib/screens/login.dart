import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../components/borderless_button.dart';
import '../utils/application_colors.dart';
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
                height: 400,
                child: Column(
                  children: <Widget>[
                    Padding(
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
                    Input(
                        controller: _emailController,
                        hint: 'E-mail',
                        type: TextInputType.emailAddress),
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
                    onPressed: () {},
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

  void handleLogin(BuildContext context) {
    verifyInput(context);
  }

  void verifyInput(BuildContext context) {
    final email = _emailController.text;
    final senha = _passwordController.text;

    if (email.contains(' ') || senha.contains(' ')) {
      _showToast('Preencha os campos acima sem espaços em branco!');
    } else if (email.isEmpty || senha.isEmpty) {
      _showToast('Preencha os campos acima!');
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
      _showToast(error.message);
    }, test: (error) => error is HttpException).catchError((error) {
      progress.dismiss();
      _showToast('Erro: o tempo para fazer login excedeu o esperado.');
    }, test: (error) => error is TimeoutException).catchError((error) {
      progress.dismiss();
      _showToast('Erro desconhecido.');
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

  void _showToast(String text) {
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: ApplicationColors.toastColor,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }
}
