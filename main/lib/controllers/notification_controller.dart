import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notification/constants.dart';
import 'package:notification/controllers/context_controller.dart';
import 'package:notification/controllers/task_controller.dart';
import 'package:notification/main.dart';
import 'package:notification/pages/page_erreur.dart';
import 'package:notification/pages/notification.dart';
import 'package:notification/webService/notification.dart';
import 'package:notification/webService/taches_reunions.dart';
import 'package:notification/webService/timer.dart';
import '../api/notification_dynamic.dart';
import '../webService/login.dart';

class NotificationController extends GetxController {
  late List<Map<String, dynamic>> notifTab = [];
  late List<Map<String, dynamic>> notifReunion = [];
  late List<Map<String, dynamic>> notiftask = [];
  List<Map<String, dynamic>> meetstab = [];

  fconstructTabTR() async {
    notiftask = await fNotificationTR();
    notifReunion = await fNotificationReunion();
    if ((notiftask.first.toString() == {"1": "1"}.toString()) &&
        (notifReunion.first.toString() == {"1": "1"}.toString())) {
      notifTab = [
        {"1": "1"}
      ];
    } else if ((notiftask.first.toString() == {"empty": "table"}.toString()) &&
        (notifReunion.first.toString() == {"empty": "table"}.toString())) {
      notifTab = [
        {"empty": "table"}
      ];
    }
  }

  fconstructTabR() async {
    meetstab = await fetchMeets();
    if ((meetstab.first.toString() == {"1": "1"}.toString()) &&
        (meetstab.first.toString() == {"1": "1"}.toString())) {
      meetstab = [];
    }
  }

  fconstructnotifTab() async {
    await fconstructTabTR();
    if (notifTab.isEmpty) {
      if ((notiftask.first.toString() == {"empty": "table"}.toString()) ||
          (notiftask.first.toString() == {"1": "1"}.toString())) {
        notiftask = [];
      }
      if ((notifReunion.first.toString() == {"empty": "table"}.toString()) ||
          (notifReunion.first.toString() == {"1": "1"}.toString())) {
        notifReunion = [];
      }
    }
    notifTab.addAll(notiftask);
    notifTab.addAll(notifReunion);
  }

  fupdatenotification(String value) async {
    // await fconstructnotifTab();
    String result = await fUpdateNotification(value);
    switch (result) {
      case 'succes':
        return;
      case 'wrong id':
        navigatorkey.currentState?.pushNamed(
          Page404.route,
        );
        return true;
      case 'serveur':
        navigatorkey.currentState?.pushNamed(
          Page404.route,
        );
        return true;
      default:
        navigatorkey.currentState?.pushNamed(
          Page404.route,
        );
        return true;
    }
  }

  fgetremoteDetails() async {
    await fconstructnotifTab();

    Get.to(
      () => NotificationScreen(taskList: notifTab),
    );
  }

  fgetDetails() async {
    Get.to(
      () => NotificationScreen(taskList: notifTab),
    );
  }

