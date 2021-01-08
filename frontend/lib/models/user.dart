class User {
  final String username, email, password, type, age, local;

  User(this.username, this.email, this.password, this.type, this.age,
      this.local);

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
}
