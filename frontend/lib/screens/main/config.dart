import 'package:Genius/components/list_tile_title.dart';
import 'package:Genius/components/mod_list_tile.dart';
import 'package:Genius/components/switch_tile.dart';
import 'package:Genius/screens/bem_vindo.dart';
import 'package:Genius/utils/local_store.dart';
import 'package:Genius/utils/navigator_util.dart';

import 'package:flutter/material.dart';

class Config extends StatelessWidget {
  final LocalStore localStore = LocalStore();
  final NavigatorUtil navigator = NavigatorUtil();

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
        ModListTile(
          text: "Sair",
          icon: Icons.login,
          function: () {
            localStore.removeFromStorage();
            navigator.navigateAndRemove(context, BemVindo());
          },
        ),
      ],
    );
  }
}
