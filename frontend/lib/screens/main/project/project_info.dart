import 'package:flutter/material.dart';
import '../../../utils/application_typography.dart';
import '../../../models/project.dart';

class ProjectInfo extends StatelessWidget {
  final Project project;

  const ProjectInfo({Key key, this.project}) : super(key: key);

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
                            Icons.favorite_outlined,
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.bookmark_outlined,
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.question_answer_outlined,
                          ),
                          onPressed: () {},
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
}
