import 'package:flutter/material.dart';
import 'package:notification/constants.dart';
import 'package:notification/controllers/context_controller.dart';
import 'package:notification/controllers/task_controller.dart';
import 'package:notification/widgets/top_menu.dart';
// import 'package:notification/webService/login.dart';
import '../widgets/custom_bar.dart';

fGetColor(String priorite) {
  // if (priorite == 'urgente') {
  //   return kRedColor;
  // }else if
  switch (priorite) {
    case 'urgente':
      return kRedColor;
    case 'importante':
      return kBlueColor;
    case 'moyenne':
      return kPrimaryColor;
    case 'basse':
      return kOrangeColor;
    default:
      return;
  }
}

class DetailsTaches extends StatelessWidget {
  final Map<String, dynamic>? task;
  const DetailsTaches({
    required this.task,
    super.key,
  });
  //  {super.key});
  // static const route = '/notificationScreen';
  @override
  Widget build(BuildContext context) {
    ContextController.setContext(context);
    String priorite = TaskController().fconvertStatus(
      int.parse(task?['priorite']),
    );
    // final Timestamp date = Timestamp.now();

    // final message = ModalRoute.of(context)!.settings.arguments;

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
                    TaskController().freturnTasks();
                  },
                  menu: ''),
              //********************************************************************************************************************//
              Padding(
                padding: const EdgeInsets.only(
                  top: 60,
                  left: 20,
                  right: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: Flex(
                            direction: Axis.horizontal,
                            children: [
                              Flexible(
                                child: Text(
                                  // task!['designation'] ?? 'erreur',
                                  TaskController().fCheckNullOption(
                                      task?['designation'], 'impréci'),
                                  style: const TextStyle(
                                      fontSize: 24,
                                      color: kBlueColor,
                                      fontStyle: FontStyle.italic),
                                ),
                              ),
                            ],
                          ),
                        ),
                        TaskController().fconvertDate(task?['d_f1']) ==
                                'impréci'
                            ? const Text('')
                            : Row(
                                children: [
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Text(
                                    'A rendre avant',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: kSmall,
                                    ),
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    TaskController()
                                        .fconvertDate(task?['d_f1']),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: kSmall,
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    ),
                    const SizedBox(
                      height: 120,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Project:',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: kMedium,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            // task!['projet_id'] ?? 'Non précisé',
                            TaskController().fCheckNullOption(
                                task?['projet_id'], 'impréci'),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: kMedium,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Description :',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: kMedium,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                          ),
                          child: Text(
                            // task!['desc'] ?? '',
                            TaskController()
                                .fCheckNullOption(task?['desc'], 'impréci'),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: kMedium,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TaskController().fconvertDate(task?['d_d1']) == 'impréci'
                        ? const Text('')
                        : Row(
                            children: [
                              const Text(
                                'Créer le',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: kMedium,
                                ),
                              ),
                              const SizedBox(width: 3),
                              Text(
                                TaskController().fconvertDate(task?['d_d1']),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: kMedium,
                                ),
                              ),
                            ],
                          ),
                    const SizedBox(
                      height: 120,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: fGetColor(priorite),
                          ),
                          child: Center(
                            child: Text(
                              priorite,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: kBig,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
