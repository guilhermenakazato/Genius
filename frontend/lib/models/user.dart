import '../utils/convert.dart';
import 'project.dart';
import 'achievement.dart';
import 'survey.dart';

class User {
  String name,
      username,
      email,
      password,
      type,
      age,
      local,
      institution,
      formation,
      bio, 
      verified;
  int id;
  List<Project> projects;
  List<Achievement> achievements;
  List<Project> saved;
  List<Survey> surveys;
  final tags;
  List<User> followers, following;

  User({
    this.name,
    this.username,
    this.email,
    this.password,
    this.type,
    this.age,
    this.local,
    this.institution,
    this.formation,
    this.bio,
    this.tags,
  });

  void setName(String name) {
    this.name = name;
  }

  void setUsername(String username) {
    this.username = username;
  }

  void setEmail(String email) {
    this.email = email;
  }

  void setPassword(String password) {
    this.password = password;
  }

  void setType(String type) {
    this.type = type;
  }

  void setAge(String age) {
    this.age = age;
  }

  void setLocal(String local) {
    this.local = local;
  }

  void setInstitution(String institution) {
    this.institution = institution;
  }

  void setFormation(String formation) {
    this.formation = formation;
  }

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        username = json['username'],
        email = json['email'],
        password = json['password'],
        type = json['type'],
        age = json['age'],
        local = json['local'],
        institution = json['institution'],
        formation = json['formation'],
        bio = json['bio'],
        projects = Convert.convertToListOfProjects(json['projects']),
        achievements =
            Convert.convertToListOfAchievements(json['achievements']),
        saved = Convert.convertToListOfSavedProjects(json['saved']),
        surveys = Convert.convertToListOfSurveys(json['surveys']),
        tags = Convert.convertToListOfTags(json['tags']),
        verified = json['verified'],
        followers = Convert.convertToListOfUsers(json['followers']),
        following = Convert.convertToListOfUsers(json['following']); 

  Map<String, dynamic> toJson() => {
        'name': name,
        'username': username,
        'email': email,
        'password': password,
        'type': type,
        'age': age,
        'local': local,
        'institution': institution,
        'formation': formation,
        'bio': bio,
        'tags': tags,
      };

  @override
  String toString() {
    return 'User: {username: $username, email: $email, password: $password, type: $type, age: $age, local: $local, institution: $institution, formação: $formation, bio: $bio, projects: $projects}';
  }
}
