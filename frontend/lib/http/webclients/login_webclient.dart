import 'dart:convert';

import '../exceptions/http_exception.dart';
import '../webclient.dart';
import '../../models/auth.dart';
import '../../models/jwt_token.dart';

class LoginWebClient {
  Future<JwtToken> login(Auth auth) async {
    final authJson = jsonEncode(auth.toJson());

    final response = await client.post(
      Uri.parse(baseUrl + '/login'),
      headers: {'Content-Type': 'application/json'},
      body: authJson,
    );

    if (response.statusCode == 200) {
      var token = JwtToken.fromJson(jsonDecode(response.body));
      token.setToken(token.jwtToken);

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
      Uri.parse(baseUrl + '/token'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return true;
    }

    throw HttpException('Unknown Error');
  }

  Future<void> logout(String token) async {
    await client.get(
      Uri.parse(baseUrl + '/logout'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
  }

  Future<bool> check(String token) async {
    final response = await client.get(
      Uri.parse(baseUrl + '/check'),
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
