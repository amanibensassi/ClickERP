import 'package:flutter/material.dart';
import 'package:notification/constants.dart';
import 'package:notification/controllers/context_controller.dart';
import 'package:notification/controllers/task_controller.dart';
import 'package:notification/widgets/top_menu.dart';
// import 'package:notification/webService/login.dart';
import '../widgets/custom_bar.dart';

class DetailsReunion extends StatelessWidget {
  final Map<String, dynamic>? meet;
  const DetailsReunion({required this.meet, super.key});
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
            children: [
              TopMenu(
                  function: () {
                    TaskController().freturnMeets();
                  },
                  menu: ''),
              //********************************************************************************************************************//
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Détail de la réunion ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            TaskController().fconvertDate(meet?['d_d']) ==
                                    'impréci'
                                ? ''
                                : 'du ${TaskController().fconvertDate(meet?['d_d'])}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Sujet :',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: kMedium,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          TaskController()
                              .fCheckNullOption(meet?['titre'], 'impréci'),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: kMedium,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Heure :',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: kMedium,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          TaskController().fconvertDate(meet?['d_d']) ==
                                  'impréci'
                              ? ''
                              : ' ${TaskController().fgetHour(meet?['d_d'])}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: kMedium,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Traitement :',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: kMedium,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          TaskController().fconvertDate(meet?['d_f']) ==
                                  'impréci'
                              ? ''
                              : ' ${TaskController().fgetHour(meet?['d_f'])}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: kMedium,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Participants :',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: kMedium,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          TaskController().fCheckNullOption(
                              meet?['Participantsexterne'], ''),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: kMedium,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Lien :',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: kMedium,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          TaskController()
                              .fCheckNullOption(meet?['fich'], 'impréci'),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: kMedium,
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
