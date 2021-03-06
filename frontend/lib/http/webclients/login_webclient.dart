import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:genius/http/exceptions/http_exception.dart';
import 'package:genius/http/webclient.dart';
import 'package:genius/models/auth.dart';
import 'package:genius/models/token.dart';
import 'package:http/http.dart';

import "package:genius/utils/local_store.dart";

class LoginWebClient {
  Future<Token> login(Auth auth) async {
    final String authJson = jsonEncode(auth.toJson());
    final LocalStore localStore = LocalStore();

    final Response response = await client.post(
      baseUrl + "/login",
      headers: {"Content-Type": "application/json"},
      body: authJson,
    );

    if (response.statusCode == 200) {
      Token token = Token.fromJson(jsonDecode(response.body));
      localStore.store(token.token);

      return token;
    }

    print(response.statusCode);
    throw HttpException(_statusCodeResponses[response.statusCode]);
  }

  static final Map<int, String> _statusCodeResponses = {
    400: "Erro ao realizar o login! Verifique os campos preenchidos.",
    401: "Token inválido."
  };

  Future<bool> logged(String token) async {
    final Response response = await client.get(
      baseUrl + "/token",
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      return true;
    }

    // acho meio difícil acontecer algum erro aqui mas por segurança vou deixar isso
    print(response.statusCode);
    throw HttpException("Unknown Error");
  }

  // Retorna dados do usuário se estiver logado
  Future<String> getData(String token) async {
    final Response response = await client.get(
      baseUrl + "/getData",
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      String data = response.body;
      return data;
    }

    print(response.statusCode);
    throw HttpException("errinho brabo");
  }

  void logout(String token) async {
    final Response response = await client.get(
      baseUrl + "/logout",
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    // expirando token só por segurança
    if (response.statusCode == 200) {
      debugPrint("realizou Logout");
    }
  }

  // TODO: documentar
  Future<bool> check(String token) async {
    final Response response = await client.get(
      baseUrl + "/check",
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      // retorna verdadeiro ou falso. Se for falso, o usuário vai pra tela inicial pq o token é inválido
      return response.body == "true";
    }

    return false;
  }
}
