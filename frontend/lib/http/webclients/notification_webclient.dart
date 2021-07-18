import 'dart:convert';

import '../webclient.dart';

class NotificationWebClient {
  final firebaseMessagingToken =
      'AAAAKFtEQAc:APA91bEQ6eGvZdzzvXIuWheT_J4xNqYfnLrhMEdB4LGzU1xmNnMOOnAxUuX8ms9tPlHkFkI6khhOjMCP-JwdvzyqN4NtghZ_hVBmIdGqh5Ey_C3OrwXVsVCrQJxFSXCvFPHRmdODEN2e';

  Future<void> sendLikeNotification(String deviceToken, String username) async {
    await client.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: {
        'Authorization': 'key=$firebaseMessagingToken',
        'Content-Type': 'application/json',
      },
      body: notificationJson(
        deviceToken,
        'O usuário $username gostou do seu projeto.',
      ),
    );
  }

  Future<void> sendFollowNotification(
    String deviceToken,
    String username,
  ) async {
    await client.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: {
        'Authorization': 'key=$firebaseMessagingToken',
        'Content-Type': 'application/json',
      },
      body: notificationJson(
        deviceToken,
        'O usuário $username começou a te seguir.',
      ),
    );
  }

  Object notificationJson(String deviceToken, String message) {
    final data = {
      'notification': {
        'body': '$message',
        'title': 'Ei, mensagem do Genius!'
      },
      'priority': 'high',
      'data': {
        'clickaction': 'FLUTTERNOTIFICATIONCLICK',
        'id': '1',
        'status': 'done'
      },
      'to': '$deviceToken'
    };

    return json.encode(data);
  }
}
