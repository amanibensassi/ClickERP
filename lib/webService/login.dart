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
      'http://erpdev.pingholding.com/wp-json/custom-api-route/authentication/?email=$mail&password=$pwd';

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
      // List<User> userList = [];
      // name = jsonData['user_nicename'];
      // if (name != '') {
      //   print("why do i even have this line");
      //   List<String> userData = [name];
      //   return userData;
      // } else {
      //   print("i have a feeling");
      //   // User is not authenticated
      //   return [];
      // }
    } else {
      //add a 404 page.
      return ['Failed'];
    }
  } catch (error) {
    return ['Network connexion failure'];
  }
}
