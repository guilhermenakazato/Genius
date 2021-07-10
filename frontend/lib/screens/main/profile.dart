import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

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
  final User follower;

  const Profile({Key key, @required this.type, @required this.id, this.follower})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _ProfileContent(type: type, id: id, follower: follower);
  }
}

class _ProfileContent extends StatefulWidget {
  final String type;
  final int id;
  final User follower;

  const _ProfileContent({Key key, @required this.type, @required this.id, this.follower})
      : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<_ProfileContent> {
  final _navigator = NavigatorUtil();
  double _myMindPosition = 0.65;
  final _tokenObject = Token();
  Future<String> _userData;
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
    _userData = _defineHowToGetData();
  }

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
  Widget build(BuildContext context) {
    return ProgressHUD(
      borderColor: Theme.of(context).primaryColor,
      indicatorWidget: SpinKitPouringHourglass(
        color: Theme.of(context).primaryColor,
      ),
      child: Builder(builder: (context) {
        return FutureBuilder(
          future: _userData,
          builder: (context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData) {
              final user = User.fromJson(jsonDecode(snapshot.data));

              _verifyIfUserIsAlreadyBeingFollowed(user);
              return Scaffold(
                body: Stack(children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(height: 50),
                      _photoNameAndCity(user),
                      _followersEditProfileAndFollowing(user, context),
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

  void _verifyIfUserIsAlreadyBeingFollowed(User user) {
    if (widget.type != 'edit') {
      if (widget.follower.following.map((item) => item.id).contains(user.id)) {
        alreadyFollowing = true;
      } else {
        alreadyFollowing = false;
      }
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
        follower: user,
        projects: user.projects,
        notFoundText: _determineProjectsNotFoundText(),
        onReturned: () {
          setState(() {
            _userData = _defineHowToGetData();
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
          follower: user,
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

  Widget _followersEditProfileAndFollowing(User user, BuildContext context) {
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
                  type: widget.type,
                  id: widget.id,
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
              _navigator.navigate(
                context,
                Follows(type: widget.type, id: widget.id),
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
          ..._determineIfButtonShouldAppear(user, context),
        ],
      ),
    );
  }

  List<Widget> _determineIfButtonShouldAppear(User user, BuildContext context) {
    if (widget.type == 'edit') {
      return _decoratedButton(user, context);
    } else {
      if (widget.follower.id != widget.id) {
        return _decoratedButton(user, context);
      } else {
        return [];
      }
    }
  }

  List<Widget> _decoratedButton(User user, BuildContext context) {
    return [
      Container(
        color: Colors.white,
        width: 0.2,
        height: 22,
      ),
      _button(
        () {
          _determineFunctionToExecuteOnButton(user, context);
        },
        _determineButtonText(),
      ),
    ];
  }

  void _determineFunctionToExecuteOnButton(User user, BuildContext context) {
    if (widget.type == 'edit') {
      _navigator.navigateAndReload(
          context,
          EditOptions(
            id: user.id,
          ), () {
        setState(() {
          _userData = _getDataByToken();
        });
      });
    } else {
      if (alreadyFollowing) {
        unfollow(user, widget.follower, context);
      } else {
        follow(user, widget.follower, context);
      }
    }
  }

  void follow(User user, User follower, BuildContext context) async {
    final _webClient = UserWebClient();
    var followed = true;
    final progress = ProgressHUD.of(context);

    progress.show();

    await _webClient.follow(user.id, follower.id).catchError((error) {
      followed = false;
      progress.dismiss();
      GeniusToast.showToast('Não foi possível seguir o usuário.');
    }, test: (error) => error is TimeoutException);

    if (followed) {
      progress.dismiss();
      follower.following.add(user);
      setState(() {
        _userData = _defineHowToGetData();
      });
    }
  }

  void unfollow(User user, User follower, BuildContext context) async {
    final _webClient = UserWebClient();
    var unfollowed = true;
    final progress = ProgressHUD.of(context);

    progress.show();

    await _webClient.unfollow(user.id, follower.id, false).catchError((error) {
      unfollowed = false;
      progress.dismiss();
      GeniusToast.showToast('Não foi possível deixar de seguir o usuário.');
    }, test: (error) => error is TimeoutException);

    if (unfollowed) {
      progress.dismiss();
      follower.following.removeWhere((element) => element.id == user.id);

      setState(() {
        _userData = _defineHowToGetData();
      });
    }
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
              _determineStyle(user),
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

  Widget _determineStyle(User user) {
    if (user.verified == 'founder') {
      return Container(
        width: 170,
        child: AnimatedTextKit(
          animatedTexts: [
            ColorizeAnimatedText(
              user.username,
              textStyle: ApplicationTypography.profileName,
              colors: founderColors,
            ),
          ],
          isRepeatingAnimation: true,
          repeatForever: true,
        ),
      );
    } else if (user.verified == 'true') {
      return Row(
        children: [
          Container(
            width: 160,
            child: Text(
              user.username,
              style: ApplicationTypography.profileName,
              overflow: TextOverflow.ellipsis,
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
        width: 170,
        child: Text(
          user.username,
          style: ApplicationTypography.profileName,
          overflow: TextOverflow.ellipsis,
        ),
      );
    }
  }

  IconData _determineIconBasedOnMyMindPosition() {
    if (_myMindPosition > 0.65) {
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
      return 'Você ainda não tem nenhum assunto favorito.';
    } else {
      return 'Esse usuário ainda não tem nenhum assunto favorito.';
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
      return 'Parece que você ainda não criou nenhum projeto. Que tal criar um para divulgar seus projetos incríveis? :)';
    } else {
      return 'Parece que esse usuário ainda não tem nenhum projeto... Que tal procurar por projetos em outro usuário? :)';
    }
  }

  String _determineAchievementsNotFoundText() {
    if (widget.type == 'edit') {
      return 'Parece que você ainda não tem nenhuma conquista. Que tal criar uma e mostrar para o mundo que você já fez? :)';
    } else {
      return 'Parece que esse usuário ainda não tem nenhuma conquista... Que tal procurar por conquistas em outro usuário? :)';
    }
  }

  String _determineSurveysNotFoundText() {
    if (widget.type == 'edit') {
      return 'Parece que você ainda não criou nenhum questionário. Que tal criar um? :) Eles são ótimos para coleta de dados!';
    } else {
      return 'Parece que esse usuário ainda não tem nenhum questionário... Que tal procurar por questionários em outro usuário? :)';
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
