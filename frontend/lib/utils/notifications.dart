import 'package:shared_preferences/shared_preferences.dart';

class Notifications {
  static Future<void> setNotificationPreference(bool notificationIsOn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notification-on', notificationIsOn);
  }

  static Future<bool> getNotificationPreference() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('notification-on') ?? true;
  }
}