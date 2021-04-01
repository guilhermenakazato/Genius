import 'package:flutter/material.dart';

import '../../components/list_tile_title.dart';
import '../../components/mod_list_tile.dart';
import '../../components/switch_tile.dart';
import '../../http/webclients/login_webclient.dart';
import '../../screens/welcome.dart';
import '../../utils/local_store.dart';
import '../../utils/navigator_util.dart';

class Config extends StatelessWidget {
  final LocalStore localStore = LocalStore();
  final NavigatorUtil navigator = NavigatorUtil();
  final LoginWebClient _webClient = LoginWebClient();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 40),
        ),
        ListTileTitle(
          text: 'Configurações',
        ),
        SwitchTile(
          icon: Icons.notifications,
          text: 'Notificações',
        ),
        ModListTile(
          text: 'Editar perfil',
          icon: Icons.edit,
        ),
        ModListTile(text: 'Excluir conta', icon: Icons.delete, type: 'warning',),
        ModListTile(
          text: 'Sair',
          type: 'warning',
          icon: Icons.login,
          function: () async {
            _webClient.logout(await localStore.getToken());
            localStore.removeToken();
            navigator.navigateAndRemove(context, Welcome());
          },
        ),
      ],
    );
  }
}
