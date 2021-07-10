import 'package:flutter/material.dart';
import 'package:genius/utils/application_colors.dart';
import 'package:genius/utils/navigator_util.dart';
import '../../../utils/application_typography.dart';
import '../../../models/project.dart';
import '../profile.dart';
import '../send_mail.dart';

class ProjectInfo extends StatelessWidget {
  final Project project;
  final _navigator = NavigatorUtil();

  ProjectInfo({Key key, @required this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      body: Align(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    top: 60,
                    left: 30,
                    right: 30,
                  ),
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      project.name,
                      style: ApplicationTypography.projectNameText,
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        _participantsOfTheProject(),
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0, right: 30),
                          child: Container(
                            width: double.infinity,
                            child: Text(
                              'Orientador: ${_determineMainTeacherName()}',
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0, right: 30),
                          child: Container(
                            width: double.infinity,
                            child: Text(
                              'Coorientador: ${_determineSecondTeacherName()}',
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0, right: 30),
                          child: Container(
                            width: double.infinity,
                            child: Text(
                              'Estudantes pesquisadores: ${project.participantsFullName}',
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 10, 30, 0),
                          child: Container(
                            width: double.infinity,
                            child: Text(
                              project.abstractText,
                              style: ApplicationTypography.projectAbstractText,
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
                        IconButton(
                          icon: const Icon(
                            Icons.favorite_outline,
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.bookmark_outline,
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.question_answer_outlined,
                          ),
                          onPressed: () {
                            _navigator.navigate(
                              context,
                              SendMail(email: project.email, type: 'search'),
                            );
                          },
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
    );
  }

  String _determineMainTeacherName() {
    if (project.mainTeacher != null) {
      return project.mainTeacher;
    } else if (project.mainTeacherName != null) {
      return project.mainTeacherName;
    } else {
      return 'Sem orientador (!)';
    }
  }

  String _determineSecondTeacherName() {
    if (project.secondTeacher != null) {
      return project.secondTeacher;
    } else if (project.secondTeacherName != null) {
      return project.secondTeacherName;
    } else {
      return 'Projeto sem coorientador.';
    }
  }

  Widget _participantsOfTheProject() {
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
}
