import '../models/user.dart';
import '../utils/convert.dart';

class Project {
  final int id;
  final String name, institution, startDate, mainTeacherName, secondTeacherName, email, participantsFullName;
  final mainTeacher;
  final secondTeacher;
  final String abstractText;
  final List<dynamic> participants;
  final List<User> deleteRequests;
  final List<dynamic> tags;

  Project({
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
    this.email, 
    this.participantsFullName
  });

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
        tags = Convert.convertToListOfTags(json['tags']),
        email = json['email'],
        participantsFullName = json['participants_full_name'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'institution': institution,
        'start_date': startDate,
        'main_teacher': mainTeacher,
        'second_teacher': secondTeacher,
        'main_teacher_name': mainTeacherName,
        'second_teacher_name': secondTeacherName,
        'participants': participants, 
        'tags': tags,
        'abstract_text': abstractText,
        'email': email,
        'participants_full_name': participantsFullName,
      };

  @override
  String toString() {
    return 'Project: {id: $id, name: $name, abstractText: $abstractText, institution: $institution, startDate: $startDate, mainTeacher: $mainTeacher, secondTeacher: $secondTeacher, participants: $participants, mainTeacherName: $mainTeacherName, secondTeacherName: $secondTeacherName, email: $email, participantsFullName: $participantsFullName}';
  }
}
