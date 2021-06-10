import 'dart:convert';

import 'package:genius/models/achievement.dart';

import '../models/survey.dart';
import '../models/user.dart';
import '../models/project.dart';

class Convert {
  static List<Project> convertStringToListofTypeProject(String text) {
    final List<dynamic> decodedJson = jsonDecode(text);

    final projects = decodedJson.map((dynamic json) {
      return Project.fromJson(json);
    }).toList();

    return projects;
  }

  static dynamic convertJsonToUserWithVerification(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    } else {
      return User.fromJson(json);
    }
  }

  static List<User> convertToListOfParticipants(List list) {
    if (list == null) {
      return null;
    } 
    
    final participants = list.map((dynamic json) {
      return User.fromJson(json);
    }).toList();

    return participants;
  }

  static List<Project> convertToListOfProjects(List list) {
    if (list == null) {
      return list;
    } else {
      final projects = list.map((dynamic json) {
        return Project.fromJson(json);
      }).toList();

      return projects;
    }
  }

  static List<Project> convertToListOfSavedProjects(List list) {
    if (list == null) {
      return list;
    } else {
      final savedProjects = list.map((dynamic json) {
        return Project.fromJson(json);
      }).toList();

      return savedProjects;
    }
  }

  static List<Survey> convertToListOfSurveys(List list) {
    if (list == null) {
      return list;
    } else {
      final surveys = list.map((dynamic json) {
        return Survey.fromJson(json);
      }).toList();

      return surveys;
    }
  }

  static List<Achievement> convertToListOfAchievements(List list) {
    if (list == null) {
      return list;
    } else {
      final achievements = list.map((dynamic json) {
        return Achievement.fromJson(json);
      }).toList();

      return achievements;
    }
  }
}
