import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:genius/components/gradient_button.dart';
import 'package:genius/components/input_with_animation.dart';
import 'package:genius/components/warning_dialog.dart';
import 'package:genius/http/exceptions/http_exception.dart';
import 'package:genius/http/webclients/login_webclient.dart';
import 'package:genius/http/webclients/user_webclient.dart';
import 'package:genius/models/token.dart';
import 'package:genius/utils/application_colors.dart';
import 'package:genius/utils/genius_toast.dart';
import 'package:genius/utils/navigator_util.dart';

import '../welcome.dart';

class ChangePassword extends StatefulWidget {
  final int userId;

  const ChangePassword({Key key, @required this.userId}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _passwordController = TextEditingController();
  bool hidePassword = true;
  IconData inputIcon = Icons.visibility;
  final _navigator = NavigatorUtil();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ApplicationColors.appBarColor,
          elevation: 0,
          title: Text(
            'Mudar senha',
            overflow: TextOverflow.ellipsis,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
                child: InputWithAnimation(
                  controller: _passwordController,
                  type: TextInputType.text,
                  label: 'Nova senha',
                  suffixIcon: inputIcon,
                  obscure: hidePassword,
                  onSuffixIconPress: () {
                    setState(() {
                      hidePassword = !hidePassword;

                      if (hidePassword) {
                        inputIcon = Icons.visibility;
                      } else {
                        inputIcon = Icons.visibility_off;
                      }
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GradientButton(
                  onPressed: () {
                    _verifyPasswordIsValid(context);
                  },
                  text: 'Enviar',
                  width: 270,
                  height: 50,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _verifyPasswordIsValid(BuildContext context) {
    final password = _passwordController.text.trim();

    if (password.isEmpty) {
      GeniusToast.showToast('Preencha o campo de senha!');
    } else if (password.length <= 7) {
      GeniusToast.showToast('Insira uma senha de pelo menos 8 caracteres!');
    } else if (password.contains(' ')) {
      GeniusToast.showToast('A sua senha não pode conter um espaço em branco!');
    } else {
      _changePassword(context, password);
    }
  }

  Future<dynamic> _changePassword(BuildContext context, String password) async {
    final password = _passwordController.text;
    final _tokenObject = Token();
    final _userWebClient = UserWebClient();
    final _loginWebClient = LoginWebClient();

    return showDialog(
      context: context,
      builder: (
        BuildContext context,
      ) =>
          ProgressHUD(
        borderColor: Theme.of(context).primaryColor,
        indicatorWidget: SpinKitPouringHourglass(
          color: Theme.of(context).primaryColor,
        ),
        child: Builder(
          builder: (context) => WarningDialog(
            content:
                'Tem certeza? Você será redirecionado para a página inicial para fazer login novamente com sua nova senha.',
            title: 'Trocar senha',
            acceptFunction: () async {
              final progress = ProgressHUD.of(context);
              final token = await _tokenObject.getToken();
              progress.show();

              await _userWebClient
                  .changePassword(
                    password,
                    token,
                    widget.userId,
                  )
                  .catchError((error) => {debugPrint(error.toString())},
                      test: (e) => e is HttpException);
              await _loginWebClient.logout(token);
              await _tokenObject.removeToken();

              progress.dismiss();
              _navigator.navigateAndRemove(context, Welcome());
            },
            cancelFunction: () {
              _navigator.goBack(context);
            },
            acceptText: 'Trocar',
          ),
        ),
      ),
    );
  }
}
