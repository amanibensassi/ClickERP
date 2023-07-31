import 'package:flutter/material.dart';
import 'package:notification/constants.dart';
import 'package:notification/controllers/task_controller.dart';
import 'package:notification/webService/notification.dart';
import 'package:notification/widgets/notification_card.dart';
import 'package:notification/widgets/notification_card_reunion.dart';
import 'package:notification/widgets/top_menu.dart';
import 'package:notification/controllers/context_controller.dart';
// import 'package:notification/webService/login.dart';
import '../widgets/custom_bar.dart';

class NotificationScreen extends StatelessWidget {
  final List<Map<String, dynamic>>? taskList;
  const NotificationScreen({required this.taskList, super.key});
  // static const route = '/notificationScreen';
  @override
  Widget build(BuildContext context) {
    ContextController.setContext(context);
    List<String> firstValues =
        taskList!.map((map) => map.values.first.toString()).toList();
    for (var value in firstValues) {
      fUpdateNotification(value);
    }

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: const CustomBar(light: false),
        backgroundColor: kBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              TopMenu(
                  function: () {
                    TaskController().fgetAcceuil();
                  },
                  menu: ''),
              //********************************************************************************************************************//
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        taskList!.length > 1
                            ? Text(
                                'Vous avez ${taskList!.length} nouvelles notifications',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              )
                            : const Text(
                                'Vous avez une nouvelle notification',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 20,
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemCount: taskList?.length ?? 0,
                        itemBuilder: (context, index) {
                          final task = taskList?[index];
                          return task?['nature'] == 'tache'
                              ? NotificationCard(list: task)
                              : NotificationCardReunion(list: task);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
