import 'dart:convert';

import '../../models/project.dart';
import '../../http/exceptions/http_exception.dart';
import '../webclient.dart';

class ProjectWebClient {
  Future<String> getAllProjects() async {
    final response = await client.get(baseUrl + '/projects');

    if (response.statusCode == 200) {
      return response.body;
    }

    throw HttpException('Erro desconhecido..');
  }

  Future<bool> createProject(Project project, int creatorId) async {
    final projectJson = jsonEncode(project.toJson());

    final response = await client.post(
      baseUrl + '/project/$creatorId',
      body: projectJson,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 404) {
      throw HttpException(jsonDecode(response.body)['error']);
    }

    throw HttpException(_statusCodeResponses[response.statusCode]);
  }

  Future<void> updateSurvey(Project project, projectId) async {
    final projectJson = jsonEncode(project.toJson());

    final response = await client.put(
      baseUrl + '/project/$projectId',
      body: projectJson,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return response.body;
    }

    throw HttpException('Erro desconhecido..');
  }

  Future<bool> verifyIfProjectTitleAlreadyExists(String title) async {
    final response = await client.post(
      baseUrl + '/verify/',
      body: {
        'project_title': '$title',
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 404) {
      return false;
    }

    throw HttpException('Erro desconhecido...');
  }

  static final Map<int, String> _statusCodeResponses = {
    500: 'Erro de ponto nulo ao criar o questionário.'
  };
}
