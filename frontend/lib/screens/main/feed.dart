import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

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
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getProjects(),
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          var projects =
              Convert.convertStringToListofTypeProject(snapshot.data);

          return _FeedContent(
            projects: projects,
          );
        } else {
          return SpinKitFadingCube(color: ApplicationColors.primary);
        }
      },
    );
  }

  Future<String> getProjects() async {
    final _webClient = ProjectWebClient();
    final projects = await _webClient.getAllProjects();

    return projects;
  }
}

class _FeedContent extends StatefulWidget {
  final List<Project> projects;

  const _FeedContent({Key key, this.projects}) : super(key: key);

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
            navigator.navigate(context, Profile(type: 'user', id: id));
          },
        );
      },
    );
  }
}
