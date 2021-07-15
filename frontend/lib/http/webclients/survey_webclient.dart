import 'dart:convert';

import '../../models/survey.dart';
import '../exceptions/http_exception.dart';
import '../webclient.dart';

class SurveyWebClient {
  Future<void> updateSurvey(Survey survey, surveyId, String token) async {
    final surveyJson = jsonEncode(survey.toJson());

    final response = await client.put(
      Uri.parse(baseUrl + '/survey/$surveyId'),
      body: surveyJson,
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

  Future<void> createSurvey(Survey survey, int userId, String token) async {
    final surveyJson = jsonEncode(survey.toJson());

    final response = await client.post(
      Uri.parse(baseUrl + '/survey/$userId'),
      body: surveyJson,
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

  Future<void> deleteSurvey(int surveyId, String token) async {
    final response = await client.delete(
      Uri.parse(baseUrl + '/survey/$surveyId'), headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return response.body;
    }

    throw HttpException(_statusCodeResponses[response.statusCode]);
  }

  static final Map<int, String> _statusCodeResponses = {
    500: 'Erro de ponto nulo ao criar o questionário.'
  };
}
