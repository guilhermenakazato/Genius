import 'dart:convert';

import '../../models/user.dart';
import '../webclient.dart';
import '../../http/exceptions/http_exception.dart';

class UserWebClient {
  Future<String> getUserData(String token) async {
    final response = await client.get(
      baseUrl + '/get-data',
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      var data = response.body;
      return data;
    }

    throw HttpException('Erro desconhecido..');
  }

  Future<void> updateUser(User user, int userId) async {
    final userJson = jsonEncode(user.toJson());

    final response = await client.put(
      baseUrl + '/user/$userId',
      body: userJson,
      headers: {
        'Content-Type': 'application/json',
      }
    );

    if (response.statusCode == 200) {
      return response.body;
    }

    throw HttpException('Erro desconhecido..');
  }
}
