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
      return;
  }
}

class CalendrierTaches extends StatelessWidget {
  final Map<String, dynamic>? list;
  const CalendrierTaches({
    required this.list,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final Timestamp date = new Timestamp.now();
    String priorite = TaskController().fconvertStatus(
      int.parse(list?['priorite']),
    );
    return InkWell(
      onTap: () {
        TaskController().freturnOneTask(list);
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
                      children: [
                        Flexible(
                          child: Text(
                            list?['designation'],
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
                        Text(TaskController().fconvertDate(list?['d_f1']) ==
                                'impréci'
                            ? ''
                            : 'Prèvu ${TaskController().fgetHour(list?['d_d'])}'),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 25,
                          width: MediaQuery.of(context).size.width / 5,
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
