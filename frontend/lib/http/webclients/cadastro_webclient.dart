import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:genius/http/exceptions/http_exception.dart';
import 'package:genius/http/webclient.dart';
import 'package:genius/models/user.dart';
import 'package:http/http.dart';

class CadastroWebClient {
  Future<bool> cadastro(User user) async {
    final String userJson = jsonEncode(user.toJson());

    final Response response = await client.post(
      baseUrl + "/usuario",
      headers: {"Content-Type": "application/json"},
      body: userJson,
    );

    if (response.statusCode == 200) {
      debugPrint("Cadastro realizado com sucesso!");
      return true;
    }

    print(response.statusCode);
    throw HttpException(_statusCodeResponses[response.statusCode]);
  }

  static final Map<int, String> _statusCodeResponses = {
    500: "Erro ao realizar cadastro: email já existente.",
  };
}
