import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStore {
  void store(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
  }

  void removeFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
  }

  Future<String> getFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    debugPrint(prefs.getString("token"));
    return prefs.getString("token") ?? "none";
  }
}
