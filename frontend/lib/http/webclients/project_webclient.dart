import '../../http/exceptions/http_exception.dart';
import '../../models/project.dart';
import '../webclient.dart';

class ProjectWebClient {
  Future<String> getAllProjects() async {
    final response = await client.get(baseUrl + '/projects');

    if (response.statusCode == 200) {
      return response.body;
    }

    throw HttpException('Erro desconhecido..');
  }
}
