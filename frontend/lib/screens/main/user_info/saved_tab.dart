import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:genius/http/webclients/user_webclient.dart';
import 'package:genius/models/token.dart';
import 'package:genius/models/user.dart';

import '../../../components/genius_card.dart';
import '../../../components/genius_card_config.dart';
import '../../../components/data_not_found_card.dart';
import '../../../models/project.dart';
import '../../../screens/main/project/project_info.dart';
import '../../../utils/application_colors.dart';
import '../../../utils/navigator_util.dart';
import '../profile.dart';

class SavedTab extends StatefulWidget {
  final List<Project> savedProjects;
  final Function onChangedState;

  SavedTab({
    Key key,
    @required this.savedProjects,
    @required this.onChangedState,
  }) : super(key: key);

  @override
  _SavedTabState createState() => _SavedTabState();
}

class _SavedTabState extends State<SavedTab> {
  final _tokenObject = Token();
  final navigator = NavigatorUtil();
  bool card = true;
  final _userWebClient = UserWebClient();

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
                _determineWhichWidgetsShouldBeDisplayed(context, user)
              ],
            ),
          );
        } else {
          return SpinKitFadingCube(color: ApplicationColors.primary);
        }
      },
    );
  }

  Widget _determineWhichWidgetsShouldBeDisplayed(
      BuildContext context, User user) {
    if (widget.savedProjects.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(right: 8.0, left: 8),
        child: DataNotFoundCard(
          color: ApplicationColors.secondCardColor,
          text:
              'Parece que você ainda não salvou nenhum projeto. Que tal navegar pelo feed e salvar um? :)',
        ),
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

  Widget _determineWhichLayoutShouldBeDisplayed(
      BuildContext context, User user) {
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
          itemCount: widget.savedProjects.length,
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
                            projectId: widget.savedProjects[index].id,
                          ),
                          () {
                            widget.onChangedState();
                          },
                        );
                      },
                      child: Center(
                        child: Text(
                          widget.savedProjects[index].name,
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
                  projectId: widget.savedProjects[index].id,
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
            abstractText: widget.savedProjects[index].abstractText,
            projectName: widget.savedProjects[index].name,
            type: 'saved_projects',
            projectParticipants: widget.savedProjects[index].participants,
            likes: widget.savedProjects[index].likedBy.length,
            liked: widget.savedProjects[index].likedBy
                .map(
                  (item) => item.id,
                )
                .contains(user.id),
            saved: widget.savedProjects[index].savedBy
                .map(
                  (item) => item.id,
                )
                .contains(user.id),
            onLiked: () async {
              final token = await _tokenObject.getToken();

              if (widget.savedProjects[index].likedBy
                  .map((item) => item.id)
                  .contains(user.id)) {
                await _userWebClient.dislikeProject(
                  widget.savedProjects[index].id,
                  user.id,
                  token,
                );
              } else {
                await _userWebClient.likeProject(
                  widget.savedProjects[index].id,
                  user.id,
                  token,
                );
              }

              widget.onChangedState();
            },
            onSaved: () async {
              final token = await _tokenObject.getToken();

              if (widget.savedProjects[index].savedBy
                  .map((item) => item.id)
                  .contains(user.id)) {
                await _userWebClient.removeSavedProject(
                  widget.savedProjects[index].id,
                  user.id,
                  token,
                );
              } else {
                await _userWebClient.saveProject(
                  widget.savedProjects[index].id,
                  user.id,
                  token,
                );
              }

              widget.onChangedState();
            },
          );
        },
        itemCount: widget.savedProjects.length,
      ),
    );
  }
}
