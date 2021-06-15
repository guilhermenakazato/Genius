import '../models/user.dart';
import '../utils/convert.dart';
import 'tag.dart';

class Project {
  final int id;
  final String name, institution, startDate, mainTeacherName, secondTeacherName;
  final mainTeacher;
  final secondTeacher;
  final String abstractText;
  final List<User> participants;
  final List<User> deleteRequests;
  final List<Tag> tags;

  Project(
    this.id,
    this.name,
    this.mainTeacher,
    this.secondTeacher,
    this.institution,
    this.startDate,
    this.abstractText,
    this.participants,
    this.mainTeacherName,
    this.secondTeacherName,
    this.deleteRequests,
    this.tags,
  );

  Project.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        abstractText = json['abstract_text'],
        institution = json['institution'],
        startDate = json['start_date'],
        mainTeacher = json['main_teacher'],
        secondTeacher = json['second_teacher'],
        participants = Convert.convertToListOfUsers(json['participants']),
        mainTeacherName = json['main_teacher_name'],
        secondTeacherName = json['second_teacher_name'],
        deleteRequests = Convert.convertToListOfUsers(json['deleteRequests']),
        tags = Convert.convertToListOfTags(json['tags']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'institution': institution,
        'start_date': startDate,
        'main_teacher': mainTeacher,
        'second_teacher': secondTeacher,
        'main_teacher_name': mainTeacherName,
        'second_teacher_name': secondTeacherName,
      };

  @override
  String toString() {
    return 'Project: {id: $id, name: $name, abstractText: $abstractText, institution: $institution, startDate: $startDate, mainTeacher: $mainTeacher, secondTeacher: $secondTeacher, participants: $participants, mainTeacherName: $mainTeacherName, secondTeacherName: $secondTeacherName,}';
  }
}
