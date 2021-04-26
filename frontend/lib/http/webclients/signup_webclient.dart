import 'dart:convert';

import '../exceptions/http_exception.dart';
import '../webclient.dart';
import '../../models/user.dart';

class SignUpWebClient {
  Future<bool> signup(User user) async {
    final userJson = jsonEncode(user.toJson());

    final response = await client.post(
      baseUrl + '/user',
      headers: {'Content-Type': 'application/json'},
      body: userJson,
    );

    if (response.statusCode == 200) {
      return true;
    }

    throw HttpException(_statusCodeResponses[response.statusCode]);
  }

  static final Map<int, String> _statusCodeResponses = {
    500: 'Erro ao realizar cadastro: email já existente.',
  };
}
