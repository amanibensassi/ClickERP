import 'package:flutter/material.dart';
import 'package:notification/constants.dart';
import 'package:notification/controllers/calendrier_controller.dart';
import 'package:notification/controllers/context_controller.dart';
import 'package:notification/controllers/task_controller.dart';
import 'package:notification/widgets/calendrier_reunion.dart';
import 'package:notification/widgets/calendrier_taches.dart';
import 'package:notification/widgets/custom_bar.dart';
import 'package:notification/widgets/top_menu.dart';
import 'package:table_calendar/table_calendar.dart';

class PageCalendrier extends StatefulWidget {
  final List<String> holidayList;
  final List<String> leaveList;
  PageCalendrier({
    required this.holidayList,
    required this.leaveList,
  });
  @override
  _PageCalendrierState createState() => _PageCalendrierState();
}

class _PageCalendrierState extends State<PageCalendrier> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final kFirstDay = DateTime(
      DateTime.now().year - 3, DateTime.now().month, DateTime.now().day);
  final kLastDay = DateTime(
      DateTime.now().year + 3, DateTime.now().month, DateTime.now().day);
  late List<Map<String, dynamic>> taskList = [];
  late List<Map<String, dynamic>> meetList = [];
  late List<Map<String, dynamic>> todayList = [];
  late List<Map<String, dynamic>> list = [];
  String selectedItem = '';
  int tableLength = 0;

  @override
  void initState() {
    super.initState();
    _loadTasks(DateTime.now());
  }

  void _loadTasks(DateTime? selectedDay) async {
    selectedItem = selectedDay?.toString().split(' ')[0] ?? '';
    todayList = await CalendrierController().fsortMycalender(selectedItem);
    setState(() {
      tableLength = todayList.length;
    });
  }

  bool fHoliday(DateTime day, int weekend) {
    bool test = false;
    List<String> finaldaysList = widget.holidayList;
    if (finaldaysList.isNotEmpty) {
      selectedItem = day.toString().split(' ')[0];
      int i = 0;
      while ((i < finaldaysList.length) && (!test)) {
        if (finaldaysList[i].toString() == selectedItem.toString()) {
          test = true;
        }
        i++;
      }
    }
    return test;
  }

  bool shouldShowAsterisk(DateTime day) {
    bool test = false;
    selectedItem = day.toString().split(' ')[0];
    test = CalendrierController().fCheckBusyDay(selectedItem);
    return test;
  }

  bool shouldShowAsleave(DateTime day) {
    bool test = false;
    List<String> finalleavedaysList = widget.leaveList;
    if (finalleavedaysList.isNotEmpty) {
      selectedItem = day.toString().split(' ')[0];
      int i = 0;
      while ((i < finalleavedaysList.length) && (!test)) {
        if (finalleavedaysList[i].toString() == selectedItem.toString()) {
          test = true;
        }
        i++;
      }
    }
    return test;
  }

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
                height: 60,
              ),

              // ***************************************************table calendar code :
              TableCalendar(
                firstDay: kFirstDay,
                lastDay: kLastDay,
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(_selectedDay, selectedDay)) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                      _loadTasks(_selectedDay);
                    });
                  }
                },

                // onFormatChanged: (format) {
                //   if (_calendarFormat != format) {
                //     setState(() {
                //       _calendarFormat = format;
                //     });
                //   }
                // },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },

                onFormatChanged: (CalendarFormat _calendarFormat) {
                  setState(() {
                    _calendarFormat = _calendarFormat;
                  });
                },
                startingDayOfWeek: StartingDayOfWeek.monday,

                holidayPredicate: (day) {
                  return fHoliday(day, day.weekday);
                },
                calendarStyle: CalendarStyle(
                  selectedDecoration: const BoxDecoration(
                    color: kPrimaryColor,
                    shape: BoxShape.circle,
                  ),
                  selectedTextStyle: const TextStyle(color: Colors.white),
                  todayDecoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: kSplashColor,
                  ),
                  weekendDecoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: false,
                  formatButtonShowsNext: true,
                  formatButtonDecoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  formatButtonTextStyle: const TextStyle(
                    color: Colors.white,
                  ),
                ),

                calendarBuilders:
                    CalendarBuilders(markerBuilder: (context, date, events) {
                  return Stack(
                    children: [
                      if (shouldShowAsterisk(date) == true)
                        const Positioned(
                          top: 5,
                          right: 12,
                          child: Text(
                            '*',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: kMedium,
                            ),
                          ),
                        ),
                      if (shouldShowAsleave(date) == true)
                        const Positioned(
                          top: 5,
                          right: 12,
                          child: Text(
                            '*',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: kMedium,
                            ),
                          ),
                        ),
                    ],
                  );
                }),
              ),

              // ****************************************************** table calender finished
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: tableLength == 0
                    ? const Text(
                        'Vous n\'aviez aucun engagement prévu pour aujourd\'hui',
                        style: TextStyle(
                          fontSize: kMedium,
                          color: kBlueColor,
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemCount: tableLength,
                        itemBuilder: (context, index) {
                          final map = todayList[index];
                          return map['nature'] == 'tache'
                              ? CalendrierTaches(list: map)
                              : CalendrierReunion(list: map);
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
