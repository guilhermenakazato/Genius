class User {
  String username, email, password, type, age, local, institution, formation;

  User({
    this.username,
    this.email,
    this.password,
    this.type,
    this.age,
    this.local,
    this.institution, 
    this.formation
  });

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
      : username = json['username'],
        email = json['email'],
        password = json['password'],
        type = json['type'],
        age = json['age'],
        local = json['local'],
        institution = json['institution'],
        formation = json['formation'];

  Map<String, dynamic> toJson() => {
        'username': username,
        'email': email,
        'password': password,
        'type': type,
        'age': age,
        'local': local,
        'institution': institution,
        'formation': formation,
      };

  @override
  String toString() {
    return 'User: {username: $username, email: $email, password: $password, type: $type, age: $age, local: $local, institution: $institution, formação: $formation}';
  }
}
