import 'package:flutter/material.dart';
import 'package:notification/constants.dart';
import 'package:notification/controllers/task_controller.dart';

class CalendrierReunion extends StatelessWidget {
  final Map<String, dynamic>? list;
  const CalendrierReunion({
    required this.list,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              height: 100,
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
                  vertical: 10,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 25,
                          width: MediaQuery.of(context).size.width / 5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: kMeetBlueColor,
                          ),
                          child: const Center(
                            child: Text(
                              'réunion',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: kSmall,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
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
                        Text(
                          TaskController().fconvertDate(list?['d_d']) ==
                                  'impréci'
                              ? ''
                              : 'Commence le ${TaskController().fgetHour(list?['d_d'])}',
                          style: const TextStyle(
                            fontSize: kSmall,
                            color: kBlueColor,
                          ),
                        ),
                      ],
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
