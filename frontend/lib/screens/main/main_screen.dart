import 'package:flutter/material.dart';

import '../../components/bottom_navbar.dart';
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
      bottomNavigationBar: BottomNavBar(
        onChange: (index) {
          setState(() {
            _pageNumber = index;
          });
        },
        value: _pageNumber,
      ),
      body: _showPage(_pageNumber),
    );
  }

  Widget _showPage(int index) {
    final _widgetList = <Widget>[
      About(),
      Profile(type: 'edit',),
      Feed(),
      Search(),
      Config(),
    ];

    return _widgetList.elementAt(index);
  }
}
