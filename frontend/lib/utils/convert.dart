import 'dart:convert';

import 'package:flutter/material.dart';

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
      return 'Sem coorientador';
    } else {
      return User.fromJson(json);
    }
  }

  static List<User> convertToListOfParticipants(List list) {
    final listOfUser = list;

    final participants = listOfUser.map((dynamic json) {
      return User.fromJson(json);
    }).toList();

    return participants;
  }
}
