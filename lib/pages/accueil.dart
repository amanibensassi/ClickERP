import 'package:flutter/material.dart';
import 'package:notification/api/firebase_api.dart';
import 'package:notification/constants.dart';
import 'package:notification/controllers/calendrier_controller.dart';
import 'package:notification/controllers/context_controller.dart';
import 'package:notification/controllers/task_controller.dart';
import 'package:notification/pages/connexion.dart';
import 'package:notification/webService/login.dart';
import 'package:notification/widgets/dashboard_buttons.dart';
import 'package:notification/widgets/dashboard_buttons_long.dart';
import 'package:notification/widgets/top_menu.dart';
import '../widgets/custom_bar.dart';
import 'package:get/get.dart';

class Accueil extends StatelessWidget {
  final int nbT;
  final int nbR;
  final String name;
  Accueil({
    required this.nbT,
    required this.name,
    required this.nbR,
    super.key,
  });

  final nb = TaskController().fReturnNumberOfTasks();
  @override
  Widget build(BuildContext context) {
    ContextController.setContext(context);
    Future<bool?> onbackpress() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              title: const Text(
                'Se déconnecter?',
                style: TextStyle(
                  color: kBlueColor,
                ),
              ),
              content: Text(
                'Etes vous sûr de vouloir vous déconnecter?'.tr,
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: Text('Annuler'.tr),
                    ),
                    TextButton(
                      onPressed: () {
                        restartSession();
                        FirebaseApi().tokeninitialize();
                        Get.to(() => const Connexion());
                      },
                      child: Text('Se déconnecter'.tr),
                    ),
                  ],
                ),
              ],
            ));
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: const CustomBar(light: false),
        backgroundColor: kBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopMenu(function: () => onbackpress(), menu: 'menu'),
              Padding(
                padding: const EdgeInsets.only(
                  top: 50,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bienvenu $name,',
                        style: const TextStyle(
                          fontSize: kBig,
                        ),
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DashbordButtons(
                              bigTitle: nbR <= 1 ? "Réunion" : "Réunions",
                              nb: '$nbR',
                              function: () {
                                TaskController().freturnMeets();
                              }),
                          DashbordButtons(
                              bigTitle: nbT <= 1 ? "tâche" : "tâches",
                              nb: ' $nbT',
                              function: () {
                                TaskController().freturnUserTasks();
                              }),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DashbordButtonsLong(
                              bigTitle: "Engagement en cours",
                              nb: '',
                              function: () {}),
                          DashbordButtons(
                              bigTitle: "Calendrier",
                              nb: '',
                              function: () async {
                                await CalendrierController()
                                    .fConstructMyCalendarTasks();
                                CalendrierController()
                                    .fCheckBusyDay('2023-07-21');
                                CalendrierController().fgetcalendrier();
                              }),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DashbordButtonsLong(
                              bigTitle: "Utilisateurs connectés",
                              nb: '',
                              function: () {}),
                          DashbordButtons(
                              bigTitle: "Appel d'offre",
                              nb: '',
                              function: () {}),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
