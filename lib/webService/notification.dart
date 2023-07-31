import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:notification/webService/login.dart';

Future<List<Map<String, dynamic>>> fNotificationTR() async {
  final int iduser = await getFromSession('id');
  List<Map<String, dynamic>> meetstab = [
    {"1": "1"}
  ];
  // var url =
  //     'http://erpdev.pingholding.com/wp-json/custom-api-route/getNotificationTache/?id_user=$iduser';
  var url =
      'http://erp.pingholding.com/wp-json/custom-api-route/getNotificationTache/?id_user=$iduser';
  try {
    var response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      if (jsonData.toString() != false.toString()) {
        if (jsonData is List) {
          meetstab = [];
          for (var item in jsonData) {
            Map<String, dynamic> task = {
              'idNotification': item['idNotification'],
              'nature': item['nature'],
              'id': item['idtache'],
              'code': item['code_tache'],
              'designation': item['designation'],
              'd_d': item['date_debut'],
              'd_f': item['date_echeance'],
              'd_d1': item['date_debut1'],
              'd_f1': item['date_echeance1'],
              'priorite': item['priorite'],
              'status': item['statut'],
              'personnels': item['personnels'],
              'desc': item['description'],
              'etape_id': item['etape_id'],
              'projet_id': item['projetID'],
              'nb_fich': item['nbr_fichier'],
              'user': item['user'],
            };
            meetstab.add(task);
          }
        }
      } else {
        meetstab = [
          {"empty": "table"}
        ];
      }
      return meetstab;
    } else {
      return meetstab;
    }
  } catch (error) {
    return meetstab;
  }
}

Future<List<Map<String, dynamic>>> fNotificationReunion() async {
  final int iduser = await getFromSession('id');
  List<Map<String, dynamic>> meetstab = [
    {"1": "1"}
  ];
  var url =
      'http://erpdev.pingholding.com/wp-json/custom-api-route/getNotificationReunion/?id_user=$iduser';
  try {
    var response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      if (jsonData.toString() != false.toString()) {
        if (jsonData is List) {
          meetstab = [];
          for (var item in jsonData) {
            Map<String, dynamic> task = {
              'idNotification': item['idNotification'],
              'nature': item['nature'],
              'id': item['idreunion'],
              'code': item['code_reunion'],
              'titre': item['titreReunion'],
              'd_d': item['date_debut'],
              'd_f': item['dateFin'],
              'ordre': item['OrdreDujour'],
              'Organisateur': item['Organisateur'],
              'NbrParticipants': item['NbrParticipants'],
              'Participantsinterne': item['Participants'],
              'Participantsexterne': item['Participantsexterne'],
              'societe_id': item['societe_id'],
              'projet_id': item['projet_id'],
              'fich': item['nbr_fichier'],
              'user': item['user'],
            };
            meetstab.add(task);
          }
        }
      } else {
        meetstab = [
          {"empty": "table"}
        ];
      }
      return meetstab;
    } else {
      return meetstab;
    }
  } catch (error) {
    return meetstab;
  }
}

Future<String> fUpdateNotification(String value) async {
  // var url =
  //     'http://erpdev.pingholding.com/wp-json/custom-api-route/updateNotification/?id_notification=$value';
  var url =
      'http://erp.pingholding.com/wp-json/custom-api-route/updateNotification/?id_notification=$value';
  try {
    var response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      if (response.body != 'false') {
        return 'succes';
      } else {
        return 'wrong id';
      }
    } else {
      return 'serveur';
    }
  } catch (error) {
    return 'internet';
  }
}
