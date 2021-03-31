import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStore {
  void store(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  void removeFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  Future<String> getFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    debugPrint(prefs.getString('token'));
    return prefs.getString('token') ?? 'none';
  }
}
