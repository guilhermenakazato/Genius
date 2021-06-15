import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:genius/models/tag.dart';
import 'package:genius/screens/main/user_info/achievements_tab.dart';

import '../../screens/main/user_info/projects_tab.dart';
import '../../screens/main/user_info/about_me_tab.dart';
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
import 'user_info/saved_tab.dart';
import 'user_info/surveys_tab.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _ProfileContent();
  }
}

class _ProfileContent extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<_ProfileContent> {
  final _navigator = NavigatorUtil();
  double _myMindPosition = 0.65;
  final _tokenObject = Token();
  Future<String> _userData;

  @override
  void initState() {
    _userData = getData();
    super.initState();
  }

  Future<String> getData() async {
    final _webClient = UserWebClient();
    final _token = await _tokenObject.getToken();
    final _user = await _webClient.getUserData(_token);
    return _user;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _userData,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          final user = User.fromJson(jsonDecode(snapshot.data));

          return Stack(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(height: 50),
                _photoNameAndCity(user),
                _followersEditProfileAndFollowing(user),
                _checkWhichWidgetShouldBeDisplayedBetweenTagsAndNotFoundText(user.tags),
              ],
            ),
            _draggableSheet(user),
          ]);
        } else {
          return SpinKitFadingCube(color: ApplicationColors.primary);
        }
      },
    );
  }

  Widget _draggableSheet(User user) {
    return NotificationListener<DraggableScrollableNotification>(
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
                        left: 15,
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
                            height: MediaQuery.of(context).size.height * 0.738,
                            child: _draggableSheetContent(user),
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
    );
  }

  Widget _draggableSheetContent(User user) {
    return TabBarView(
      children: <Widget>[
        AboutMeTab(
          user: user,
        ),
        ProjectsTab(
          projects: user.projects,
        ),
        AchievementsTab(
          achievements: user.achievements,
        ),
        SurveysTab(
          surveys: user.surveys,
        ),
        SavedTab(
          savedProjects: user.saved,
        )
      ],
    );
  }

  Widget _checkWhichWidgetShouldBeDisplayedBetweenTagsAndNotFoundText(
    List<Tag> tags,
  ) {
    if (tags.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 22.0, left: 4, right: 4),
        child: Text(
          'Você ainda não tem nenhum assunto favorito.',
        ),
      );
    } else {
      return _tagsWidget(tags);
    }
  }

  Widget _tagsWidget(List<Tag> tags) {
    return Container(
      height: 44,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tags.length,
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
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Center(
                    child: Text(
                      tags[index].name,
                      style: ApplicationTypography.profileTags,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _followersEditProfileAndFollowing(User user) {
    return Padding(
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
                  user: user,
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
                    style: ApplicationTypography.numberFollowCaptionProfile,
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
                  user: user,
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
                    style: ApplicationTypography.numberFollowCaptionProfile,
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
              _navigator.navigateAndReload(
                  context,
                  EditOptions(
                    id: user.id,
                  ), () {
                setState(() {
                  _userData = getData();
                });
              });
            },
            text: 'Editar',
            width: 72,
            height: 32,
          ),
        ],
      ),
    );
  }

  Widget _photoNameAndCity(User user) {
    return Row(
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
                  user.username,
                  style: ApplicationTypography.profileName,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.person_pin,
                      color: Colors.white,
                      size: 17,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Container(
                        width: 150,
                        child: Text(
                          user.name,
                          style: ApplicationTypography.profileCity,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
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
