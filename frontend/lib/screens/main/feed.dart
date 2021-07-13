import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:genius/models/project.dart';
import 'package:genius/utils/convert.dart';

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
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getProjects(),
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

  Future<String> _getProjects() async {
    final _webClient = ProjectWebClient();
    final projects = await _webClient.getAllProjects();

    return projects;
  }
}

class _FeedContent extends StatefulWidget {
  final List<Project> projects;

  const _FeedContent({Key key, this.projects})
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

// class Feed extends StatelessWidget {
//   final _webClient = ProjectWebClient();

//   @override
//   Widget build(BuildContext context) {
//     return FutureProvider<FeedProjects>(
//       create: (context) async {
//         final projects = await _webClient.getAllProjects();
//         return FeedProjects(projects);
//       },
//       initialData: null,
//       child: _FeedContent(),
//     );
//   }
// }

// class _FeedContent extends StatefulWidget {
//   @override
//   State<_FeedContent> createState() => _FeedContentState();
// }

// class _FeedContentState extends State<_FeedContent> {
//   final navigator = NavigatorUtil();

//   final _tokenObject = Token();

//   Future<String> _getUserDataByToken() async {
//     final _webClient = UserWebClient();
//     final _token = await _tokenObject.getToken();
//     final _user = await _webClient.getUserData(_token);
//     return _user;
//   }

//   @override
//   Widget build(BuildContext context) {
//     var projects = Provider.of<FeedProjects>(context);

//     return FutureBuilder(
//       future: _getUserDataByToken(),
//       builder: (context, AsyncSnapshot<String> snapshot) {
//         if (snapshot.hasData && projects != null) {
//           final user = User.fromJson(jsonDecode(snapshot.data));

//           return Center(
//             child: Padding(
//               padding: const EdgeInsets.only(bottom: 15),
//               child: _verifyWhichWidgetShouldBeDisplayed(context, user),
//             ),
//           );
//         } else {
//           return SpinKitFadingCube(color: ApplicationColors.primary);
//         }
//       },
//     );
//   }

//   Widget _verifyWhichWidgetShouldBeDisplayed(BuildContext context, User user) {
//     var projects =
//         Provider.of<FeedProjects>(context, listen: false).getFeedProjects();

//     if (projects.isEmpty) {
//       return _noProjectWidget();
//     } else {
//       return _carouselOfCards(user);
//     }
//   }

//   Widget _noProjectWidget() {
//     return DataNotFoundCard(
//       text:
//           'Parece que ainda não tem nenhum projeto no Genius. Que tal criar um? :)',
//       color: ApplicationColors.secondCardColor,
//     );
//   }

//   Widget _carouselOfCards(User user) {
//     return Consumer<FeedProjects>(
//       builder: (context, feedProjects, child) {
//         final projects = feedProjects.getFeedProjects();
//         debugPrint(projects[0].likedBy.toString());

//         return GeniusCardConfig(
//           itemCount: projects.length,
//           layout: SwiperLayout.STACK,
//           builder: (BuildContext context, int index) {
//             return GeniusCard(
//               onTap: () {
//                 navigator.navigate(
//                   context,
//                   ProjectInfo(
//                     project: projects[index],
//                   ),
//                 );
//               },
//               cardColor: Theme.of(context).cardColor,
//               abstractText: projects[index].abstractText,
//               projectName: projects[index].name,
//               type: 'feed',
//               projectParticipants: projects[index].participants,
//               onParticipantsClick: (int id) {
//                 navigator.navigate(
//                   context,
//                   Profile(
//                     type: 'user',
//                     id: id,
//                   ),
//                 );
//               },
//               onClickedConversationIcon: () {
//                 navigator.navigate(
//                   context,
//                   SendMail(
//                     email: projects[index].email,
//                     type: 'feed',
//                   ),
//                 );
//               },
//               liked: feedProjects.getFeedProjects()[index]
//                   .likedBy
//                   .map((item) => item.id)
//                   .contains(user.id),
//               onLiked: () {
//                 if (projects[index]
//                     .likedBy
//                     .map((item) => item.id)
//                     .contains(user.id)) {
//                   Provider.of<FeedProjects>(context, listen: false).dislike(
//                     projects[index].id,
//                     user.id,
//                   );
//                 } else {
//                   Provider.of<FeedProjects>(context, listen: false).like(
//                     projects[index].id,
//                     user.id,
//                   );
//                 }
//               },
//               onSaved: () {},
//             );
//           },
//         );
//       },
//     );
//   }
// }
