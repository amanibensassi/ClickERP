import 'package:flutter/material.dart';
import 'package:notification/constants.dart';
import 'package:notification/controllers/task_controller.dart';

class ReunionCard extends StatelessWidget {
  final String type;
  final Map<String, dynamic>? list;
  const ReunionCard({
    required this.list,
    required this.type,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final Timestamp date = new Timestamp.now();

    return InkWell(
      onTap: () {
        TaskController().freturnOneMeet(list);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kSpaceWidth,
          vertical: kSpacer,
        ),
        child: Column(
          children: [
            Container(
              height: 150,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    10,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            TaskController()
                                .fCheckNullOption(list?['titre'], 'impréci'),
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: kMedium,
                              color: kBlueColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(TaskController().fconvertDate(list?['d_f']) ==
                                'impréci'
                            ? ''
                            : 'Terminé le ${TaskController().fconvertDate(list?['d_f'])}'),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
