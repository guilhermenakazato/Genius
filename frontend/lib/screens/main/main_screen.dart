import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../../screens/main/config.dart';
import '../../screens/main/feed.dart';
import '../../screens/main/profile.dart';
import '../../screens/main/search.dart';
import '../../screens/main/about.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenContentState createState() => _MainScreenContentState();
}

class _MainScreenContentState extends State<MainScreen> {
  int _pageNumber = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
      Profile(),
      Feed(),
      Search(),
      Config(),
    ];

    return _widgetList.elementAt(index);
  }
}
