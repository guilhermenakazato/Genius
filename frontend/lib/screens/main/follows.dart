import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../http/webclients/user_webclient.dart';
import '../../models/token.dart';
import '../../utils/application_typography.dart';
import '../../utils/application_colors.dart';
import 'follows/followers.dart';
import 'follows/following.dart';
import '../../models/user.dart';

class Follows extends StatefulWidget {
  final int id;
  final String type;
  final int initialPosition;

  const Follows({
    Key key,
    @required this.id,
    @required this.type,
    this.initialPosition,
  }) : super(key: key);

  @override
  _FollowsState createState() => _FollowsState();
}

class _FollowsState extends State<Follows> with TickerProviderStateMixin {
  TabController _tabController;
  final _tokenObject = Token();
  Future<String> _userData;

  Future<String> _defineHowToGetData() {
    if (widget.type == 'edit') {
      return _getDataByToken();
    } else {
      return _getDataById();
    }
  }

  Future<String> _getDataByToken() async {
    final _webClient = UserWebClient();
    final _token = await _tokenObject.getToken();
    final _user = await _webClient.getUserData(_token);
    return _user;
  }

  Future<String> _getDataById() async {
    final _webClient = UserWebClient();
    final _user = await _webClient.getUserById(widget.id);
    return _user;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: widget.initialPosition);
    _userData = _defineHowToGetData();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: FutureBuilder(
          future: _userData,
          builder: (context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData) {
              final user = User.fromJson(jsonDecode(snapshot.data));

              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  automaticallyImplyLeading: false,
                  elevation: 0,
                  title: Center(child: Text(user.username)),
                  bottom: TabBar(
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
                              '${user.followers.length} seguidores',
                              style: ApplicationTypography.tabBarText,
                            ),
                          ],
                        ),
                      ),
                      Tab(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '${user.following.length} seguindo',
                              style: ApplicationTypography.tabBarText,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                body: TabBarView(
                  controller: _tabController,
                  children: <Widget>[
                    Followers(
                      type: widget.type,
                      id: widget.id,
                      onChangedState: () {
                        setState(() {
                          _userData = _defineHowToGetData();
                        });
                      },
                    ),
                    Following(
                      type: widget.type,
                      id: widget.id,
                      onChangedState: () {
                        setState(() {
                          _userData = _defineHowToGetData();
                        });
                      },
                    ),
                  ],
                ),
              );
            } else {
              return SpinKitFadingCube(color: ApplicationColors.primary);
            }
          }),
    );
  }
}
