import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:notification/webService/login.dart';

Future<List<Map<String, dynamic>>> fetchMeets() async {
  List<Map<String, dynamic>> meetstab = [];
  int iduser = await getFromSession('id');

  //get the correct URL for the meet
  var url =
      'http://erp.pingholding.com/wp-json/custom-api-route/getReunion/?id_user=$iduser';
  try {
    var response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      if (response.body != 'false') {
        if (jsonData is List) {
          for (var item in jsonData) {
            Map<String, dynamic> task = {
              //make the necessary changes when the web service is obtained
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
          return meetstab;
        } else {
          return [
            {'1': '1'}
          ];
        }
      } else {
        return [
          {'empty': 'list'}
        ];
      }
    } else {
      return [
        {'1': '1'}
      ];
    }
  } catch (error) {
    return [
      {'1': '1'}
    ];
  }
}

Future<List<Map<String, dynamic>>> fetchTasksID() async {
  List<Map<String, dynamic>> taskstab = [];
  int iduser = await getFromSession('id');
  var url =
      'http://erp.pingholding.com/wp-json/custom-api-route/getTache/?id_user=$iduser';
  try {
    var response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      if (response.body != 'false') {
        if (jsonData is List) {
          for (var item in jsonData) {
            Map<String, dynamic> task = {
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

          return taskstab;
        } else {
          return [
            {'1': '1'}
          ];
        }
      } else {
        return [
          {'empty': 'list'}
        ];
      }
    } else {
      return [
        {'1': '1'}
      ];
    }
  } catch (error) {
    return [
      {'1': '1'}
    ];
  }
}
