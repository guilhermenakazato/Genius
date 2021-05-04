import 'package:flutter/material.dart';
import '../../../models/project.dart';

class ProjectInfo extends StatelessWidget {
  final Project project;

  const ProjectInfo({Key key, this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      body: Align(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60, left: 30),
              child: Container(
                width: double.infinity,
                child: Text(
                  project.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 10, 30, 0),
              child: Text(
                project.abstractText,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
