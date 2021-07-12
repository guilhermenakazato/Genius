import 'package:flutter/cupertino.dart';
import 'package:genius/models/project.dart';

class FeedProjects extends ChangeNotifier {
  final List<Project> _feedProjects;

  List<Project> getFeedProjects() {
    return _feedProjects;
  }

  FeedProjects(this._feedProjects);

  @override
  String toString() {
    return _feedProjects.toString();
  }
}
