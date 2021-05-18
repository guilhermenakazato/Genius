import '../webclient.dart';

import '../../http/exceptions/http_exception.dart';

class UserWebClient {
  Future<String> getUserData(String token) async {
    final response = await client.get(
      baseUrl + '/get-data',
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      var data = response.body;
      return data;
    }

    throw HttpException('Erro desconhecido..');
  }
}
