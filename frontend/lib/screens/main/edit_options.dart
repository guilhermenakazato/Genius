import 'package:flutter/material.dart';

import '../../utils/application_colors.dart';
import 'edit/edit_profile.dart';
import 'edit/edit_projects.dart';
import 'edit/edit_conquistas.dart';

// TODO: tipografia
class EditOptions extends StatefulWidget {
  @override
  _EditOptionsState createState() => _EditOptionsState();
}

class _EditOptionsState extends State<EditOptions>
    with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          child: SafeArea(
            child: TabBar(
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: ApplicationColors.tabBarIndicatorColor,
              ),
              tabs: <Widget>[
                Tab(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.person),
                      Text(
                        'Perfil',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Tab(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.book),
                      Text(
                        'Projetos',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Tab(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.emoji_events),
                      Text(
                        'Conquistas',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          EditProfile(),
          EditProjects(),
          EditConquistas(),
        ],
      ),
    );
  }
}
