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

  Future<String> getUserById(int id) async {
    final response = await client.get(
      baseUrl + '/user/$id',
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
      },
    );

    if (response.statusCode == 200) {
      return response.body;
    }

    throw HttpException('Erro desconhecido..');
  }

  Future<String> getAllUsers() async {
    final response = await client.get(baseUrl + '/users');

    if (response.statusCode == 200) {
      return response.body;
    }

    throw HttpException('Erro desconhecido..');
  }

  Future<void> deleteUser(int userId) async {
    await client.delete(
      baseUrl + '/user/$userId',
    );

    throw HttpException('Erro desconhecido..');
  }

  Future<void> follow(int userId, int followerId) async {
    final data = <String, dynamic>{};
    data['user_id'] = userId;
    data['follower_id'] = followerId;

    await client.post(
      baseUrl + '/follow',
      body: json.encode(data),
      headers: {
        'Content-Type': 'application/json',
      },
    );
  }

  Future<void> unfollow(
      int userId, int followerId, bool removingFollower) async {
    final data = <String, dynamic>{};
    data['user_id'] = userId;
    data['follower_id'] = followerId;
    data['removing_follower'] = removingFollower;

    await client.post(
      baseUrl + '/unfollow',
      body: json.encode(data),
      headers: {
        'Content-Type': 'application/json',
      },
    );
  }
}
