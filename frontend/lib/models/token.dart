class Token {
  final String token;

  Token(this.token);

  Token.fromJson(Map<String, dynamic> json) : token = json["token"];
}
