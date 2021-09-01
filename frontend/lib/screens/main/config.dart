import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../components/switch_tile.dart';
import '../../screens/main/change_password.dart';
import '../../utils/notifications.dart';

import '../../components/warning_dialog.dart';
import 'send_mail.dart';
import '../../models/user.dart';
import '../../utils/application_colors.dart';
import '../../http/webclients/user_webclient.dart';
import '../../models/jwt_token.dart';
import '../../components/config_title.dart';
import '../../components/mod_list_tile.dart';
import '../../http/webclients/login_webclient.dart';
import '../../screens/welcome.dart';
import '../../utils/navigator_util.dart';

class Config extends StatefulWidget {
  @override
  State<Config> createState() => _ConfigState();
}

class _ConfigState extends State<Config> {
  final _tokenObject = JwtToken();
  final _navigator = NavigatorUtil();
  final _loginWebClient = LoginWebClient();
  final _userWebClient = UserWebClient();

  Future<List<dynamic>> _getConfigScreenData() async {
    return Future.wait([_getNotificationPreference(), _getDataByToken()]);
  }

  Future<bool> _getNotificationPreference() async {
    return await Notifications.getNotificationPreference();
  }

  Future<String> _getDataByToken() async {
    final userWebClient = UserWebClient();
    final token = await _tokenObject.getToken();
    final user = await userWebClient.getUserData(token);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getConfigScreenData(),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          final notificationIsOn = snapshot.data[0];
          final user = User.fromJson(jsonDecode(snapshot.data[1]));

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
                          initialValue: notificationIsOn,
                          onChangedState: (notificationIsOn) async {
                            await _changeNotificationPreference(
                              notificationIsOn,
                              context,
                            );
                          },
                        ),
                        ModListTile(
                          text: 'Modificar sua senha',
                          icon: Icons.lock,
                          onClick: () {
                            _navigator.navigate(
                              context,
                              ChangePassword(
                                userId: user.id,
                              ),
                            );
                          },
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
                            _logoutUser(context);
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

  Future<void> _logout(BuildContext context) async {
    final progress = ProgressHUD.of(context);
    progress.show();

    await _loginWebClient.logout(await _tokenObject.getToken());
    await _tokenObject.eraseToken();

    progress.dismiss();
    _navigator.navigateAndRemove(context, Welcome());
  }

  Future<void> _deleteUser(BuildContext context, int id) async {
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
              _deleteUser(context, id);
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

  Future<dynamic> _logoutUser(BuildContext context) async {
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
              _logout(context);
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

  Future<void> _changeNotificationPreference(
    bool notificationIsOn,
    BuildContext context,
  ) async {
    final progress = ProgressHUD.of(context);
    progress.show();

    await Notifications.setNotificationPreference(notificationIsOn);

    progress.dismiss();
  }
}
