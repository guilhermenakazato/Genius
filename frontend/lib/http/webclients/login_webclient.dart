import 'dart:convert';

import 'package:Genius/http/webclient.dart';
import 'package:Genius/models/auth.dart';
import 'package:Genius/models/token.dart';
import 'package:http/http.dart';

class LoginWebClient {
  Future<Token> login(Auth auth) async {
    final String authJson = jsonEncode(auth.toJson());

    final Response response = await client.post(baseUrl + "/login",
        headers: {"Content-Type": "application/json"}, body: authJson);

    if (response.statusCode == 200) {
      return Token.fromJson(jsonDecode(response.body));
    }

    print(response.statusCode);
    // TODO: especificar erros pq eu sei sim
    throw HttpException("Unknown Error");
  }

  Future<bool> logged(String token) async {
    final Response response = await client
        .post(baseUrl + "/token", headers: {"Authorization": "Bearer $token"});

    if (response.statusCode == 200) {
      return true;
    }

    print(response.statusCode);
    // TODO: dps eu especifico isso
    throw HttpException("Unknown Error");
  }
}

// deixando a exceção mais específica
class HttpException implements Exception {
  final String message;

  HttpException(this.message);
}
