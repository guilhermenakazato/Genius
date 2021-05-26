import 'dart:convert';

import '../../models/survey.dart';
import '../exceptions/http_exception.dart';
import '../webclient.dart';

class SurveyWebClient {
  Future<void> updateProject(Survey survey, surveyId) async {
    final surveyJson = jsonEncode(survey.toJson());

    final response = await client.put(
      baseUrl + '/survey/$surveyId',
      body: surveyJson,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return response.body;
    }

    throw HttpException('Erro desconhecido..');
  }

  Future<void> createProject(Survey survey, int userId) async {
    final surveyJson = jsonEncode(survey.toJson());

    final response = await client.post(
      baseUrl + '/survey/$userId',
      body: surveyJson,
      headers: {
        'Content-Type': 'application/json',
      },
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
