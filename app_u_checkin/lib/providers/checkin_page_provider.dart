// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:app_u_checkin/cache/cache_sharepreferences.dart';
import 'package:app_u_checkin/model/working_day.dart';
import 'package:app_u_checkin/model/working_month.dart';
import 'package:app_u_checkin/providers/outthem_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckInPageProvider extends ChangeNotifier {
  List<WorkingMonth> dataMonth = [];
  int currentIndex = 1;
  DateTime systemTime() => DateTime.now();
  List<WorkingDay> listWorkingDay = [];
  WorkingDay? valuePop;

  getDateTimeWork(BuildContext context) async {
    DateTime now = DateTime.now();

    List<WorkingDay> newWorkingObj = await NPreferences().getListDataWorkingDay(context.read<OutThemeProvider>().user.dayWork.toString());
    List<WorkingMonth> newList = [];
    newList.add(getNowMonth(now));
    newList.add(getNextMonth(now));
    newList.insert(0, getLastMonth(now));

    for (int i = 0; i < newList.length; i++) {
      for (int j = 0; j < newList[i].dayOfWeek.length; j++) {
        for (int l = 0; l < newWorkingObj.length; l++) {
          if (newList[i].dayOfWeek[j].date == newWorkingObj[l].date) {
            newList[i].dayOfWeek[j].checkin = newWorkingObj[l].checkin;
            newList[i].dayOfWeek[j].checkout = newWorkingObj[l].checkout;
          }
        }
      }
    }
    dataMonth.addAll(newList);
    notifyListeners();
  }

  WorkingMonth getNowMonth(DateTime date) {
    WorkingMonth month = WorkingMonth.init();
    List<WorkingDay> listMonthNow = [];
    DateTime startDateMonth = DateTime(date.year, date.month);
    DateTime endDateMonth = DateTime(date.year, date.month + 1);
    int daysInMonth = DateTimeRange(start: startDateMonth, end: endDateMonth).duration.inDays;

    final items = List<DateTime>.generate(daysInMonth, (i) {
      DateTime fristDay = DateTime(date.year, date.month, 1);
      return fristDay.add(Duration(days: i));
    });
    for (int i = 0; i < items.length; i++) {
      listMonthNow.add(WorkingDay(date: items[i]));
    }
    month.dayOfWeek.addAll(listMonthNow);
    return month;
  }

  WorkingMonth getLastMonth(DateTime date) {
    WorkingMonth month = WorkingMonth.init();
    List<WorkingDay> listMonthLast = [];
    DateTime startDateMonth = DateTime(date.year, date.month - 1);
    DateTime endDateMonth = DateTime(date.year, date.month);
    int daysInMonth = DateTimeRange(start: startDateMonth, end: endDateMonth).duration.inDays;

    final items = List<DateTime>.generate(daysInMonth, (i) {
      DateTime fristDay = DateTime(date.year, date.month - 1, 1);
      return fristDay.add(Duration(days: i));
    });
    for (int i = 0; i < items.length; i++) {
      listMonthLast.add(WorkingDay(date: items[i]));
    }
    month.dayOfWeek.addAll(listMonthLast);
    return month;
  }

  WorkingMonth getNextMonth(DateTime date) {
    WorkingMonth month = WorkingMonth.init();
    List<WorkingDay> listMonthNext = [];
    DateTime startDateMonth = DateTime(date.year, date.month + 1);
    DateTime endDateMonth = DateTime(date.year, date.month + 2);
    int daysInMonth = DateTimeRange(start: startDateMonth, end: endDateMonth).duration.inDays;

    final items = List<DateTime>.generate(daysInMonth, (i) {
      DateTime fristDay = DateTime(date.year, date.month + 1, 1);
      return fristDay.add(Duration(days: i));
    });
    for (int i = 0; i < items.length; i++) {
      listMonthNext.add(WorkingDay(date: items[i]));
    }
    month.dayOfWeek.addAll(listMonthNext);
    return month;
  }

  getHandlePreviousButton() {
    if (dataMonth.isNotEmpty && dataMonth[0].dayOfWeek.first.date != null) {
      var lastMonth = getLastMonth(dataMonth[0].dayOfWeek.first.date!);
      currentIndex = 1;
      dataMonth.insert(0, lastMonth);
    }
    notifyListeners();
  }

  getHandleNextButton() {
    if (currentIndex >= dataMonth.length - 1) {
      if (dataMonth.isNotEmpty && dataMonth.last.dayOfWeek.last.date != null) {
        var nextMonth = getNextMonth(dataMonth.last.dayOfWeek.last.date!);
        dataMonth.add(nextMonth);
      }
    }
    notifyListeners();
  }

  String monthTitle = "";
  doMonthState() {
    if (dataMonth.isNotEmpty) {
      if (currentIndex < dataMonth.length) {
        monthTitle = dataMonth[currentIndex].getMonthTitle();
      }
    }
    notifyListeners();
  }

  saveDataInLocal(WorkingDay value, BuildContext context) async {
    listWorkingDay = await NPreferences().getListDataWorkingDay(context.read<OutThemeProvider>().user.dayWork.toString());
    listWorkingDay.add(value);
    List<String> newWokingDayJson = listWorkingDay.map((e) => jsonEncode(e.toJson())).toList();
    await NPreferences().saveData(context.read<OutThemeProvider>().user.dayWork.toString(), newWokingDayJson);
    notifyListeners();
  }
}
