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

class AnouncementCard extends StatelessWidget {
  final String type;
  final Map<String, dynamic>? list;
  const AnouncementCard({
    required this.list,
    required this.type,
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
        type == 'réunion'
            ? TaskController().freturnOneMeet(list)
            : TaskController().freturnOneTask(list);
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
                // boxShadow: [
                // BoxShadow(
                //   color: fGetColor(priorite),
                //   blurRadius:
                //       1.3, // Adjust the blur radius to control the intensity of the shadow
                //   spreadRadius:
                //       0.1, // Adjust the spread radius to control the size of the shadow
                // ),
                // ],
                // border: Border.all(
                //   color: fGetColor(priorite),

                //   width: 0.5,
                // ),
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
                            : 'à rendre avant ${TaskController().fconvertDate(list?['d_f1'])}'),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
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
