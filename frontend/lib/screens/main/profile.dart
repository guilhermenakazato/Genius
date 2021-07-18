import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:genius/http/webclients/notification_webclient.dart';

import '../../utils/genius_toast.dart';
import '../../models/tag.dart';
import '../../screens/main/user_info/achievements_tab.dart';
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
  final String type;
  final int id;

  const Profile({Key key, @required this.type, @required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _ProfileContent(type: type, id: id);
  }
}

class _ProfileContent extends StatefulWidget {
  final String type;
  final int id;

  const _ProfileContent({Key key, @required this.type, @required this.id})
      : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<_ProfileContent> {
  final _navigator = NavigatorUtil();
  double _myMindPosition = 0.65;
  final _tokenObject = Token();
  Future<List<dynamic>> _profileData;
  bool alreadyFollowing = false;

  final founderColors = [
    ApplicationColors.profileNameColor,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];

  @override
  void initState() {
    super.initState();
    _profileData = _defineHowToGetData();
  }

  Future<List<dynamic>> _defineHowToGetData() {
    if (widget.type == 'edit') {
      return Future.wait(
        [
          _getDataByToken(),
        ],
      );
    } else {
      return Future.wait(
        [
          _getDataById(),
          _getDataByToken(),
        ],
      );
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
    final token = await _tokenObject.getToken();

    final _user = await _webClient.getUserById(widget.id, token);
    return _user;
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      borderColor: Theme.of(context).primaryColor,
      indicatorWidget: SpinKitPouringHourglass(
        color: Theme.of(context).primaryColor,
      ),
      child: Builder(builder: (context) {
        return FutureBuilder(
          future: _profileData,
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.hasData) {
              final user = User.fromJson(jsonDecode(snapshot.data[0]));
              var follower = User();

              if (widget.type != 'edit') {
                follower = User.fromJson(jsonDecode(snapshot.data[1]));
                _verifyIfUserIsAlreadyBeingFollowed(user, follower);
              }

              return Scaffold(
                body: Stack(children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(height: 50),
                      _nameAndCity(user),
                      _followersEditProfileAndFollowing(
                          user, context, follower),
                      _checkWhichWidgetShouldBeDisplayedBetweenTagsAndNotFoundText(
                        user.tags,
                      ),
                    ],
                  ),
                  _draggableSheet(user),
                ]),
              );
            } else {
              return SpinKitFadingCube(color: ApplicationColors.primary);
            }
          },
        );
      }),
    );
  }

  void _verifyIfUserIsAlreadyBeingFollowed(User user, User follower) {
    if (follower.following.map((item) => item.id).contains(user.id)) {
      alreadyFollowing = true;
    } else {
      alreadyFollowing = false;
    }
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
        initialChildSize: 0.7,
        minChildSize: 0.68,
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
                        _determineMindText(),
                        style: ApplicationTypography.profileInfoTitle,
                      ),
                    ),
                    DefaultTabController(
                      length: _tabs().length,
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
    var tabs = [
      AboutMeTab(
        user: user,
      ),
      ProjectsTab(
        projects: user.projects,
        notFoundText: _determineProjectsNotFoundText(),
        onChangedState: () {
          setState(() {
            _profileData = _defineHowToGetData();
          });
        },
      ),
      AchievementsTab(
        achievements: user.achievements,
        notFoundText: _determineAchievementsNotFoundText(),
      ),
      SurveysTab(
        surveys: user.surveys,
        notFoundText: _determineSurveysNotFoundText(),
      ),
    ];

    if (widget.type == 'edit') {
      tabs.add(
        SavedTab(
          savedProjects: user.saved,
          onChangedState: () {
            setState(() {
              _profileData = _defineHowToGetData();
            });
          },
        ),
      );
    }

    return TabBarView(children: tabs);
  }

  Widget _checkWhichWidgetShouldBeDisplayedBetweenTagsAndNotFoundText(
    List<Tag> tags,
  ) {
    if (tags.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 4, right: 4),
        child: Text(
          _determineNoFavoritesText(),
          textAlign: TextAlign.center,
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

  Widget _followersEditProfileAndFollowing(
      User user, BuildContext context, User follower) {
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
              _navigator.navigateAndReload(
                context,
                Follows(
                  type: widget.type,
                  id: widget.id,
                  initialPosition: 0,
                ),
                () {
                  setState(() {
                    _profileData = _defineHowToGetData();
                  });
                },
              );
            },
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    user.followers.length.toString(),
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
              _navigator.navigateAndReload(
                context,
                Follows(
                  type: widget.type,
                  id: widget.id,
                  initialPosition: 1,
                ),
                () {
                  setState(() {
                    _profileData = _defineHowToGetData();
                  });
                },
              );
            },
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    user.following.length.toString(),
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
          ..._determineIfButtonShouldAppear(user, context, follower),
        ],
      ),
    );
  }

  List<Widget> _determineIfButtonShouldAppear(
      User user, BuildContext context, User follower) {
    if (widget.type == 'edit') {
      return _decoratedButton(user, context);
    } else {
      if (follower.id != widget.id) {
        return _decoratedButton(user, context, follower: follower);
      } else {
        return [];
      }
    }
  }

  List<Widget> _decoratedButton(User user, BuildContext context,
      {User follower}) {
    return [
      Container(
        color: Colors.white,
        width: 0.2,
        height: 22,
      ),
      _button(
        () {
          _determineFunctionToExecuteOnButton(user, context, follower);
        },
        _determineButtonText(),
      ),
    ];
  }

  void _determineFunctionToExecuteOnButton(
      User user, BuildContext context, User follower) {
    if (widget.type == 'edit') {
      _navigator.navigateAndReload(
          context,
          EditOptions(
            id: user.id,
          ), () {
        setState(() {
          _profileData = _defineHowToGetData();
        });
      });
    } else {
      if (alreadyFollowing) {
        unfollow(user, follower, context);
      } else {
        follow(user, follower, context);
      }
    }
  }

  void follow(User user, User follower, BuildContext context) async {
    final _webClient = UserWebClient();
    final _notificationWebClient = NotificationWebClient();
    var followed = true;
    final progress = ProgressHUD.of(context);
    final token = await _tokenObject.getToken();
    final deviceToken = user.deviceToken;

    progress.show();

    await _webClient.follow(user.id, follower.id, token).catchError((error) {
      followed = false;
      progress.dismiss();
      GeniusToast.showToast('Não foi possível seguir o usuário.');
    }, test: (error) => error is TimeoutException);

    if (followed) {
      progress.dismiss();
      follower.following.add(user);

      setState(() {
        _profileData = _defineHowToGetData();
      });

      if (deviceToken != null) {
        await _notificationWebClient.sendFollowNotification(
          deviceToken,
          follower.username,
        );
      }
    }
  }

  void unfollow(User user, User follower, BuildContext context) async {
    final _webClient = UserWebClient();
    var unfollowed = true;
    final progress = ProgressHUD.of(context);
    final token = await _tokenObject.getToken();

    progress.show();

    await _webClient.unfollow(user.id, follower.id, false, token).catchError(
        (error) {
      unfollowed = false;
      progress.dismiss();
      GeniusToast.showToast('Não foi possível deixar de seguir o usuário.');
    }, test: (error) => error is TimeoutException);

    if (unfollowed) {
      progress.dismiss();
      follower.following.removeWhere((element) => element.id == user.id);

      setState(() {
        _profileData = _defineHowToGetData();
      });
    }
  }

  Widget _nameAndCity(User user) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Align(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _determineStyle(user),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 250,
                      child: Text(
                        user.name,
                        textAlign: TextAlign.center,
                        style: ApplicationTypography.profileCity,
                        overflow: TextOverflow.ellipsis,
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

  Widget _determineStyle(User user) {
    if (user.verified == 'founder') {
      return Container(
        width: 250,
        child: AnimatedTextKit(
          animatedTexts: [
            ColorizeAnimatedText(
              user.username,
              speed: Duration(milliseconds: 500),
              textStyle: ApplicationTypography.profileName,
              colors: founderColors,
              textAlign: TextAlign.center,
            ),
          ],
          pause: Duration(milliseconds: 0),
          isRepeatingAnimation: true,
          repeatForever: true,
        ),
      );
    } else if (user.verified == 'true') {
      return Row(
        children: [
          Container(
            width: 240,
            child: Text(
              user.username,
              style: ApplicationTypography.profileName,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
          Icon(
            Icons.verified,
            color: ApplicationColors.primary,
          ),
        ],
      );
    } else {
      return Container(
        width: 250,
        child: Text(
          user.username,
          style: ApplicationTypography.profileName,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      );
    }
  }

  IconData _determineIconBasedOnMyMindPosition() {
    if (_myMindPosition > 0.68) {
      return Icons.expand_more;
    } else {
      return Icons.expand_less;
    }
  }

  List<Tab> _tabs() {
    var tabs = [
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
    ];

    if (widget.type == 'edit') {
      tabs.add(
        Tab(
          child: Text(
            'Salvos',
            style: ApplicationTypography.profileInfoPageTitle,
          ),
        ),
      );
    }

    return tabs;
  }

  String _determineNoFavoritesText() {
    if (widget.type == 'edit') {
      return 'Nenhum assunto favoritado.';
    } else {
      return 'Nenhum assunto favoritado.';
    }
  }

  String _determineMindText() {
    if (widget.type == 'edit') {
      return 'MY MIND';
    } else {
      return 'THEIR MIND';
    }
  }

  String _determineButtonText() {
    if (widget.type == 'edit') {
      return 'Editar';
    } else {
      if (alreadyFollowing) {
        return 'Seguindo';
      } else {
        return 'Seguir';
      }
    }
  }

  String _determineProjectsNotFoundText() {
    if (widget.type == 'edit') {
      return 'Parece que você ainda não criou nenhum projeto. \n\n Que tal criar um para divulgar seus projetos incríveis? :)';
    } else {
      return 'Parece que esse usuário ainda não tem nenhum projeto... \n\n Que tal procurar por projetos em outro usuário? :)';
    }
  }

  String _determineAchievementsNotFoundText() {
    if (widget.type == 'edit') {
      return 'Parece que você ainda não tem nenhuma conquista. \n\n Que tal criar uma e mostrar para o mundo que você já fez? :)';
    } else {
      return 'Parece que esse usuário ainda não tem nenhuma conquista... \n\n Que tal procurar por conquistas em outro usuário? :)';
    }
  }

  String _determineSurveysNotFoundText() {
    if (widget.type == 'edit') {
      return 'Parece que você ainda não criou nenhum questionário. \n\n Que tal criar um? :) Eles são ótimos para coleta de dados!';
    } else {
      return 'Parece que esse usuário ainda não tem nenhum questionário... \n\n Que tal procurar por questionários em outro usuário? :)';
    }
  }

  Widget _button(void Function() onPress, String text) {
    return GradientButton(
      onPressed: () {
        onPress();
      },
      text: text,
      width: _determineWidthOfButton(),
      height: 32,
    );
  }

  double _determineWidthOfButton() {
    if (!alreadyFollowing) {
      return 72;
    } else {
      return 96;
    }
  }
}
