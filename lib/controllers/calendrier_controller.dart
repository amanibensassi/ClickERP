import 'package:get/get.dart';
import 'package:notification/pages/calendrier.dart';
import 'package:notification/webService/taches_reunions.dart';
import 'package:notification/webService/traitement_du_calendrier.dart';

class CalendrierController extends GetxController {
  late List<Map<String, dynamic>> taskList = [];
  late List<Map<String, dynamic>> meetList = [];
  late List<Map<String, dynamic>> todayList = [];
  late List<Map<String, dynamic>> holidayList = [];
  late List<Map<String, dynamic>> leaveList = [];
  List<Map<String, dynamic>> freeDaysList = [];
  late List<String> holidayfinalList = [];
  late List<String> leavedayfinalList = [];
  static List<String> myDays = [];

  bool fSortEarliestTime(String date1, String date2) {
    bool test = false;
    int hour1 = int.parse(date1.substring(11, 13));
    int minutes1 = int.parse(date1.substring(14, 16));
    int hour2 = int.parse(date2.substring(11, 13));
    int minutes2 = int.parse(date2.substring(14, 16));

    if (hour1 == hour2) {
      if (minutes1 < minutes2) {
        test = true;
      }
    } else if (hour1 < hour2) {
      test = true;
    }

    return test;
  }

  Future<List<Map<String, dynamic>>> fsortMycalender(
      String selectedItem) async {
    taskList = await fTaskOftheDay(selectedItem);
    meetList = await fMeetOftheDay(selectedItem);
    if ((taskList.first.toString() != {"empty": "table"}.toString()) &&
        (taskList.first.toString() != {"1": "1"}.toString())) {
      todayList.addAll(taskList);
    }
    if ((meetList.first.toString() != {"empty": "table"}.toString()) &&
        (meetList.first.toString() != {"1": "1"}.toString())) {
      todayList.addAll(meetList);
    }
    todayList.sort((map1, map2) {
      dynamic dateDebut1 = map1['d_d'];
      dynamic dateDebut2 = map2['d_d'];

      if (dateDebut1 != null && dateDebut2 != null) {
        return fSortEarliestTime(dateDebut1, dateDebut2) ? -1 : 1;
      } else {
        return 0;
      }
    });
    return todayList;
  }

  Future<bool> fgetdays(String selectedItem) async {
    bool test = false;
    todayList = await fsortMycalender(selectedItem);
    if (todayList.isNotEmpty) {
      test = true;
    }
    return test;
  }

  int fgetmonth(int month) {
    switch (month) {
      case 1:
        month = 31;
      case 3:
        month = 31;
      case 4:
        month = 30;
      case 5:
        month = 31;
      case 6:
        month = 30;
      case 7:
        month = 31;
      case 8:
        month = 30;
      case 9:
        month = 31;
      case 10:
        month = 30;
      case 11:
        month = 31;
      case 12:
        month = 30;
      default:
        month = 0000;
    }
    return month;
  }

