import 'package:shared_preferences/shared_preferences.dart';

class Token {
  final String token;

  Token({this.token});

  Token.fromJson(Map<String, dynamic> json) : token = json['token'];

  void setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? 'none';
  }
}
