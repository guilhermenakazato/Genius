import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../../http/webclients/login_webclient.dart';
import '../../models/user.dart';
import '../../screens/main/config.dart';
import '../../screens/main/feed.dart';
import '../../screens/main/profile.dart';
import '../../screens/main/search.dart';
import '../../screens/main/about.dart';
import '../../utils/local_store.dart';

class MainScreen extends StatelessWidget {
  final LocalStore _localStore = LocalStore();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          final user = User.fromJson(jsonDecode(snapshot.data));
          return _MainScreenContent(
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
    final _webClient = LoginWebClient();
    final _token = await _localStore.getToken();
    final _user = await _webClient.getUserData(_token);
    return _user;
  }
}

class _MainScreenContent extends StatefulWidget {
  final User user;
  const _MainScreenContent({Key key, this.user}) : super(key: key);

  @override
  _MainScreenContentState createState() => _MainScreenContentState();
}

class _MainScreenContentState extends State<_MainScreenContent> {
  int _pageNumber = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
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
            _pageNumber = index;
          });
        },
      ),
      body: _showPage(_pageNumber),
    );
  }

  Widget _showPage(int index) {
    final _widgetList = <Widget>[
      About(),
      Profile(user: widget.user),
      Feed(),
      Search(),
      Config(),
    ];

    return _widgetList.elementAt(index);
  }
}
