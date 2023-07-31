import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:notification/webService/login.dart';

Future<List<Map<String, dynamic>>> fTaskOftheDay(String date) async {
  final int iduser = await getFromSession('id');
  List<Map<String, dynamic>> taskstab = [
    {"1": "1"}
  ];
  var url =
      'http://erpdev.pingholding.com/wp-json/custom-api-route/getTacheDujourJSON/?id_user=$iduser&date_jour=$date';
  try {
    var response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      if (jsonData.toString() != false.toString()) {
        if (jsonData is List) {
          taskstab = [];
          for (var item in jsonData) {
            Map<String, dynamic> task = {
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
            taskstab.add(task);
          }
        }
      } else {
        taskstab = [
          {"empty": "table"}
        ];
      }
      return taskstab;
    } else {
      return taskstab;
    }
  } catch (error) {
    return taskstab;
  }
}

Future<List<Map<String, dynamic>>> fMeetOftheDay(String date) async {
  final int iduser = await getFromSession('id');
  List<Map<String, dynamic>> meetstab = [
    {"1": "1"}
  ];
  var url =
      'http://erpdev.pingholding.com/wp-json/custom-api-route/getReunionDujourJSON/?id_user=$iduser&date_jour=$date';
  try {
    var response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      if (jsonData.toString() != false.toString()) {
        if (jsonData is List) {
          meetstab = [];
          for (var item in jsonData) {
            Map<String, dynamic> meet = {
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
            meetstab.add(meet);
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

Future<List<Map<String, dynamic>>> fGetHolidays() async {
  List<Map<String, dynamic>> holidayTab = [
    {"1": "1"}
  ];
  var url =
      'http://erpdev.pingholding.com/wp-json/custom-api-route/getJourFerie/';
  try {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      if (jsonData.toString() != false.toString()) {
        if (jsonData is List) {
          holidayTab = [];
          for (var item in jsonData) {
            Map<String, dynamic> holiday = {
              'idjourFerie': item['idjourFerie'],
              'designation': item['designation'],
              'd_d': item['date_debut'],
              'd_f': item['date_fin'],
              'duree': item['duree'],
              'type': item['type'],
              'user': item['user'],
            };
            holidayTab.add(holiday);
          }
        }
      } else {
        holidayTab = [
          {"empty": "table"}
        ];
      }
      return holidayTab;
    } else {
      return holidayTab;
    }
  } catch (error) {
    return holidayTab;
  }
}

Future<List<Map<String, dynamic>>> fGetLeaves() async {
  int id = await getFromSession('id');
  List<Map<String, dynamic>> holidayTab = [
    {"1": "1"}
  ];
  var url =
      'http://erpdev.pingholding.com/wp-json/custom-api-route/getCongeUser/?id_user=$id';
  try {
    var response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      if (jsonData.toString() != false.toString()) {
        if (jsonData is List) {
          holidayTab = [];
          for (var item in jsonData) {
            Map<String, dynamic> holiday = {
              'idconge': item['idconge'],
              'type_conge': item['type_conge'],
              'd_d': item['date_debut'],
              'd_f': item['date_fin'],
              'statut': item['statut'],
              'document_name': item['document_name'],
              'document_path': item['document_path'],
              'user': item['user'],
            };
            holidayTab.add(holiday);
          }
        }
      } else {
        holidayTab = [
          {"empty": "table"}
        ];
      }
      return holidayTab;
    } else {
      return holidayTab;
    }
  } catch (error) {
    return holidayTab;
  }
}
