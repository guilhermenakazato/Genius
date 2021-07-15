import 'dart:convert';

import '../../models/project.dart';
import '../../http/exceptions/http_exception.dart';
import '../webclient.dart';

class ProjectWebClient {
  Future<String> getAllProjects(String token) async {
    final response = await client.get(
      Uri.parse(baseUrl + '/projects'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return response.body;
    }

    throw HttpException('Erro desconhecido..');
  }

  Future<String> getProjectById(int projectId, String token) async {
    final response = await client.get(
      Uri.parse(baseUrl + '/project/$projectId'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return response.body;
    }

    throw HttpException('Erro desconhecido..');
  }

  Future<bool> createProject(Project project, int creatorId, String token) async {
    final projectJson = jsonEncode(project.toJson());

    final response = await client.post(
      Uri.parse(baseUrl + '/project/$creatorId'),
      body: projectJson,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 404) {
      throw HttpException(jsonDecode(response.body)['error']);
    }

    throw HttpException(_statusCodeResponses[response.statusCode]);
  }

  Future<bool> updateProject(Project project, projectId, String token) async {
    final projectJson = jsonEncode(project.toJson());

    final response = await client.put(
      Uri.parse(baseUrl + '/project/$projectId'),
      body: projectJson,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
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

  Future<void> updateDeleteRequest(int projectId, int userId, String token) async {
    await client.put(
      Uri.parse(
        baseUrl + '/project/$projectId/$userId',
      ),
      headers: {'Authorization': 'Bearer $token'}
    );
  }

  Future<void> deleteProject(int projectId, String token) async {
    await client.delete(
      Uri.parse(
        baseUrl + '/project/$projectId',
      ),
      headers: {'Authorization': 'Bearer $token'}
    );
  }
}
