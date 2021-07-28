import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../utils/genius_toast.dart';

import '../../http/webclients/signup_webclient.dart';
import '../../components/borderless_input.dart';
import '../../utils/application_typography.dart';
import '../../components/floating_button.dart';
import '../../utils/navigator_util.dart';
import '../../models/user.dart';
import 'signup_password.dart';

class SignUpUsername extends StatefulWidget {
  final User person;

  SignUpUsername(this.person);

  @override
  _SignUpUsernameState createState() => _SignUpUsernameState();
}

class _SignUpUsernameState extends State<SignUpUsername> {
  final _navigator = NavigatorUtil();
  final _usernameController = TextEditingController();

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
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Transform.translate(
                    offset: Offset(0, -10),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: Container(
                        width: double.infinity,
                        child: Text(
                          'Legal! Agora, digite um\nnome de usuário.',
                          textAlign: TextAlign.center,
                          style: ApplicationTypography.primarySignUpText,
                        ),
                      ),
                    ),
                  ),
                  BorderlessInput(
                    onSubmit: () {
                      _verifyInput(context);
                    },
                    hint: '@nome',
                    controller: _usernameController,
                    type: TextInputType.name,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _verifyInput(BuildContext context) async {
    var username = _usernameController.text.trimLeft();
    final progress = ProgressHUD.of(context);
    progress.show();

    if (username.isEmpty) {
      progress.dismiss();
      GeniusToast.showToast('Insira um nome de usuário!');
    } else if (username == '@') {
      progress.dismiss();
      GeniusToast.showToast('Insira um nome de usuário!');
    } else if (username.contains(' ')) {
      progress.dismiss();
      GeniusToast.showToast('Remova os espaços em branco!');
    } else {
      if (!username.startsWith('@')) {
        username = '@' + username;
      }

      final signupWebClient = SignUpWebClient();
      var usernameAlreadyExists =
          await signupWebClient.verifyIfUsernameAlreadyExists(username);

      if (usernameAlreadyExists) {
        progress.dismiss();
        GeniusToast.showToast('Ops! Esse nome de usuário já está cadastrado no Genius.');
      } else {
        progress.dismiss();
        widget.person.setUsername(username.trimRight());
        _navigator.navigate(context, SignUpPassword(widget.person));
      }
    }
  }
}
