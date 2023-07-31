import 'package:http/http.dart' as http;
import 'dart:convert';

Future<bool> sendNotification(
    String fcmToken, String title, String body) async {
  final url = Uri.parse('https://fcm.googleapis.com/fcm/send');
  const apiKey =
      'AAAAcZew7Wo:APA91bEGZln-e6xNC1U6hmewPoyoft7ceUVpTKKBYzoQuz_Myhil1XxuqiuGcPafmEt7yymAlJuEsM4wcfNrdR7XYtzcH3j-5HxEt_7X2YH9aGT-3x0VNzlbkjxW_Q-P3UQIJbfDOeNP';
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'key=$apiKey',
  };

  final bodyData = {
    'to': fcmToken,
    'notification': {
      'title': title,
      'body': body,
    },
    'android': {
      'priority': 'high',
      'notification': {
        'sound': 'default',
      },
    },
    'apns': {
      'payload': {
        'aps': {
          'sound': 'default',
        },
      },
    },
  };
  final response =
      await http.post(url, headers: headers, body: jsonEncode(bodyData));
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
    // print('Failed to send notification. Error: ${response.statusCode}');
  }
}