  int getDaysInFebruary(int year) {
    if (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)) {
      return 29;
    } else {
      return 28;
    }
  }

  List<String> fGetdates(String date1, String date2) {
    List<String> dates = [];
    if ((date1 != '0000-00-00')) {
      int day1 = int.parse(date1.substring(8, 10));
      int month1 = int.parse(date1.substring(5, 7));
      int year1 = int.parse(date1.substring(0, 4));
      int day2 = int.parse(date2.substring(8, 10));
      int month2 = int.parse(date2.substring(5, 7));
      int year2 = int.parse(date2.substring(0, 4));

      if (((day1 != day2) || (year1 != year2) || (month1 != month2)) &&
          (date2.toString() != "0000-00-00".toString())) {
        if ((month1 != month2)) {
          int nbd = fgetmonth(month1);
          if (nbd == 0) {
            nbd = getDaysInFebruary(year1);
          }
          for (int i = day1; i <= nbd; i++) {
            if ((month1 < 10) && (i < 10)) {
              dates.add('$year1-0$month1-0$i');
            } else if ((month1 >= 10) && (i < 10)) {
              dates.add('$year1-$month1-0$i');
            } else if ((month1 < 10) && (i >= 10)) {
              dates.add('$year1-0$month1-$i');
            } else {
              dates.add('$year1-$month1-$i');
            }
          }
          for (int i = 1; i <= day2; i++) {
            if ((month2 < 10) && (i < 10)) {
              dates.add('$year2-0$month2-0$i');
            } else if ((month2 >= 10) && (i < 10)) {
              dates.add('$year2-$month2-0$i');
            } else if ((month1 < 10) && (i >= 10)) {
              dates.add('$year2-0$month2-$i');
            } else {
              dates.add('$year2-$month2-$i');
            }
          }
        } else {
          for (int i = day1; i <= day2; i++) {
            if ((month1 < 10) && (i < 10)) {
              dates.add('$year1-0$month1-0$i');
            } else if ((month1 >= 10) && (i < 10)) {
              dates.add('$year1-$month1-0$i');
            } else if ((month1 < 10) && (i >= 10)) {
              dates.add('$year1-0$month1-$i');
            } else {
              dates.add('$year1-$month1-$i');
            }
          }
        }
      } else {
        if ((month1 < 10) && (day1 < 10)) {
          dates.add('$year1-0$month1-0$day1');
        } else if ((month1 >= 10) && (day1 < 10)) {
          dates.add('$year1-$month1-0$day1');
        } else if ((month1 < 10) && (day1 >= 10)) {
          dates.add('$year1-0$month1-$day1');
        } else {
          dates.add('$year1-$month1-$day1');
        }
      }
    }
    return dates;
  }

  fConstructMyCalendarTasks() async {
    taskList = [];
    meetList = [];
    List<String> list = [];

    taskList = await fetchTasksID();
    meetList = await fetchMeets();
    if (taskList.first.toString() != {"1": "1"}.toString() &&
        (taskList.first.toString() != {'empty': 'list'}.toString())) {
      for (var map in taskList) {
        String dateDebut = map['d_d'];
        dateDebut = dateDebut.substring(0, 10);
        if (dateDebut != null) {
          list.add(dateDebut);
        }
      }
    }

    if (meetList.first.toString() != {"1": "1"}.toString() &&
        (meetList.first.toString() != {'empty': 'list'}.toString())) {
      for (var map in meetList) {
        String dateDebut = map['d_d'];
        dateDebut = dateDebut.substring(0, 10);
        if (dateDebut != null) {
          list.add(dateDebut);
        }
      }
    }
    Set<String> days = list.toSet();
    list = days.toList();
    myDays = list;
  }

  bool fCheckBusyDay(String date) {
    bool test = false;
    int i = 0;
    while ((i < myDays.length) && (!test)) {
      if (myDays[i].toString() == date.toString()) {
        test = true;
      }
      i++;
    }
    return test;
  }

  fgetcalendrier() async {
    holidayList = await fGetHolidays();
    leaveList = await fGetLeaves();
    if ((holidayList.first.toString() != {"empty": "table"}.toString()) &&
        (holidayList.first.toString() != {"1": "1"}.toString())) {
      for (var map in holidayList) {
        String dateDebut = map['d_d'];
        String dateFin = map['d_f'];
        holidayfinalList.addAll(fGetdates(dateDebut, dateFin));
      }
    } else {
      holidayfinalList = [];
    }
    if ((leaveList.first.toString() != {"empty": "table"}.toString()) &&
        (leaveList.first.toString() != {"1": "1"}.toString())) {
      for (var map in leaveList) {
        String dateDebut = map['d_d'];
        String dateFin = map['d_f'];
        leavedayfinalList.addAll(fGetdates(dateDebut, dateFin));
      }
    } else {
      leavedayfinalList = [];
    }
    await Get.to(() => PageCalendrier(
          holidayList: holidayfinalList,
          leaveList: leavedayfinalList,
        ));
  }
}
