import 'dart:convert';

import '../../models/user.dart';
import '../webclient.dart';
import '../../http/exceptions/http_exception.dart';

class UserWebClient {
  Future<String> getUserData(String token) async {
    final response = await client.get(
      Uri.parse(baseUrl + '/get-data'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      var data = response.body;
      return data;
    }

    throw HttpException('Erro desconhecido..');
  }

  Future<String> getUserById(int id, String token) async {
    final response = await client.get(
      Uri.parse(baseUrl + '/user/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      var data = response.body;
      return data;
    }

    throw HttpException('Erro desconhecido..');
  }

  Future<void> updateUser(User user, int userId, String token) async {
    final userJson = jsonEncode(user.toJson());

    final response = await client.put(
      Uri.parse(baseUrl + '/user/$userId'),
      body: userJson,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      return response.body;
    }

    throw HttpException('Erro desconhecido..');
  }

  Future<String> getAllUsers(String token) async {
    final response = await client.get(
      Uri.parse(baseUrl + '/users'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return response.body;
    }

    throw HttpException('Erro desconhecido..');
  }

  Future<void> deleteUser(int userId, String token) async {
    await client.delete(
      Uri.parse(baseUrl + '/user/$userId'),
      headers: {'Authorization': 'Bearer $token'},
    );

    throw HttpException('Erro desconhecido..');
  }

  Future<void> follow(int userId, int followerId, String token) async {
    final data = <String, dynamic>{};
    data['user_id'] = userId;
    data['follower_id'] = followerId;

    await client.post(
      Uri.parse(baseUrl + '/follow'),
      body: json.encode(data),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
  }

  Future<void> unfollow(
      int userId, int followerId, bool removingFollower, String token) async {
    final data = <String, dynamic>{};
    data['user_id'] = userId;
    data['follower_id'] = followerId;
    data['removing_follower'] = removingFollower;

    await client.post(
      Uri.parse(baseUrl + '/unfollow'),
      body: json.encode(data),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
  }

  Future<void> likeProject(int projectId, userId, String token) async {
    final data = <String, dynamic>{};
    data['projectId'] = projectId;
    data['userId'] = userId;

    await client.post(
      Uri.parse(baseUrl + '/like'),
      body: json.encode(data),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
  }

  Future<void> dislikeProject(int projectId, userId, String token) async {
    final data = <String, dynamic>{};
    data['projectId'] = projectId;
    data['userId'] = userId;

    await client.post(
      Uri.parse(baseUrl + '/dislike'),
      body: json.encode(data),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
  }

  Future<void> saveProject(int projectId, userId, String token) async {
    final data = <String, dynamic>{};
    data['projectId'] = projectId;
    data['userId'] = userId;

    await client.post(
      Uri.parse(baseUrl + '/save-project'),
      body: json.encode(data),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
  }

  Future<void> removeSavedProject(int projectId, userId, String token) async {
    final data = <String, dynamic>{};
    data['projectId'] = projectId;
    data['userId'] = userId;

    await client.post(
      Uri.parse(baseUrl + '/remove-save-project'),
      body: json.encode(data),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
  }

  Future<void> changePassword(String password, String token, int userId) async {
    final response = await client.put(
      Uri.parse(baseUrl + '/password/$userId'),
      body: {
        'password': '$password',
      },
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw HttpException('Erro desconhecido..');
    }
  }

  Future<void> setDeviceToken(
    String deviceToken,
    String jwtToken,
    int userId,
  ) async {
    final data = <String, dynamic>{};
    data['device_token'] = deviceToken;

    final response = await client.put(
      Uri.parse(baseUrl + '/device-token/$userId'),
      body: json.encode(data),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken',
      },
    );

    if (response.statusCode != 200) {
      throw HttpException('Erro desconhecido...');
    }
  }
}
