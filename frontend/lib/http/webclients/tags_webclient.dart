import '../../http/exceptions/http_exception.dart';
import '../webclient.dart';

class TagsWebClient {
  Future<String> getAllTags() async {
    final response = await client.get(baseUrl + '/tags');

    if (response.statusCode == 200) {
      return response.body;
    }

    throw HttpException('Erro desconhecido..');
  }
}