import 'package:flutter/material.dart';
import 'package:notification/constants.dart';
import 'package:notification/controllers/context_controller.dart';
import 'package:notification/controllers/task_controller.dart';
import 'package:notification/widgets/reunion_card.dart';
import 'package:notification/widgets/top_menu.dart';
import '../widgets/custom_bar.dart';

class ListeReunions extends StatelessWidget {
  final int nb;
  final List<Map<String, dynamic>>? meetList;
  const ListeReunions({
    required this.meetList,
    required this.nb,
    super.key,
  });

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
                  menu: ''),
              const SizedBox(
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                ),
                child: Row(
                  children: [
                    nb == 1
                        ? const Text(
                            'Vous avez une réunion aujourd\'hui :',
                            style: TextStyle(
                              fontSize: kBig,
                            ),
                          )
                        : Text(
                            'Vous avez $nb réunions aujourd\'hui :',
                            style: const TextStyle(
                              fontSize: kBig,
                            ),
                          )
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 20,
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: meetList?.length ?? 0,
                  itemBuilder: (context, index) {
                    final task = meetList?[index];
                    return ReunionCard(type: "réunion", list: task);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