  Future<bool> fgetNotification() async {
    await fconstructnotifTab();
    if (notifTab ==
        [
          {"1": "1"}
        ]) {
      navigatorkey.currentState?.pushNamed(
        Page404.route,
      );
      return false;
    } else if (notifTab.first.toString() == {"empty": "table"}.toString()) {
      return false;
    } else {
      // int nb = notifTab.length;
      int nbTache = 0;
      int nbReunion = 0;
      // number of task condition
      for (var map in notifTab) {
        if (map['nature'] == 'tache') {
          nbTache++;
        } else {
          nbReunion++;
        }
      }
      print('taches : $nbTache et reunion : $nbReunion');
      int nb = nbTache + nbReunion;
      if ((nbTache > 1) && (nbReunion > 1)) {
        fSendNotif('Vous avez $nb nouvelles notifications !',
            'Vous avez $nbReunion réunions et $nbTache tâches à accomplire, veuillez cliquez pour plus de détails');
        return true;
      } else if ((nbTache == 1) && (nbReunion == 1)) {
        fSendNotif('Vous avez $nb nouvelles notifications !',
            'Vous avez une nouvelle réunion et une nouvelle tâche à accomplire, veuillez cliquez pour plus de détails');
        return true;
      } else if ((nbTache < 1) && (nbReunion == 1)) {
        fSendNotif('Vous avez une nouvelle réunion !',
            'Vous avez une réunion ajouté récemment, veuillez cliquez pour plus de détails');
        return true;
      } else if ((nbTache == 1) && (nbReunion < 1)) {
        fSendNotif('Vous avez une nouvelle tâche !',
            'Vous avez une nouvelle tâche ajouté récemment, veuillez cliquez pour plus de détails');
        return true;
      } else if ((nbTache < 1) && (nbReunion > 1)) {
        fSendNotif('Vous avez $nbReunion nouvelles réunions !',
            'Vous avez $nbReunion nouvelles réunions ajoutés récemment, veuillez cliquez pour plus de détails');
        return true;
      } else if ((nbTache > 1) && (nbReunion < 1)) {
        fSendNotif('Vous avez $nbTache nouvelles tâches !',
            'Vous avez $nbTache nouvelles tâches ajoutés récemment, veuillez cliquez pour plus de détails');
        return true;
      } else if ((nbTache > 1) && (nbReunion == 1)) {
        fSendNotif('Vous avez $nb nouvelles notifications !',
            'Vous avez $nbTache nouvelles tâches et une seule réunion ajoutés récemment, veuillez cliquez pour plus de détails');
        return true;
      } else {
        fSendNotif('Vous avez $nb nouvelles notifications !',
            'Vous avez $nbReunion nouvelles réunions et une seule tâche ajoutés récemment, veuillez cliquez pour plus de détails');
        return true;
      }
    }
  }

  fAlertNotif(String title, String body) {
    BuildContext? cnx = ContextController.getContext();
    MinuteTimer().stopTimer();
    MinuteTimer().stopTimerh();
    saveToSession('timer', 'stop');
    saveToSession('timer2', 'stop');
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        title.trim() != 'Vous avez une réunion dans une heure !'
                            ? TextButton(
                                onPressed: () {
                                  MinuteTimer().startTimer();
                                  MinuteTimer().secondtimer();
                                  fgetDetails();
                                },
                                child: Text('Voir détails'.tr),
                              )
                            : TextButton(
                                onPressed: () {
                                  MinuteTimer().startTimer();
                                  MinuteTimer().secondtimer();
                                  fgetDetails();
                                },
                                child: const Text(''),
                              ),
                        TextButton(
                          onPressed: () {
                            MinuteTimer().startTimer();
                            MinuteTimer().secondtimer();
                            Navigator.pop(cnx, false);
                          },
                          child: Text('Okey'.tr),
                        ),
                      ],
                    ),
                  ),
                ],
              ));
    } else {
      return;
    }
  }

  fSendNotif(String title, String body) async {
    String token = await getFromSession('token');
    // print(token);
    bool test = await sendNotification(token, title, body);
    if (test) {
      fAlertNotif(title, body);
    } else {
      return;
    }
  }

  fMeetReminder() async {
    bool test = false;
    await fconstructTabR();
    for (var map in meetstab) {
      dynamic dateDebut = map['d_d'];
      if (dateDebut != null) {
        test = TaskController().fCheckHour(dateDebut);
        if (test) {
          MinuteTimer().stopTimer();
          MinuteTimer().stopTimerh();
          saveToSession('timer', 'stop');
          saveToSession('timer2', 'stop');
          fSendNotif('Vous avez une réunion dans une heure ! ',
              'Vous avez une réunion programmé aujourd\'hui qui se déroulera dans une heure intitulé : "${map['titre']}"');
        }
      }
    }
    return test;
  }
}
