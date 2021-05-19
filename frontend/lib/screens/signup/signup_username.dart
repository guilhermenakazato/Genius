import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:genius/http/webclients/signup_webclient.dart';

import '../../components/borderless_input.dart';
import '../../utils/application_typography.dart';
import '../../components/floating_button.dart';
import '../../utils/application_colors.dart';
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
    var _username = _usernameController.text.trimLeft();
    final progress = ProgressHUD.of(context);
    progress.show();

    if (_username.isEmpty) {
      progress.dismiss();
      _showToast('Insira um nome de usuário!');
    } else if (_username == '@') {
      progress.dismiss();
      _showToast('Insira um nome de usuário!');
    } else if (_username.contains(' ')) {
      progress.dismiss();
      _showToast('Remova os espaços em branco!');
    } else {
      if (!_username.startsWith('@')) {
        _username = '@' + _username;
      }

      final _webClient = SignUpWebClient();
      var usernameAlreadyExists =
          await _webClient.verifyIfUsernameAlreadyExists(_username);

      if (usernameAlreadyExists) {
        progress.dismiss();
        _showToast('Ops! Esse nome de usuário já está cadastrado no Genius.');
      } else {
        progress.dismiss();
        widget.person.setUsername(_username.trimRight());
        _navigator.navigate(context, SignUpPassword(widget.person));
      }
    }
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
