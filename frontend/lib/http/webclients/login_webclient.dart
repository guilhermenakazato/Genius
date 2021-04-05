import 'dart:convert';

import '../exceptions/http_exception.dart';
import '../webclient.dart';
import '../../models/auth.dart';
import '../../models/token.dart';

class LoginWebClient {
  Future<Token> login(Auth auth) async {
    final authJson = jsonEncode(auth.toJson());

    final response = await client.post(
      baseUrl + '/login',
      headers: {'Content-Type': 'application/json'},
      body: authJson,
    );

    if (response.statusCode == 200) {
      var token = Token.fromJson(jsonDecode(response.body));
      token.setToken(token.token);

      return token;
    }

    throw HttpException(_statusCodeResponses[response.statusCode]);
  }

  static final Map<int, String> _statusCodeResponses = {
    400: 'Erro ao realizar o login! Verifique os campos preenchidos.',
    401: 'Token inválido.'
  };

  Future<bool> userIsLogged(String token) async {
    final response = await client.get(
      baseUrl + '/token',
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return true;
    }

    throw HttpException('Unknown Error');
  }

  Future<String> getUserData(String token) async {
    final response = await client.get(
      baseUrl + '/getData',
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      var data = response.body;
      return data;
    }

    throw HttpException('Erro desconhecido..');
  }

  void logout(String token) async {
    await client.get(
      baseUrl + '/logout',
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
  }

  Future<bool> check(String token) async {
    final response = await client.get(
      baseUrl + '/check',
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return response.body == 'true';
    }

    return false;
  }
}
