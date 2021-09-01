import 'package:shared_preferences/shared_preferences.dart';

class JwtToken {
  final String jwtToken;

  JwtToken({this.jwtToken});

  JwtToken.fromJson(Map<String, dynamic> json) : jwtToken = json['token'];

  void setToken(String jwtToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', jwtToken);
  }

  Future<void> eraseToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? 'none';
  }
}
