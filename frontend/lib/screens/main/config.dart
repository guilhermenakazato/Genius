import 'package:genius/components/list_tile_title.dart';
import 'package:genius/components/mod_list_tile.dart';
import 'package:genius/components/switch_tile.dart';
import 'package:genius/http/webclients/login_webclient.dart';
import 'package:genius/screens/bem_vindo.dart';
import 'package:genius/utils/local_store.dart';
import 'package:genius/utils/navigator_util.dart';

import 'package:flutter/material.dart';

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
          text: "Configurações",
        ),
        SwitchTile(
          icon: Icons.notifications,
          text: "Notificações",
        ),
        ModListTile(
          text: "Editar perfil",
          icon: Icons.edit,
        ),
        ModListTile(text: "Excluir conta", icon: Icons.delete, type: "warning",),
        ModListTile(
          text: "Sair",
          type: "warning",
          icon: Icons.login,
          function: () async {
            _webClient.logout(await localStore.getFromStorage());
            localStore.removeFromStorage();
            navigator.navigateAndRemove(context, BemVindo());
          },
        ),
      ],
    );
  }
}
