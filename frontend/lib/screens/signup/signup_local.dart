import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';
import '../../utils/genius_toast.dart';

import '../../components/borderless_input.dart';
import '../../components/gradient_button.dart';
import '../../http/exceptions/http_exception.dart';
import '../../http/webclients/signup_webclient.dart';
import '../../models/user.dart';
import '../../utils/navigator_util.dart';
import '../login.dart';
import '../../utils/application_typography.dart';

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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
            style: ApplicationTypography.primarySignUpText,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: BorderlessInput(
              onSubmit: () {
                _verifyInput(context);
              },
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
            width: 75.w,
            height: 7.5.h,
          ),
        ],
      ),
    );
  }

  void _verifyInput(BuildContext context) {
    final local = _localController.text.trimLeft();

    if (local.isEmpty) {
      GeniusToast.showToast('Preencha o campo de local!');
    } else {
      person.setLocal(local.trimRight());
      _realizeSignUp(person, context);
    }
  }

  void _realizeSignUp(User person, BuildContext context) async {
    final signupWebClient = SignUpWebClient();
    final progress = ProgressHUD.of(context);
    final navigator = NavigatorUtil();
    var signed = false;

    progress.show();
    final deviceToken = await FirebaseMessaging.instance.getToken();
    person.setDeviceToken(deviceToken);

    signed = await signupWebClient.signup(person).catchError((error) {
      GeniusToast.showToast(error.message);
    }, test: (error) => error is HttpException).catchError((error) {
      GeniusToast.showToast(
        'Erro: o tempo para fazer o cadastro excedeu o esperado.',
      );
    }, test: (error) => error is TimeoutException).catchError((error) {
      GeniusToast.showToast(
        'Erro desconhecido.',
      );
    }, test: (error) => error is Exception);

    progress.dismiss();
    if (signed) {
      navigator.navigateAndReplace(context, Login());
    }
  }
}
