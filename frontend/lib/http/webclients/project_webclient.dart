import 'dart:convert';

import 'package:genius/models/feed_projects.dart';
import 'package:genius/utils/convert.dart';

import '../../models/project.dart';
import '../../http/exceptions/http_exception.dart';
import '../webclient.dart';

class ProjectWebClient {
  Future<FeedProjects> getAllProjects() async {
    final response = await client.get(baseUrl + '/projects');
    final projects = Convert.convertStringToListofTypeProject(response.body);

    if (response.statusCode == 200) {
      return FeedProjects(projects);
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

  Future<bool> updateProject(Project project, projectId) async {
    final projectJson = jsonEncode(project.toJson());

    final response = await client.put(
      baseUrl + '/project/$projectId',
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

  Future<bool> verifyIfProjectEmailIsAlreadyBeingUsed(String email) async {
    final response = await client.get(
      baseUrl + '/verify/$email',
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
