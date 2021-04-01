import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../components/borderless_input.dart';
import '../../components/gradient_button.dart';
import '../../http/exceptions/http_exception.dart';
import '../../http/webclients/signup_webclient.dart';
import '../../models/user.dart';
import '../../utils/navigator_util.dart';
import '../login.dart';

class SignUpLocal extends StatefulWidget {
  final User person;

  SignUpLocal(this.person);

  @override
  _SignUpLocalState createState() => _SignUpLocalState();
}

class _SignUpLocalState extends State<SignUpLocal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _SignUpLocalBody(widget.person),
    );
  }
}

class _SignUpLocalBody extends StatelessWidget {
  final User person;

  _SignUpLocalBody(this.person);

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      borderColor: Theme.of(context).primaryColor,
      indicatorWidget: SpinKitPouringHourglass(
        color: Theme.of(context).primaryColor,
      ),
      child: Builder(builder: (buildContext) => _SignUpLocalContent(person)),
    );
  }
}

class _SignUpLocalContent extends StatelessWidget {
  final TextEditingController _localController = TextEditingController();
  final User person;

  _SignUpLocalContent(this.person);

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'E, por fim, aonde você mora?',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w900,
              fontSize: 20,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: BorderlessInput(
              hint: 'Cidade',
              controller: _localController,
              type: TextInputType.streetAddress,
            ),
          ),
          GradientButton(
            onPressed: () {
              verifyInput(context);
            },
            text: 'Finalizar cadastro'.toUpperCase(),
          ),
        ],
      ),
    );
  }

  void verifyInput(BuildContext context) {
    final local = _localController.text.trimLeft();

    if (local.isEmpty) {
      showSnackBar('Preencha o campo de local!', context);
    } else {
      person.setLocal(local.trimRight());
      realizeSignUp(person, context);
    }
  }

  void realizeSignUp(User person, BuildContext context) async {
    final _webClient = SignUpWebClient();
    final progress = ProgressHUD.of(context);
    final navigator = NavigatorUtil();
    var signed = false;

    progress.show();
    signed = await _webClient.signup(person).catchError((error) {
      showSnackBar(error.message, context);
    }, test: (error) => error is HttpException).catchError((error) {
      showSnackBar(
        'Erro: o tempo para fazer login excedeu o esperado.',
        context,
      );
    }, test: (error) => error is TimeoutException).catchError((error) {
      showSnackBar(
        'Erro desconhecido.',
        context,
      );
    }, test: (error) => error is Exception);

    progress.dismiss();
    if (signed) {
      navigator.navigateAndReplace(context, Login());
    }
  }

  void showSnackBar(String text, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
    ));
  }
}
