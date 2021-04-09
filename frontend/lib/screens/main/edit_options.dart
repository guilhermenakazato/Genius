import 'package:flutter/material.dart';

import '../../utils/application_colors.dart';
import 'edit/edit_profile.dart';
import 'edit/edit_projects.dart';
import 'edit/edit_achievements.dart';
import 'edit/edit_surveys.dart';
import '../../utils/application_typography.dart';

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
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            child: SafeArea(
              child: TabBar(
                isScrollable: true,
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
                        Text('Perfil', style: ApplicationTypography.tabBarText),
                      ],
                    ),
                  ),
                  Tab(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.book),
                        Text('Projetos', style: ApplicationTypography.tabBarText),
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
                          style: ApplicationTypography.tabBarText,
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.pageview),
                        Text(
                          'Questionários',
                          style: ApplicationTypography.tabBarText,
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
            EditSurveys()
          ],
        ),
      ),
    );
  }
}
