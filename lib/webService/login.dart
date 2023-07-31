import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import '../controllers/authentification_controller.dart';

void saveToSession(String key, dynamic value) async {
  await SessionManager().set(key, value);
}

void restartSession() async {
  await SessionManager().destroy();
}

Future<dynamic> getFromSession(String key) async {
  return await SessionManager().get(key);
}

// void useSessionValue() async {
//   dynamic value = await getFromSession('your_key');
//   // Do something with the retrieved value
//   // print(value);
// }

Future<List<String>> fetchData(String mail, String pwd) async {
  // print('this mail : $mail and password : $pwd');
  var url =
      'http://erp.pingholding.com/wp-json/custom-api-route/authentication/?email=$mail&password=$pwd';

  String name = '';
  try {
    var response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      if (response.body != 'false') {
        saveToSession('name', jsonData['user_nicename']);
        saveToSession('id', jsonData['ID']);
        saveToSession('status', jsonData['user_status']);
        name = jsonData['user_nicename'];
        List<String> userData = [name];
        return userData;
      } else {
        return [];
      }
    } else {
      return ['Failed'];
    }
  } catch (error) {
    return ['Network connexion failure'];
  }
}
