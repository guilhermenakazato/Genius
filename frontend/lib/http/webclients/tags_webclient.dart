import '../../http/exceptions/http_exception.dart';
import '../webclient.dart';

class TagsWebClient {
  Future<String> getAllTags(String token) async {
    final response = await client.get(
      Uri.parse(baseUrl + '/tags'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return response.body;
    }

    throw HttpException('Erro desconhecido..');
  }
}
