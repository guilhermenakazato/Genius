class User {
  String username, email, password, type, age, local;

  User(
      {this.username,
      this.email,
      this.password,
      this.type,
      this.age,
      this.local});

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

  // TODO: documentar
  void setLocal(String local) {
    this.local = local;
  }

  User.fromJson(Map<String, dynamic> json)
      : username = json["username"],
        email = json["email"],
        password = json["password"],
        type = json["type"],
        age = json["age"],
        local = json["local"];

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "password": password,
        "type": type,
        "age": age,
        "local": local,
      };

  @override
  String toString() {
    return "User: {username: $username, email: $email, password: $password, type: $type, age: $age, local: $local}";
  }
}
