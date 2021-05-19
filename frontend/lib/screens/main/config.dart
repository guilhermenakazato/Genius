import 'package:flutter/material.dart';
import 'package:genius/models/token.dart';

import '../../components/config_title.dart';
import '../../components/mod_list_tile.dart';
import '../../components/switch_tile.dart';
import '../../http/webclients/login_webclient.dart';
import '../../screens/welcome.dart';
import '../../utils/navigator_util.dart';

class Config extends StatelessWidget {
  final _tokenObject = Token();
  final _navigator = NavigatorUtil();
  final _webClient = LoginWebClient();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 40,
        ),
        ConfigTitle(
          text: 'Configurações',
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: <Widget>[
            SwitchTile(
              icon: Icons.notifications,
              text: 'Notificações',
            ),
            ModListTile(
              text: 'Excluir conta',
              icon: Icons.delete,
              type: 'warning',
            ),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: <Widget>[
            ModListTile(
              text: 'Sair',
              type: 'warning',
              icon: Icons.login,
              function: () async {
                _webClient.logout(await _tokenObject.getToken());
                _tokenObject.removeToken();
                _navigator.navigateAndRemove(context, Welcome());
              },
            ),
          ]),
        ),
      ],
    );
  }
}
