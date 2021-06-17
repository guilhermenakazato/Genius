import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../components/genius_card.dart';
import '../../../components/genius_card_config.dart';
import '../../../screens/main/project/project_info.dart';
import '../../../utils/navigator_util.dart';
import '../../../models/user.dart';
import '../../../components/data_not_found.dart';
import '../../../models/project.dart';
import '../../../http/webclients/user_webclient.dart';
import '../../../models/token.dart';
import '../../../components/floating_button.dart';
import '../../../utils/application_colors.dart';
import 'forms/project_form.dart';

class EditProjects extends StatefulWidget {
  @override
  _EditProjectsState createState() => _EditProjectsState();
}

class _EditProjectsState extends State<EditProjects> {
  Future<String> _userData;
  final _tokenObject = Token();
  final navigator = NavigatorUtil();
  bool card = true;

  @override
  void initState() {
    super.initState();
    _userData = getData();
  }

  Future<String> getData() async {
    final _webClient = UserWebClient();
    final _token = await _tokenObject.getToken();
    final _user = await _webClient.getUserData(_token);
    return _user;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _userData,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          final user = User.fromJson(jsonDecode(snapshot.data));
          final projects = user.projects;

          return Theme(
            data: Theme.of(context).copyWith(
              splashColor: ApplicationColors.splashColor,
            ),
            child: Scaffold(
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: FloatingButton(
                onPressed: () {
                  navigator.navigateAndReload(
                      context,
                      ProjectForm(
                        user: user,
                      ), () {
                    setState(() {
                      _userData = getData();
                    });
                  });
                },
                icon: Icons.add,
                text: 'Adicionar',
              ),
              body: Column(
                children: [
                  _iconToChooseStyleOfProjects(),
                  _verifyWhichWidgetShouldBeDisplayed(projects, user, context),
                ],
              ),
            ),
          );
        } else {
          return SpinKitFadingCube(color: ApplicationColors.primary);
        }
      },
    );
  }

  Widget _iconToChooseStyleOfProjects() {
    return Row(
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
    );
  }

  IconData _determineWhichIconShouldBeDisplayed() {
    if (card) {
      return Icons.list_alt;
    } else {
      return Icons.view_carousel;
    }
  }

  Widget _listOfCards(BuildContext context, List<Project> projects) {
    return SizedBox(
      height: 490,
      child: MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: ListView.builder(
          itemCount: projects.length,
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
                        navigator.navigate(
                          context,
                          ProjectInfo(
                            project: projects[index],
                          ),
                        );
                      },
                      child: Center(
                        child: Text(
                          projects[index].name,
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

  Widget _verifyWhichWidgetShouldBeDisplayed(
    List<Project> projects,
    User user,
    BuildContext context,
  ) {
    if (projects.isEmpty) {
      return DataNotFound(
        text: 'Você ainda não tem\nnenhum projeto',
      );
    } else {
      if (card == true) {
        return Align(
          child: Column(
            children: [
              _carouselOfCards(projects, user),
            ],
          ),
        );
      } else {
        return _listOfCards(context, projects);
      }
    }
  }

  Widget _carouselOfCards(List<Project> projects, User user) {
    return SizedBox(
      width: 300,
      height: 490,
      child: GeniusCardConfig(
        cardDirection: Axis.vertical,
        builder: (BuildContext context, int index) {
          return GeniusCard(
            abstractText: projects[index].abstractText,
            projectName: projects[index].name,
            type: 'edit',
            projectParticipants: projects[index].participants,
            onTap: () {
              navigator.navigate(
                context,
                ProjectInfo(
                  project: projects[index],
                ),
              );
            },
            cardColor: ApplicationColors.secondCardColor,
            onEdit: () {
              navigator.navigateAndReload(
                context,
                ProjectForm(
                  type: 'edit',
                  user: user,
                  project: projects[index],
                ),
                () {
                  setState(
                    () {
                      _userData = getData();
                    },
                  );
                },
              );
            },
            deleteRequestsCount: projects[index].deleteRequests.length,
            participantsCount: projects[index].participants.length,
          );
        },
        itemCount: projects.length,
      ),
    );
  }
}
