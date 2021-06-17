import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../utils/genius_toast.dart';

import '../../http/webclients/signup_webclient.dart';
import '../../components/borderless_input.dart';
import '../../components/floating_button.dart';
import '../../models/user.dart';
import '../../utils/navigator_util.dart';
import '../../utils/application_typography.dart';
import 'signup_username.dart';

class SignUpEmail extends StatefulWidget {
  final User person;

  SignUpEmail(this.person);

  @override
  _SignUpEmailState createState() => _SignUpEmailState();
}

class _SignUpEmailState extends State<SignUpEmail> {
  final navigator = NavigatorUtil();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      borderColor: Theme.of(context).primaryColor,
      indicatorWidget: SpinKitPouringHourglass(
        color: Theme.of(context).primaryColor,
      ),
      child: Builder(
        builder: (context) => Scaffold(
          floatingActionButton: FloatingButton(
            onPressed: () {
              _verifyInput(context);
            },
            icon: Icons.arrow_forward_ios,
            text: 'Prosseguir',
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Align(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 12.0, left: 12),
                  child: Text(
                    'Prazer em te conhecer, ' +
                        widget.person.name +
                        '!\nQual o seu email?',
                    textAlign: TextAlign.center,
                    style: ApplicationTypography.primarySignUpText,
                  ),
                ),
                BorderlessInput(
                  hint: 'Email',
                  controller: _emailController,
                  type: TextInputType.emailAddress,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _verifyInput(BuildContext context) async {
    final _email = _emailController.text.trimLeft();
    final progress = ProgressHUD.of(context);

    progress.show();

    if (_email.isEmpty) {
      progress.dismiss();
      GeniusToast.showToast('Preencha o campo email!');
    } else if (!EmailValidator.validate(_email)) {
      progress.dismiss();
      GeniusToast.showToast('Insira um e-mail válido!');
    } else {
      final _webClient = SignUpWebClient();
      var emailAlreadyExists =
          await _webClient.verifyIfEmailAlreadyExists(_email);

      if (emailAlreadyExists) {
        progress.dismiss();
        GeniusToast.showToast('Ops! Esse email já está cadastrado no Genius.');
      } else {
        progress.dismiss();
        widget.person.setEmail(_email);
        navigator.navigate(context, SignUpUsername(widget.person));
      }
    }
  }
}
