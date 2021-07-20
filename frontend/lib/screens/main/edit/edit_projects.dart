import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:genius/components/warning_dialog.dart';
import 'package:genius/http/webclients/project_webclient.dart';
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

          return ProgressHUD(
            borderColor: Theme.of(context).primaryColor,
            indicatorWidget: SpinKitPouringHourglass(
              color: Theme.of(context).primaryColor,
            ),
            child: Builder(
              builder: (context) => Theme(
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
                  body: _verifyWhichWidgetShouldBeDisplayed(
                    projects,
                    user,
                    context,
                  ),
                ),
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

  Widget _listOfCards(
      BuildContext context, List<Project> projects, User follower) {
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
                            projectId: projects[index].id,
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
              _iconToChooseStyleOfProjects(),
              _carouselOfCards(projects, user, context),
            ],
          ),
        );
      } else {
        return Column(
          children: [
            _iconToChooseStyleOfProjects(),
            _listOfCards(context, projects, user),
          ],
        );
      }
    }
  }

  Widget _carouselOfCards(
      List<Project> projects, User user, BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.8 - 65,  
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
                  projectId: projects[index].id,
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
            onDeleteRequest: () async {
              await updateDeleteRequest(projects[index], user, context);

              setState(
                () {
                  _userData = getData();
                },
              );
            },
            hasAlreadyRequestedDelete: projects[index].deleteRequests.map((item) => item.id).contains(user.id)
          );
        },
        itemCount: projects.length,
      ),
    );
  }

  Future<dynamic> updateDeleteRequest(
      Project project, User user, BuildContext context) async {
    final projectWebClient = ProjectWebClient();
    final navigator = NavigatorUtil();

    var shouldDelete =
        (project.deleteRequests.length + 1) == project.participants.length;
    var userHasAlreadyRequestedDelete =
        project.deleteRequests.map((item) => item.id).contains(user.id);

    if (shouldDelete && !userHasAlreadyRequestedDelete) {
      return showDialog(
        context: context,
        builder: (
          BuildContext context,
        ) =>
            ProgressHUD(
          borderColor: Theme.of(context).primaryColor,
          indicatorWidget: SpinKitPouringHourglass(
            color: Theme.of(context).primaryColor,
          ),
          child: Builder(
            builder: (context) => WarningDialog(
              content: 'Caso exclua, não poderá recuperar os dados dele.',
              title: 'Excluir projeto?',
              acceptFunction: () async {
                final progress = ProgressHUD.of(context);
                final token = await _tokenObject.getToken();
                progress.show();

                await projectWebClient.deleteProject(project.id, token);
                progress.dismiss();
                navigator.goBack(context);
              },
              cancelFunction: () {
                navigator.goBack(context);
              },
              acceptText: 'Excluir',
            ),
          ),
        ),
      );
    } else {
      final progress = ProgressHUD.of(context);
      final token = await _tokenObject.getToken();

      progress.show();
      await projectWebClient.updateDeleteRequest(project.id, user.id, token);
      progress.dismiss();
    }
  }
}
