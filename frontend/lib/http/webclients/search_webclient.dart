import 'dart:convert';

import '../../http/exceptions/http_exception.dart';
import '../webclient.dart';

class SearchWebClient {
  Future<String> search(
    String searchText,
    List<String> filterTags,
    bool showUsers,
    bool showProjects,
    String token
  ) async {
    final data = <String, dynamic>{};
    data['filter_tags'] = filterTags;
    data['search_text'] = searchText;
    data['show_users'] = showUsers;
    data['show_projects'] = showProjects;

    final response = await client.post(
      Uri.parse(baseUrl + '/search'),
      body: json.encode(data),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      return response.body;
    }

    throw HttpException('Erro desconhecido...');
  }
}
