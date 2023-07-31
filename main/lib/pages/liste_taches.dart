import 'package:flutter/material.dart';
import 'package:notification/constants.dart';
import 'package:notification/controllers/context_controller.dart';
import 'package:notification/controllers/task_controller.dart';
import 'package:notification/widgets/anouncement_card.dart';
import 'package:notification/widgets/top_menu.dart';
import '../widgets/custom_bar.dart';

class ListeTaches extends StatelessWidget {
  final int nb;
  final List<Map<String, dynamic>>? taskList; // Declare taskList as nullable

  const ListeTaches({
    required this.nb,
    required this.taskList,
    Key? key,
  }) : super(key: key);

  static const route = '/Dashbord';

  @override
  Widget build(BuildContext context) {
    ContextController.setContext(context);

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
              TopMenu(
                function: () {
                  TaskController().fgetAcceuil();
                },
                menu: '',
              ),
              const SizedBox(
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                ),
                child: Row(
                  children: [
                    taskList!.first.toString() != {'empty': 'list'}.toString()
                        ? nb == 1
                            ? const Text(
                                'Vous avez une tâche à faire aujourd\'hui :',
                                style: TextStyle(
                                  fontSize: kBig,
                                ),
                              )
                            : Text(
                                'Vous avez $nb tâches à faire aujourd\'hui :',
                                style: const TextStyle(
                                  fontSize: kBig,
                                ),
                              )
                        : const Flexible(
                            child: Text(
                              'Vous n\'avez aucune tâche à faire aujourd\'hui .',
                              style: TextStyle(
                                fontSize: kBig,
                              ),
                            ),
                          )
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              taskList!.first.toString() != {'empty': 'list'}.toString()
                  ? Padding(
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
                          return AnouncementCard(type: "success", list: task);
                        },
                      ),
                    )
                  : const SizedBox(
                      height: 15,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
