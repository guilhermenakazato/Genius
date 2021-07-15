import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../components/warning_dialog.dart';
import 'send_mail.dart';
import '../../models/user.dart';
import '../../utils/application_colors.dart';
import '../../http/webclients/user_webclient.dart';
import '../../models/token.dart';
import '../../components/config_title.dart';
import '../../components/mod_list_tile.dart';
import '../../components/switch_tile.dart';
import '../../http/webclients/login_webclient.dart';
import '../../screens/welcome.dart';
import '../../utils/navigator_util.dart';

class Config extends StatefulWidget {
  @override
  State<Config> createState() => _ConfigState();
}

class _ConfigState extends State<Config> {
  final _tokenObject = Token();
  final _navigator = NavigatorUtil();
  final _loginWebClient = LoginWebClient();
  final _userWebClient = UserWebClient();
  Future<String> _userData;

  @override
  void initState() {
    super.initState();
    _userData = _getDataByToken();
  }

  Future<String> _getDataByToken() async {
    final _webClient = UserWebClient();
    final _token = await _tokenObject.getToken();
    final _user = await _webClient.getUserData(_token);
    return _user;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _userData,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          final user = User.fromJson(jsonDecode(snapshot.data));

          return ProgressHUD(
            borderColor: Theme.of(context).primaryColor,
            indicatorWidget: SpinKitPouringHourglass(
              color: Theme.of(context).primaryColor,
            ),
            child: Builder(
              builder: (context) => Column(
                children: <Widget>[
                  Container(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 5.0,
                      top: 10,
                      bottom: 7,
                    ),
                    child: ConfigTitle(
                      text: 'Configurações',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        SwitchTile(
                          icon: Icons.notifications,
                          text: 'Notificações',
                          position: 'top',
                        ),
                        ModListTile(
                          text: 'Contatar os desenvolvedores',
                          icon: Icons.email,
                          position: 'bottom',
                          onClick: () {
                            _navigator.navigate(context, SendMail());
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        ModListTile(
                          text: 'Excluir conta',
                          icon: Icons.delete,
                          type: 'warning',
                          position: 'top',
                          onClick: () {
                            displayDialog(context, user.id);
                          },
                        ),
                        ModListTile(
                          text: 'Sair',
                          type: 'warning',
                          icon: Icons.login,
                          position: 'bottom',
                          onClick: () {
                            logoutUser(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return SpinKitFadingCube(color: ApplicationColors.primary);
        }
      },
    );
  }

  void logout(BuildContext context) async {
    final progress = ProgressHUD.of(context);
    progress.show();

    await _loginWebClient.logout(await _tokenObject.getToken());
    await _tokenObject.removeToken();

    progress.dismiss();
    _navigator.navigateAndRemove(context, Welcome());
  }

  Future<void> deleteUser(BuildContext context, int id) async {
    final progress = ProgressHUD.of(context);
    final token = await _tokenObject.getToken();
    progress.show();

    await _userWebClient.deleteUser(id, token);
    progress.dismiss();
  }

  Future<dynamic> displayDialog(BuildContext context, int id) {
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
                'Caso exclua, não poderá recuperar seus dados. Além disso, se tiver um projeto com apenas um participante, ele será deletado também.',
            title: 'Excluir conta?',
            acceptFunction: () {
              deleteUser(context, id);
              _navigator.navigateAndRemove(context, Welcome());
            },
            cancelFunction: () {
              _navigator.goBack(context);
            },
            acceptText: 'Excluir',
          ),
        ),
      ),
    );
  }

  Future<dynamic> logoutUser(BuildContext context) async {
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
            content: 'Deseja realmente sair? Sentiremos sua falta!',
            title: 'Sair da conta',
            acceptFunction: () {
              logout(context);
            },
            cancelFunction: () {
              _navigator.goBack(context);
            },
            acceptText: 'Sair',
          ),
        ),
      ),
    );
  }
}
