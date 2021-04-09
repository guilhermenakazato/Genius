import 'package:flutter/material.dart';

import '../../utils/application_typography.dart';
import '../../utils/application_colors.dart';
import 'follows/followers.dart';
import 'follows/following.dart';

class Follows extends StatefulWidget {
  @override
  _FollowsState createState() => _FollowsState();
}

class _FollowsState extends State<Follows>
    with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
                      Text(
                        '0 seguidores',
                        style: ApplicationTypography.tabBarText
                      ),
                    ],
                  ),
                ),
                Tab(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '0 seguindo',
                        style: ApplicationTypography.tabBarText
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
          Followers(),
          Following(),
        ],
      ),
    );
  }
}
