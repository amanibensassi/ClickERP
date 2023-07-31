import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notification/constants.dart';
import 'package:notification/main.dart';
import 'package:notification/pages/page_erreur.dart';
import 'package:notification/pages/accueil.dart';
import 'package:notification/pages/detail_taches.dart';
import 'package:notification/pages/details_reunion.dart';
import 'package:notification/pages/liste_reunions.dart';
import 'package:notification/pages/liste_taches.dart';
import 'package:notification/webService/login.dart';
import 'package:notification/webService/taches_reunions.dart';
import 'package:notification/controllers/context_controller.dart';

CollectionReference tokenCollection =
    FirebaseFirestore.instance.collection('token');
List<Map<String, dynamic>> taskstab = [];
List<Map<String, dynamic>> meetstab = [];

class TaskController extends GetxController {
  freturnDialog(String title, String body) {
    BuildContext? cnx = ContextController.getContext();
    if (cnx != null) {
      showDialog(
        context: cnx,
        builder: (cnx) => AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          title: Text(
            title.tr,
            style: const TextStyle(
              color: kBlueColor,
            ),
          ),
          content: Text(
            body.tr,
          ),
          actions: [
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pop(cnx, false);
                },
                child: Text('Okey'.tr),
              ),
            ),
          ],
        ),
      );
    }
  }

  freturnTasks() async {
    taskstab = await fetchTasksID();
    if (taskstab.first.toString() != {"1": "1"}.toString() &&
        (taskstab.first.toString() != {'empty': 'list'}.toString())) {
      Get.to(() => ListeTaches(
            nb: taskstab.length,
            taskList: taskstab,
          ));
    } else {
      navigatorkey.currentState?.pushNamed(
        Page404.route,
      );
    }
  }

  freturnUserTasks() async {
    taskstab = await fetchTasksID();

    if (taskstab.first.toString() != {"1": "1"}.toString() &&
        (taskstab.first.toString() != {'empty': 'list'}.toString())) {
      Get.to(() => ListeTaches(
            nb: taskstab.length,
            taskList: taskstab,
          ));
    } else if (taskstab.first.toString() == {'empty': 'list'}.toString()) {
      freturnDialog('Pas de tâches!', 'Vous n\'avez pas de tâches à traîter.');
    } else {
      navigatorkey.currentState?.pushNamed(
        Page404.route,
      );
    }
  }

  freturnOneMeet(Map<String, dynamic>? list) async {
    meetstab = await fetchMeets();

    if (meetstab.first.toString() != {"1": "1"}.toString()) {
      Get.to(
        () => DetailsReunion(
          meet: list,
        ),
      );
    } else {
      navigatorkey.currentState?.pushNamed(
        Page404.route,
      );
    }
  }

  freturnOneTask(Map<String, dynamic>? list) async {
    meetstab = await fetchTasksID();
    if (meetstab.first.toString() != {"1": "1"}.toString()) {
      Get.to(
        () => DetailsTaches(
          task: list,
        ),
      );
    } else {
      navigatorkey.currentState?.pushNamed(
        Page404.route,
      );
    }
  }

  freturnMeets() async {
    meetstab = await fetchMeets();
    if (meetstab.first.toString() != {"1": "1"}.toString() &&
        (meetstab.first.toString() != {'empty': 'list'}.toString())) {
      Get.to(() => ListeReunions(
            nb: meetstab.length,
            meetList: meetstab,
          ));
    } else if (meetstab.first.toString() == {'empty': 'list'}.toString()) {
      freturnDialog('Pas de réunions!', 'Vous n\'avez aucune réunion.');
    } else {
      navigatorkey.currentState?.pushNamed(
        Page404.route,
      );
    }
    // if (meetstab.first.toString() != {"1": "1"}.toString()) {
    //   Get.to(() => ListeReunions(
    //         nb: meetstab.length,
    //         meetList: meetstab,
    //       ));
    // } else {
    //   navigatorkey.currentState?.pushNamed(
    //     Page404.route,
    //   );
    // }
  }

  fGetFirstName(String name) {
    // String separator = '_';
    final parts = name.split('_');
    // return parts.isNotEmpty ? parts.first : '';
    if (parts.isNotEmpty) {
      String firstPart = parts.first;
      if (firstPart.isNotEmpty) {
        String firstCharacter = firstPart[0].toUpperCase();
        String remainingCharacters = firstPart.substring(1);
        return '$firstCharacter$remainingCharacters';
      }
    }
    return '';
  }

  fgetAcceuil() async {
    String name = await getFromSession('name');
    int nb = 0, nbm = 0;

    name = fGetFirstName(name);
    taskstab = await fetchTasksID();
    meetstab = await fetchMeets();
    if ((taskstab.first.toString() != {'empty': 'list'}.toString()) &&
        (taskstab.first.toString() != {"1": "1"}.toString())) {
      nb = taskstab.length;
    }
    if ((meetstab.first.toString() != {'empty': 'list'}.toString()) &&
        (meetstab.first.toString() != {"1": "1"}.toString())) {
      nbm = meetstab.length;
    }

    Get.to(() => Accueil(
          nbT: nb,
          name: name,
          nbR: nbm,
        ));
  }

  fReturnNumberOfTasks() async {
    int nb = 0;
    taskstab = await fetchTasksID();
    nb = taskstab.length;
    // print('le nombre de case du tableau : $nb');
    return nb;
  }

  String fconvertStatus(int? idStatus) {
    switch (idStatus) {
      case 1:
        return 'basse';
      case 2:
        return 'moyenne';
      case 3:
        return 'importante';
      case 4:
        return 'urgente';
      default:
        return 'pas de status';
    }
  }

  String fconvertDate(String? date) {
    String cdate = 'impréci';
    if (date != null) {
      String year = date.substring(0, 4);
      String month = date.substring(5, 7);
      String day = date.substring(8, 10);
      String time = date.substring(11);
      switch (month) {
        case '01':
          month = 'jan';
        case '02':
          month = 'fev';
        case '03':
          month = 'mar';
        case '04':
          month = 'avr';
        case '05':
          month = 'may';
        case '06':
          month = 'juin';
        case '07':
          month = 'jui';
        case '08':
          month = 'août';
        case '09':
          month = 'sep';
        case '10':
          month = 'oct';
        case '11':
          month = 'nov';
        case '12':
          month = 'dec';
        default:
          month = 'impréci';
      }
      month != 'impréci'
          ? cdate = '$day $month $year à $time'
          : cdate = 'impréci';
    }

    return cdate;
  }

  String fCheckNullOption(String? data, String comeBack) {
    String finalchar = '';
    data == null ? finalchar = comeBack : finalchar = data;
    return finalchar;
  }

  String fgetHour(String? date) {
    String cdate = 'impréci';
    if (date != null) {
      // String year = date.substring(0, 4);
      // String month = date.substring(5, 7);
      // String day = date.substring(8, 10);
      String time = date.substring(11);

      cdate = ' $time';
    }

    return cdate;
  }

  bool fCheckHour(String? date) {
    DateTime currentDate = DateTime.now();
    String currentTime = currentDate.toLocal().toString();
    String currentyear = currentTime.substring(0, 4);
    String currentmonth = currentTime.substring(5, 7);
    String currentday = currentTime.substring(8, 10);
    int currenthour = int.parse(currentTime.substring(11, 13));
    int currentminutes = int.parse(currentTime.substring(14, 16));

    if (date != null) {
      String year = date.substring(0, 4);
      String month = date.substring(5, 7);
      String day = date.substring(8, 10);
      int hour = int.parse(date.substring(11, 13));
      int minutes = int.parse(date.substring(14, 16));
      if ((year == currentyear) &&
          (month == currentmonth) &&
          (day == currentday) &&
          (minutes == currentminutes)) {
        return (hour - currenthour == 1);
      }
    }
    return false; // Return false if the date is null
  }
}
