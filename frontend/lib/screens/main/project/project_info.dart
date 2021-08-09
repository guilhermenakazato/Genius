import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../http/webclients/notification_webclient.dart';
import '../../../http/webclients/project_webclient.dart';
import '../../../http/webclients/user_webclient.dart';
import '../../../models/project.dart';
import '../../../models/token.dart';
import '../../../models/user.dart';
import '../../../utils/application_colors.dart';
import '../../../utils/navigator_util.dart';
import '../../../utils/application_typography.dart';
import '../profile.dart';
import '../send_mail.dart';

class ProjectInfo extends StatefulWidget {
  final int projectId;

  ProjectInfo({Key key, @required this.projectId}) : super(key: key);

  @override
  State<ProjectInfo> createState() => _ProjectInfoState();
}

class _ProjectInfoState extends State<ProjectInfo> {
  final _navigator = NavigatorUtil();
  final _tokenObject = Token();
  Future<List<dynamic>> _projectInfoScreenData;
  final _userWebClient = UserWebClient();
  final _notificationWebClient = NotificationWebClient();
  bool saveIsLoading = false, likeIsLoading = false;

  @override
  void initState() {
    super.initState();
    _projectInfoScreenData = _getProjectInfoScreenData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _projectInfoScreenData,
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          final project = Project.fromJson(jsonDecode(snapshot.data[0]));
          final user = User.fromJson(jsonDecode(snapshot.data[1]));

          return SafeArea(
            child: Scaffold(
              backgroundColor: Theme.of(context).cardColor,
              body: Align(
                child: Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 20,
                                    left: 30,
                                    right: 30,
                                  ),
                                  child: Container(
                                    width: double.infinity,
                                    child: Text(
                                      project.name,
                                      style:
                                          ApplicationTypography.projectNameText,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 8.0, top: 8),
                                  child: _participantsOfTheProject(project),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30.0, right: 30, bottom: 8),
                                  child: Container(
                                    width: double.infinity,
                                    child: Text(
                                      'Orientador: ${_determineMainTeacherName(project)}',
                                      textAlign: TextAlign.start,
                                      style: ApplicationTypography
                                          .projectAbstractText,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30.0, right: 30, bottom: 8),
                                  child: Container(
                                    width: double.infinity,
                                    child: Text(
                                      'Coorientador: ${_determineSecondTeacherName(project)}',
                                      textAlign: TextAlign.start,
                                      style: ApplicationTypography
                                          .projectAbstractText,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30.0, right: 30, bottom: 8),
                                  child: Container(
                                    width: double.infinity,
                                    child: Text(
                                      'Estudantes pesquisadores: ${project.participantsFullName}',
                                      textAlign: TextAlign.start,
                                      style: ApplicationTypography
                                          .projectAbstractText,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                    40,
                                    10,
                                    30,
                                    0,
                                  ),
                                  child: Container(
                                    width: double.infinity,
                                    child: Text(
                                      project.abstractText,
                                      style: ApplicationTypography
                                          .projectAbstractText,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      child: Align(
                        alignment: FractionalOffset.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 30, right: 30),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  'Curtido por\n${project.likedBy.length.toString()} pessoas',
                                  style: ApplicationTypography.like,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 15,
                                    top: 4,
                                    right: 4,
                                    bottom: 4,
                                  ),
                                  child: Container(
                                    width: 48,
                                    height: 48,
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                        primary: Theme.of(context).primaryColor,
                                        backgroundColor:
                                            ApplicationColors.iconButtonColor,
                                        padding: EdgeInsets.all(12),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(24),
                                        ),
                                      ),
                                      child: _defineLikeIcon(project, user),
                                      onPressed: () async {
                                        final token =
                                            await _tokenObject.getToken();

                                        setState(() {
                                          likeIsLoading = true;
                                        });

                                        if (project.likedBy
                                            .map((item) => item.id)
                                            .contains(user.id)) {
                                          await _userWebClient.dislikeProject(
                                            project.id,
                                            user.id,
                                            token,
                                          );
                                        } else {
                                          await _userWebClient.likeProject(
                                            project.id,
                                            user.id,
                                            token,
                                          );

                                          project.participants
                                              .forEach((participant) async {
                                            if (participant.deviceToken !=
                                                    null &&
                                                participant is User) {
                                              await _notificationWebClient
                                                  .sendLikeNotification(
                                                participant.deviceToken,
                                                user.username,
                                              );
                                            }
                                          });
                                        }

                                        setState(() {
                                          _projectInfoScreenData =
                                              _getProjectInfoScreenData();
                                          likeIsLoading = false;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    width: 48,
                                    height: 48,
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                        primary: Theme.of(context).primaryColor,
                                        backgroundColor:
                                            ApplicationColors.iconButtonColor,
                                        padding: EdgeInsets.all(12),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(24),
                                        ),
                                      ),
                                      child: _defineSaveIcon(project, user),
                                      onPressed: () async {
                                        final token =
                                            await _tokenObject.getToken();

                                        setState(() {
                                          saveIsLoading = true;
                                        });

                                        if (project.savedBy
                                            .map((item) => item.id)
                                            .contains(user.id)) {
                                          await _userWebClient
                                              .removeSavedProject(
                                            project.id,
                                            user.id,
                                            token,
                                          );
                                        } else {
                                          await _userWebClient.saveProject(
                                            project.id,
                                            user.id,
                                            token,
                                          );
                                        }

                                        setState(() {
                                          _projectInfoScreenData =
                                              _getProjectInfoScreenData();
                                          saveIsLoading = false;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    width: 48,
                                    height: 48,
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                        primary: Theme.of(context).primaryColor,
                                        backgroundColor:
                                            ApplicationColors.iconButtonColor,
                                        padding: EdgeInsets.all(12),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(24),
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.question_answer_outlined,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        _navigator.navigate(
                                          context,
                                          SendMail(
                                            email: project.email,
                                            type: 'search',
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
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

  String _determineMainTeacherName(Project project) {
    if (project.mainTeacher != null) {
      return project.mainTeacher;
    } else if (project.mainTeacherName != null) {
      return project.mainTeacherName;
    } else {
      return 'Sem orientador (!)';
    }
  }

  String _determineSecondTeacherName(Project project) {
    if (project.secondTeacher != null) {
      return project.secondTeacher;
    } else if (project.secondTeacherName != null) {
      return project.secondTeacherName;
    } else {
      return 'Projeto sem coorientador.';
    }
  }

  Widget _participantsOfTheProject(Project project) {
    return Container(
      height: 44,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: project.participants.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(right: 5.0, left: 10),
            child: Ink(
              decoration: BoxDecoration(
                border: Border.all(
                  color: ApplicationColors.participantsTagColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: InkWell(
                onTap: () {
                  _handleParticipantTagClick(
                    context,
                    project.participants[index].id,
                  );
                },
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        project.participants[index].username,
                        style: ApplicationTypography.profileTags,
                      ),
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

  void _handleParticipantTagClick(BuildContext context, int id) {
    _navigator.navigate(
      context,
      Profile(
        type: 'user',
        id: id,
      ),
    );
  }

  Future<List<dynamic>> _getProjectInfoScreenData() {
    final response = Future.wait([
      _getProjectById(),
      _getUserData(),
    ]);

    return response;
  }

  Future<String> _getProjectById() async {
    final _webClient = ProjectWebClient();
    final token = await _tokenObject.getToken();

    final _project = await _webClient.getProjectById(widget.projectId, token);
    return _project;
  }

  Future<String> _getUserData() async {
    final _webClient = UserWebClient();
    final _token = await _tokenObject.getToken();
    final _user = await _webClient.getUserData(_token);
    return _user;
  }

  Widget _defineLikeIcon(Project project, User user) {
    if (likeIsLoading) {
      return CircularProgressIndicator();
    } else {
      if (project.likedBy.map((item) => item.id).contains(user.id)) {
        return Icon(
          Icons.favorite_outlined,
          color: Colors.red,
        );
      } else {
        return Icon(
          Icons.favorite_outline,
          color: ApplicationColors.editButtonColor,
        );
      }
    }
  }

  Widget _defineSaveIcon(Project project, User user) {
    if (saveIsLoading) {
      return CircularProgressIndicator();
    } else {
      if (project.savedBy.map((item) => item.id).contains(user.id)) {
        return Icon(
          Icons.bookmark_outlined,
          color: Colors.white,
        );
      } else {
        return Icon(
          Icons.bookmark_outline,
          color: ApplicationColors.editButtonColor,
        );
      }
    }
  }
}
