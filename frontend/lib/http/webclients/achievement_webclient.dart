import 'dart:convert';

import '../../models/achievement.dart';
import '../../http/exceptions/http_exception.dart';
import '../webclient.dart';

class AchievementWebClient {
  Future<void> createAchievement(Achievement achievement, int userId, String token) async {
    final achievementJson = jsonEncode(achievement.toJson());

    final response = await client.post(
      Uri.parse(baseUrl + '/achievement/$userId'),
      body: achievementJson,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      return response.body;
    }

    throw HttpException(_statusCodeResponses[response.statusCode]);
  }

  Future<void> deleteAchievement(int achievementId, String token) async {
    final response = await client.delete(
      Uri.parse(baseUrl + '/achievement/$achievementId'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return response.body;
    }

    throw HttpException(_statusCodeResponses[response.statusCode]);
  }

  static final Map<int, String> _statusCodeResponses = {
    500: 'Erro de ponto nulo ao criar o questionário.'
  };

  Future<void> updateAchievement(Achievement achievement, achievementId, String token) async {
    final achievementJson = jsonEncode(achievement.toJson());

    final response = await client.put(
      Uri.parse(baseUrl + '/achievement/$achievementId'),
      body: achievementJson,
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
}
