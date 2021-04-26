import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../http/webclients/user_webclient.dart';
import '../../models/token.dart';
import '../../utils/application_colors.dart';
import '../../utils/navigator_util.dart';
import '../../components/gradient_button.dart';
import '../../components/circle_tab_indicator.dart';
import '../../models/user.dart';
import '../../utils/application_typography.dart';
import 'edit_options.dart';
import 'follows.dart';

class Profile extends StatelessWidget {
  final _tokenObject = Token();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          final user = User.fromJson(jsonDecode(snapshot.data));

          return _ProfileContent(
            user: user,
          );
        } else {
          return SpinKitFadingCube(color: ApplicationColors.primary);
        }
      },
    );
  }

  Future<String> getData() async {
    final _webClient = UserWebClient();
    final _token = await _tokenObject.getToken();
    final _user = await _webClient.getUserData(_token);
    return _user;
  }
}

class _ProfileContent extends StatefulWidget {
  final User user;

  _ProfileContent({Key key, this.user}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<_ProfileContent> {
  final _tags = ['girls', 'flutter', 'matemática', 'ciências da saúde'];
  final _navigator = NavigatorUtil();
  double _myMindPosition = 0.65;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 28.0),
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/sem-foto.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 170,
                      child: Text(
                        widget.user.username,
                        style: ApplicationTypography.profileName,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.location_on,
                            color: Colors.white,
                            size: 17,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              widget.user.local,
                              style: ApplicationTypography.profileCity,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 30.0,
              left: 30.0,
              top: 8,
              bottom: 12,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    _navigator.navigate(
                      context,
                      Follows(
                        user: widget.user,
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '17K',
                          style: ApplicationTypography.numberFollowProfile,
                        ),
                        Text(
                          'seguidores',
                          style:
                              ApplicationTypography.numberFollowCaptionProfile,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  width: 0.2,
                  height: 22,
                ),
                InkWell(
                  onTap: () {
                    _navigator.navigate(
                      context,
                      Follows(
                        user: widget.user,
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '387',
                          style: ApplicationTypography.numberFollowProfile,
                        ),
                        Text(
                          'seguindo',
                          style:
                              ApplicationTypography.numberFollowCaptionProfile,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  width: 0.2,
                  height: 22,
                ),
                GradientButton(
                  onPressed: () {
                    _navigator.navigate(
                        context,
                        EditOptions(
                          user: widget.user,
                        ));
                  },
                  text: 'Editar',
                  width: 72,
                  height: 32,
                ),
              ],
            ),
          ),
          Container(
            height: 44,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _tags.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 5.0, left: 5),
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: ApplicationColors.cardColor,
                          width: 3,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 13.0,
                          bottom: 5,
                          right: 20,
                          left: 20,
                        ),
                        child: Text(
                          _tags[index],
                          style: ApplicationTypography.profileTags,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      NotificationListener<DraggableScrollableNotification>(
        onNotification: (notification) {
          setState(() {
            _myMindPosition = notification.extent;
          });
          return true;
        },
        child: DraggableScrollableSheet(
          initialChildSize: 0.65,
          minChildSize: 0.62,
          builder: (context, scrollController) {
            return Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                color: ApplicationColors.cardColor,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(34),
                ),
              ),
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overscroll) {
                  overscroll.disallowGlow();
                  return true;
                },
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Icon(
                            _determineIconBasedOnMyMindPosition(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 25,
                          left: 25,
                        ),
                        child: Text(
                          'MY MIND',
                          style: ApplicationTypography.profileInfoTitle,
                        ),
                      ),
                      DefaultTabController(
                        length: 5,
                        child: Column(
                          children: [
                            TabBar(
                              indicator: CircleTabIndicator(
                                color: Colors.white,
                                radius: 3,
                              ),
                              isScrollable: true,
                              tabs: _tabs(),
                            ),
                            Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.738,
                              child: TabBarView(
                                children: <Widget>[
                                  SingleChildScrollView(
                                    child: Column(
                                      children: <Widget>[
                                        for (int i = 0; i < 100; i++)
                                          Text('oi'),
                                      ],
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    child: Column(
                                      children: <Widget>[
                                        for (int i = 0; i < 100; i++)
                                          Text('oi'),
                                      ],
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    child: Column(
                                      children: <Widget>[
                                        for (int i = 0; i < 100; i++)
                                          Text('oi'),
                                      ],
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    child: Column(
                                      children: <Widget>[
                                        for (int i = 0; i < 100; i++)
                                          Text('oi'),
                                      ],
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    child: Column(
                                      children: <Widget>[
                                        for (int i = 0; i < 100; i++)
                                          Text('oi'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    ]);
  }

  IconData _determineIconBasedOnMyMindPosition() {
    if (_myMindPosition > 0.65) {
      return Icons.expand_more;
    } else {
      return Icons.expand_less;
    }
  }

  List<Tab> _tabs() {
    return [
      Tab(
        child: Text(
          'Sobre mim',
          style: ApplicationTypography.profileInfoPageTitle,
        ),
      ),
      Tab(
        child: Text(
          'Meus projetos',
          style: ApplicationTypography.profileInfoPageTitle,
        ),
      ),
      Tab(
        child: Text(
          'Conquistas',
          style: ApplicationTypography.profileInfoPageTitle,
        ),
      ),
      Tab(
        child: Text(
          'Questionários',
          style: ApplicationTypography.profileInfoPageTitle,
        ),
      ),
      Tab(
        child: Text(
          'Salvos',
          style: ApplicationTypography.profileInfoPageTitle,
        ),
      ),
    ];
  }
}
