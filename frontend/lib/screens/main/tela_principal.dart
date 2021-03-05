import 'dart:convert';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:genius/http/webclients/login_webclient.dart';
import 'package:genius/models/user.dart';
import 'package:genius/screens/main/config.dart';
import 'package:genius/screens/main/feed.dart';
import 'package:genius/screens/main/perfil.dart';
import 'package:genius/screens/main/pesquisa.dart';
import 'package:genius/screens/main/sobre.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:genius/utils/local_store.dart';

class TelaPrincipal extends StatelessWidget {
  final LocalStore localStore = LocalStore();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          User user = User.fromJson(jsonDecode(snapshot.data));
          return _TelaPrincipalContent(
            user: user,
          );
        } else {
          return SpinKitFadingCube(
            color: Theme.of(context).primaryColor,
          );
        }
      },
    );
  }

  Future<String> getData() async {
    final LoginWebClient _webClient = LoginWebClient();
    String token = await localStore.getFromStorage();
    String user = await _webClient.getData(token);
    return user;
  }
}

class _TelaPrincipalContent extends StatefulWidget {
  final User user;
  const _TelaPrincipalContent({Key key, this.user}) : super(key: key);

  @override
  _TelaPrincipalContentState createState() => _TelaPrincipalContentState();
}

class _TelaPrincipalContentState extends State<_TelaPrincipalContent> {
  int pageNumber = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: CurvedNavigationBar(
        height: 48,
        index: 2,
        color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        backgroundColor: Colors.transparent,
        items: <Widget>[
          Icon(Icons.emoji_objects, size: 24, color: Colors.white),
          Icon(Icons.person, size: 24, color: Colors.white),
          Icon(Icons.psychology, size: 24, color: Colors.white),
          Icon(Icons.search, size: 24, color: Colors.white),
          Icon(Icons.app_settings_alt, size: 24, color: Colors.white),
        ],
        onTap: (index) {
          setState(() {
            pageNumber = index;
          });
        },
      ),
      body: _showPage(pageNumber),
    );
  }

  Widget _showPage(int index) {
    List<Widget> _widgetList = <Widget>[
      Sobre(),
      Perfil(user: widget.user),
      Feed(),
      Pesquisa(),
      Config(),
    ];

    return _widgetList.elementAt(index);
  }
}
