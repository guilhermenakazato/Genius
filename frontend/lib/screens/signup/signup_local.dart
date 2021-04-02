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
  final _localController = TextEditingController();
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
              _verifyInput(context);
            },
            text: 'Finalizar cadastro'.toUpperCase(),
          ),
        ],
      ),
    );
  }

  void _verifyInput(BuildContext context) {
    final _local = _localController.text.trimLeft();

    if (_local.isEmpty) {
      _showSnackBar('Preencha o campo de local!', context);
    } else {
      person.setLocal(_local.trimRight());
      _realizeSignUp(person, context);
    }
  }

  void _realizeSignUp(User person, BuildContext context) async {
    final _webClient = SignUpWebClient();
    final _progress = ProgressHUD.of(context);
    final _navigator = NavigatorUtil();
    var _signed = false;

    _progress.show();
    _signed = await _webClient.signup(person).catchError((error) {
      _showSnackBar(error.message, context);
    }, test: (error) => error is HttpException).catchError((error) {
      _showSnackBar(
        'Erro: o tempo para fazer login excedeu o esperado.',
        context,
      );
    }, test: (error) => error is TimeoutException).catchError((error) {
      _showSnackBar(
        'Erro desconhecido.',
        context,
      );
    }, test: (error) => error is Exception);

    _progress.dismiss();
    if (_signed) {
      _navigator.navigateAndReplace(context, Login());
    }
  }

  void _showSnackBar(String text, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
    ));
  }
}
