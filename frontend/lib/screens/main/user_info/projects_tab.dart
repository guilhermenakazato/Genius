import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:genius/http/webclients/user_webclient.dart';
import 'package:genius/models/token.dart';
import 'package:genius/models/user.dart';

import '../../../components/genius_card.dart';
import '../../../components/genius_card_config.dart';
import '../../../components/data_not_found_card.dart';
import '../../../utils/navigator_util.dart';
import '../../../screens/main/project/project_info.dart';
import '../../../utils/application_colors.dart';
import '../../../models/project.dart';
import '../profile.dart';

class ProjectsTab extends StatefulWidget {
  final List<Project> projects;
  final String notFoundText;
  final Function onChangedState;

  ProjectsTab({
    Key key,
    @required this.projects,
    @required this.notFoundText,
    @required this.onChangedState,
  }) : super(key: key);

  @override
  _ProjectsTabState createState() => _ProjectsTabState();
}

class _ProjectsTabState extends State<ProjectsTab> {
  final navigator = NavigatorUtil();
  bool card = true;
  final _userWebClient = UserWebClient();
  final _tokenObject = Token();

  Future<String> _getUserData() async {
    final _webClient = UserWebClient();
    final _token = await _tokenObject.getToken();
    final _user = await _webClient.getUserData(_token);
    return _user;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getUserData(),
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          final user = User.fromJson(jsonDecode(snapshot.data));

          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _determineWhichWidgetsShouldBeDisplayed(context, user),
              ],
            ),
          );
        } else {
          return SpinKitFadingCube(color: ApplicationColors.primary);
        }
      },
    );
  }

  Widget _determineWhichWidgetsShouldBeDisplayed(BuildContext context, User user) {
    if (widget.projects.isEmpty) {
      return Column(
        children: [
          DataNotFoundCard(
            color: ApplicationColors.secondCardColor,
            text: widget.notFoundText,
          ),
          Container(height: 70),
        ],
      );
    } else {
      return Column(
        children: [
          _iconToChooseStyleOfProjects(),
          _determineWhichLayoutShouldBeDisplayed(context, user)
        ],
      );
    }
  }

  Widget _iconToChooseStyleOfProjects() {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Material(
            color: Colors.transparent,
            child: IconButton(
              splashRadius: 32,
              icon: Icon(_determineWhichIconShouldBeDisplayed()),
              onPressed: () {
                setState(() {
                  card = !card;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  IconData _determineWhichIconShouldBeDisplayed() {
    if (card) {
      return Icons.list_alt;
    } else {
      return Icons.view_carousel;
    }
  }

  Widget _determineWhichLayoutShouldBeDisplayed(BuildContext context, User user) {
    if (card) {
      return _carouselOfCards(user);
    } else {
      return _listOfCards(context);
    }
  }

  Widget _listOfCards(BuildContext context) {
    return SizedBox(
      height: 500,
      child: MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: ListView.builder(
          itemCount: widget.projects.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 8),
              child: Container(
                height: 50,
                child: Card(
                  elevation: 0,
                  child: Ink(
                    color: ApplicationColors.secondCardColor,
                    child: InkWell(
                      onTap: () {
                        navigator.navigateAndReload(
                          context,
                          ProjectInfo(
                            projectId: widget.projects[index].id,
                          ),
                          () {
                            widget.onChangedState();
                          },
                        );
                      },
                      child: Center(
                        child: Text(
                          widget.projects[index].name,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _carouselOfCards(User user) {
    return SizedBox(
      width: 300,
      height: 455,
      child: GeniusCardConfig(
        cardDirection: Axis.vertical,
        builder: (BuildContext context, int index) {
          return GeniusCard(
            onTap: () {
              navigator.navigateAndReload(
                context,
                ProjectInfo(
                  projectId: widget.projects[index].id,
                ),
                () {
                  widget.onChangedState();
                },
              );
            },
            onParticipantsClick: (int id) {
              navigator.navigateAndReload(
                context,
                Profile(
                  type: 'user',
                  id: id,
                ),
                () {
                  widget.onChangedState();
                },
              );
            },
            cardColor: ApplicationColors.secondCardColor,
            projectParticipants: widget.projects[index].participants,
            abstractText: widget.projects[index].abstractText,
            projectName: widget.projects[index].name,
            type: 'my_projects',
            participantsBorderColor:
                ApplicationColors.participantsTagSecondaryColor,
            likes: widget.projects[index].likedBy.length,
            liked: widget.projects[index].likedBy
                .map(
                  (item) => item.id,
                )
                .contains(user.id),
            saved: widget.projects[index].savedBy
                .map(
                  (item) => item.id,
                )
                .contains(user.id),
            onLiked: () async {
              if (widget.projects[index].likedBy
                  .map((item) => item.id)
                  .contains(user.id)) {
                await _userWebClient.dislikeProject(
                  widget.projects[index].id,
                  user.id,
                );
              } else {
                await _userWebClient.likeProject(
                  widget.projects[index].id,
                  user.id,
                );
              }

              widget.onChangedState();
            },
            onSaved: () async {
              if (widget.projects[index].savedBy
                  .map((item) => item.id)
                  .contains(user.id)) {
                await _userWebClient.removeSavedProject(
                  widget.projects[index].id,
                  user.id,
                );
              } else {
                await _userWebClient.saveProject(
                  widget.projects[index].id,
                  user.id,
                );
              }

              widget.onChangedState();
            },
          );
        },
        itemCount: widget.projects.length,
      ),
    );
  }
}
