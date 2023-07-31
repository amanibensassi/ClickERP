import 'package:flutter/material.dart';
import 'package:notification/constants.dart';
import 'package:notification/controllers/task_controller.dart';

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
      return const Color(0x0DFF4242);
  }
}

class NotificationCard extends StatelessWidget {
  final Map<String, dynamic>? list;
  const NotificationCard({
    required this.list,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String priorite = TaskController().fconvertStatus(
      int.parse(list?['priorite']),
    );
    priorite == 'impréci'
        ? priorite = ''
        : TaskController().fconvertStatus(
            int.parse(list?['priorite']),
          );
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kSpaceWidth,
        vertical: kSpacer,
      ),
      child: InkWell(
        onTap: () {
          TaskController().freturnOneTask(list);
        },
        child: Column(
          children: [
            Container(
              height: 160,
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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Tâche',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: kMedium,
                            color: kBlueColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            TaskController().fCheckNullOption(
                                list?['designation'], 'impréci'),
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
                        Text(TaskController().fCheckNullOption(
                                    list?['d_f1'], 'impréci') ==
                                'impréci'
                            ? ''
                            : 'à rendre avant ${TaskController().fconvertDate(list?['d_f1'])}'),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 25,
                          width: 95,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: fGetColor(priorite),
                          ),
                          child: Center(
                            child: Text(
                              priorite,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: kSmall,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold),
                            ),
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
