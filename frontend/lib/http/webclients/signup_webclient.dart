import 'dart:convert';

import '../exceptions/http_exception.dart';
import '../webclient.dart';
import '../../models/user.dart';

class SignUpWebClient {
  Future<bool> signup(User user) async {
    final userJson = jsonEncode(user.toJsonCreateUser());

    final response = await client.post(
      Uri.parse(baseUrl + '/user'),
      headers: {'Content-Type': 'application/json'},
      body: userJson,
    );

    if (response.statusCode == 200) {
      return true;
    }

    throw HttpException(_statusCodeResponses[response.statusCode]);
  }

  Future<bool> verifyIfUsernameAlreadyExists(String username) async {
    final response = await client.get(
      Uri.parse(baseUrl + '/user-username/$username'),
    );

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 404) {
      return false;
    }

    throw HttpException('Erro desconhecido...');
  }

  Future<bool> verifyIfEmailAlreadyExists(String email) async {
    final response = await client.get(
      Uri.parse(baseUrl + '/user-email/$email'),
    );

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 404) {
      return false;
    }

    throw HttpException('Erro desconhecido...');
  }

  static final Map<int, String> _statusCodeResponses = {
    
  };
}
