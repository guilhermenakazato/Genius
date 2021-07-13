import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';

import '../../http/webclients/user_webclient.dart';
import '../../models/feed_projects.dart';
import '../../models/token.dart';
import '../../screens/main/send_mail.dart';
import '../../screens/main/profile.dart';
import '../../components/genius_card.dart';
import '../../components/genius_card_config.dart';
import '../../components/data_not_found_card.dart';
import '../../http/webclients/project_webclient.dart';
import '../../utils/application_colors.dart';
import '../../utils/navigator_util.dart';
import 'project/project_info.dart';

class Feed extends StatelessWidget {
  final _webClient = ProjectWebClient();

  @override
  Widget build(BuildContext context) {
    return FutureProvider<FeedProjects>(
      create: (context) => _webClient.getAllProjects(),
      initialData: null,
      child: _FeedContent(),
    );
  }
}

class _FeedContent extends StatelessWidget {
  final navigator = NavigatorUtil();
  final _tokenObject = Token();

  Future<String> _getUserDataByToken() async {
    final _webClient = UserWebClient();
    final _token = await _tokenObject.getToken();
    final _user = await _webClient.getUserData(_token);
    return _user;
  }

  @override
  Widget build(BuildContext context) {
    var projects = Provider.of<FeedProjects>(context);

    return FutureBuilder(
      future: _getUserDataByToken(),
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData && projects != null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: _verifyWhichWidgetShouldBeDisplayed(context),
            ),
          );
        } else {
          return SpinKitFadingCube(color: ApplicationColors.primary);
        }
      },
    );
  }

  Widget _verifyWhichWidgetShouldBeDisplayed(BuildContext context) {
    var projects = Provider.of<FeedProjects>(context).getFeedProjects();

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
    return Consumer<FeedProjects>(
      builder: (context, feedProjects, child) {
        final projects = feedProjects.getFeedProjects();

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
                  ),
                );
              },
              onClickedConversationIcon: () {
                navigator.navigate(context,
                    SendMail(email: projects[index].email, type: 'feed'));
              },
            );
          },
        );
      },
    );
  }
}
