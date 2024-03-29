import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../../http/webclients/notification_webclient.dart';
import '../../http/webclients/user_webclient.dart';
import '../../models/token.dart';
import '../../models/user.dart';
import '../../utils/genius_toast.dart';
import '../../utils/notifications.dart';
import '../../models/project.dart';
import '../../utils/convert.dart';
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
    return _FeedContent();
  }
}

class _FeedContent extends StatefulWidget {
  @override
  State<_FeedContent> createState() => _FeedState();
}

class _FeedState extends State<_FeedContent> {
  final _tokenObject = Token();
  Future<List<dynamic>> _feedData;
  final _navigator = NavigatorUtil();
  final _userWebClient = UserWebClient();
  final _notificationWebClient = NotificationWebClient();

  @override
  void initState() {
    super.initState();
    _feedData = _getFeedData();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      var notification = message.notification;
      GeniusToast.showToast(notification.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _feedData,
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          var projects =
              Convert.convertToListOfProjects(jsonDecode(snapshot.data[0]));
          final user = snapshot.data[1];

          return Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: _verifyWhichWidgetShouldBeDisplayed(user, projects),
            ),
          );
        } else {
          return SpinKitFadingCube(color: ApplicationColors.primary);
        }
      },
    );
  }

  Widget _verifyWhichWidgetShouldBeDisplayed(
    User user,
    List<Project> projects,
  ) {
    if (projects.isEmpty) {
      return _noProjectWidget();
    } else {
      return _carouselOfCards(user, projects);
    }
  }

  Widget _noProjectWidget() {
    return DataNotFoundCard(
      text:
          'Parece que ainda não tem nenhum projeto no Genius. Que tal criar um? :)',
      color: ApplicationColors.secondCardColor,
    );
  }

  Widget _carouselOfCards(User user, List<Project> projects) {
    return GeniusCardConfig(
      itemCount: projects.length,
      layout: SwiperLayout.STACK,
      builder: (BuildContext context, int index) {
        var projectIsAlreadyLikedByUser = projects[index]
            .likedBy
            .map(
              (item) => item.id,
            )
            .contains(
              user.id,
            );
        var projectIsAlreadySavedByUser = projects[index]
            .savedBy
            .map(
              (item) => item.id,
            )
            .contains(
              user.id,
            );

        return GeniusCard(
          textHeight: MediaQuery.of(context).size.height * 0.8 - 300,
          onTap: () {
            _navigator.navigateAndReload(
              context,
              ProjectInfo(
                projectId: projects[index].id,
              ),
              () {
                setState(() {
                  _feedData = _getFeedData();
                });
              },
            );
          },
          cardColor: Theme.of(context).cardColor,
          abstractText: projects[index].abstractText,
          projectName: projects[index].name,
          type: 'feed',
          projectParticipants: projects[index].participants,
          onParticipantsClick: (int id) {
            _navigator.navigate(
              context,
              Profile(
                type: 'user',
                id: id,
              ),
            );
          },
          onClickedConversationIcon: () {
            _navigator.navigate(
              context,
              SendMail(
                email: projects[index].email,
                type: 'feed',
              ),
            );
          },
          likes: projects[index].likedBy.length,
          liked: projectIsAlreadyLikedByUser,
          saved: projectIsAlreadySavedByUser,
          onLiked: () async {
            final token = await _tokenObject.getToken();

            if (projectIsAlreadyLikedByUser) {
              await _userWebClient.dislikeProject(
                projects[index].id,
                user.id,
                token,
              );
            } else {
              await _userWebClient.likeProject(
                projects[index].id,
                user.id,
                token,
              );

              projects[index].participants.forEach((participant) async {
                if (participant.deviceToken != null && participant is User) {
                  await _notificationWebClient.sendLikeNotification(
                    participant.deviceToken,
                    user.username,
                  );
                }
              });
            }

            setState(() {
              _feedData = _getFeedData();
            });
          },
          onSaved: () async {
            final token = await _tokenObject.getToken();

            if (projectIsAlreadySavedByUser) {
              await _userWebClient.removeSavedProject(
                projects[index].id,
                user.id,
                token,
              );
            } else {
              await _userWebClient.saveProject(
                projects[index].id,
                user.id,
                token,
              );
            }

            setState(() {
              _feedData = _getFeedData();
            });
          },
        );
      },
    );
  }

  Future<List<dynamic>> _getFeedData() {
    var responses = Future.wait([
      _getProjects(),
      _getDataByToken(),
    ]);

    return responses;
  }

  Future<String> _getProjects() async {
    final _webClient = ProjectWebClient();
    final token = await _tokenObject.getToken();
    final projects = await _webClient.getAllProjects(token);

    return projects;
  }

  Future<User> _getDataByToken() async {
    final webClient = UserWebClient();
    final token = await _tokenObject.getToken();
    final userStringData = await webClient.getUserData(token);
    final user = User.fromJson(jsonDecode(userStringData));
    final deviceToken = await FirebaseMessaging.instance.getToken();
    final jwtToken = await _tokenObject.getToken();
    final notificationIsAllowed =
        await Notifications.getNotificationPreference();

    if (user.deviceToken != deviceToken && notificationIsAllowed) {
      await webClient.setDeviceToken(deviceToken, jwtToken, user.id);
    } else if (!notificationIsAllowed) {
      await webClient.setDeviceToken(null, jwtToken, user.id);
    }

    return user;
  }
}
