import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:genius/models/user.dart';

import '../../http/webclients/user_webclient.dart';
import '../../models/token.dart';
import '../../screens/main/send_mail.dart';
import '../../screens/main/profile.dart';
import '../../components/genius_card.dart';
import '../../components/genius_card_config.dart';
import '../../components/data_not_found_card.dart';
import '../../utils/convert.dart';
import '../../models/project.dart';
import '../../http/webclients/project_webclient.dart';
import '../../utils/application_colors.dart';
import '../../utils/navigator_util.dart';
import 'project/project_info.dart';

class Feed extends StatelessWidget {
  final _tokenObject = Token();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getFeedData(),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          var user = User.fromJson(jsonDecode(snapshot.data[0]));
          var projects =
              Convert.convertStringToListofTypeProject(snapshot.data[1]);

          return _FeedContent(
            projects: projects,
            follower: user,
          );
        } else {
          return SpinKitFadingCube(color: ApplicationColors.primary);
        }
      },
    );
  }

  Future<List<dynamic>> _getFeedData() async {
    var responses = Future.wait([
      _getUserDataByToken(),
      _getProjects(),
    ]);

    return responses;
  }

  Future<String> _getProjects() async {
    final _webClient = ProjectWebClient();
    final projects = await _webClient.getAllProjects();

    return projects;
  }

  Future<String> _getUserDataByToken() async {
    final _webClient = UserWebClient();
    final _token = await _tokenObject.getToken();
    final _user = await _webClient.getUserData(_token);
    return _user;
  }
}

class _FeedContent extends StatefulWidget {
  final List<Project> projects;
  final User follower;

  const _FeedContent({Key key, this.projects, this.follower})
      : super(key: key);

  @override
  _FeedState createState() => _FeedState(projects);
}

class _FeedState extends State<_FeedContent> {
  final navigator = NavigatorUtil();
  final List<Project> projects;

  _FeedState(this.projects);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: _verifyWhichWidgetShouldBeDisplayed(),
      ),
    );
  }

  Widget _verifyWhichWidgetShouldBeDisplayed() {
    if (projects.isEmpty) {
      return _noProjectWidget();
    } else {
      return _carouselOfCards();
    }
  }

  Widget _noProjectWidget() {
    return DataNotFoundCard(
      text:
          'Parece que ainda não tem nenhum projeto no Genius. Que tal criar um? :)',
      color: ApplicationColors.secondCardColor,
    );
  }

  Widget _carouselOfCards() {
    return GeniusCardConfig(
      itemCount: projects.length,
      layout: SwiperLayout.STACK,
      builder: (BuildContext context, int index) {
        return GeniusCard(
          onTap: () {
            navigator.navigate(
              context,
              ProjectInfo(
                project: projects[index],
              ),
            );
          },
          cardColor: Theme.of(context).cardColor,
          abstractText: projects[index].abstractText,
          projectName: projects[index].name,
          type: 'feed',
          projectParticipants: projects[index].participants,
          onParticipantsClick: (int id) {
            navigator.navigate(
              context,
              Profile(
                type: 'user',
                id: id,
                follower: widget.follower,
              ),
            );
          },
          onClickedConversationIcon: () {
            navigator.navigate(
                context, SendMail(email: projects[index].email, type: 'feed'));
          },
        );
      },
    );
  }
}
