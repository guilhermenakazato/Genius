import 'dart:convert';

import '../../models/project.dart';
import '../../http/exceptions/http_exception.dart';
import '../webclient.dart';

class ProjectWebClient {
  Future<String> getAllProjects() async {
    final response = await client.get(Uri.parse(baseUrl + '/projects'));

    if (response.statusCode == 200) {
      return response.body;
    }

    throw HttpException('Erro desconhecido..');
  }

  Future<String> getProjectById(int projectId) async {
    final response = await client.get(
      Uri.parse(baseUrl + '/project/$projectId'),
    );

    if (response.statusCode == 200) {
      return response.body;
    }

    throw HttpException('Erro desconhecido..');
  }

  Future<bool> createProject(Project project, int creatorId) async {
    final projectJson = jsonEncode(project.toJson());

    final response = await client.post(
      Uri.parse(baseUrl + '/project/$creatorId'),
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

  Future<bool> updateProject(Project project, projectId) async {
    final projectJson = jsonEncode(project.toJson());

    final response = await client.put(
      Uri.parse(baseUrl + '/project/$projectId'),
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

  Future<bool> verifyIfProjectTitleAlreadyExists(String title) async {
    final response = await client.post(
      Uri.parse(baseUrl + '/verify/'),
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

  Future<bool> verifyIfProjectEmailIsAlreadyBeingUsed(String email) async {
    final response = await client.get(
      Uri.parse(baseUrl + '/verify/$email'),
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

  Future<void> updateDeleteRequest(int projectId, int userId) async {
    await client.put(
      Uri.parse(
        baseUrl + '/project/$projectId/$userId',
      ),
    );
  }

  Future<void> deleteProject(int projectId) async {
    await client.delete(
      Uri.parse(
        baseUrl + '/project/$projectId',
      ),
    );
  }
}
