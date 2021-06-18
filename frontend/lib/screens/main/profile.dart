import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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

  const Profile({Key key, @required this.type, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _ProfileContent(type: type, id: id);
  }
}

class _ProfileContent extends StatefulWidget {
  final String type;
  final int id;

  const _ProfileContent({Key key, @required this.type, this.id})
      : super(key: key);

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
    return FutureBuilder(
      future: _userData,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          final user = User.fromJson(jsonDecode(snapshot.data));

          return Scaffold(
            body: Stack(children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(height: 50),
                  _photoNameAndCity(user),
                  _followersEditProfileAndFollowing(user),
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
        projects: user.projects,
        notFoundText: _determineProjectsNotFoundText(),
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
        ),
      );
    }

    return TabBarView(
      children: tabs
    );
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
          _button(
            () => _determineFunctionToExecuteOnButton(user),
            _determineButtonText(),
          ),
        ],
      ),
    );
  }

  void _determineFunctionToExecuteOnButton(User user) {
    _navigator.navigateAndReload(
        context,
        EditOptions(
          id: user.id,
        ), () {
      setState(() {
        _userData = _getDataByToken();
      });
    });
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
      return 'Seguir';
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
      onPressed: () => onPress,
      text: text,
      width: 72,
      height: 32,
    );
  }
}
