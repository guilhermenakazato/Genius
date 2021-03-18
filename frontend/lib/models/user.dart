// TODO: documentar

class User {
  String username, email, password, type, age, local, instituicao, formacao;

  User({
    this.username,
    this.email,
    this.password,
    this.type,
    this.age,
    this.local,
    this.instituicao, 
    this.formacao
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

  void setInstituicao(String instituicao) {
    this.instituicao = instituicao;
  }

  void setFormacao(String formacao) {
    this.formacao = formacao;
  }


  User.fromJson(Map<String, dynamic> json)
      : username = json["username"],
        email = json["email"],
        password = json["password"],
        type = json["type"],
        age = json["age"],
        local = json["local"],
        instituicao = json["instituicao"],
        formacao = json["formacao"];

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "password": password,
        "type": type,
        "age": age,
        "local": local,
        "instituicao": instituicao,
        "formacao": formacao,
      };

  @override
  String toString() {
    return "User: {username: $username, email: $email,"+ 
    "password: $password, type: $type, age: $age," + 
    "local: $local, instituicao: $instituicao, formação: $formacao}";
  }
}
