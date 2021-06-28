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
}
