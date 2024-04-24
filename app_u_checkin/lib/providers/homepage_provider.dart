import 'package:app_u_checkin/cache/cache_sharepreferences.dart';
import 'package:app_u_checkin/model/working_day.dart';
import 'package:app_u_checkin/model/working_week.dart';
import 'package:app_u_checkin/providers/outthem_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePageProvider extends ChangeNotifier {
  List<WorkingWeek> dataWeek = [];
  int currentIndex = 1;
  DateTime systemTime() => DateTime.now();

  getDateTimeWork(BuildContext context) async {
    dataWeek = [];
    DateTime now = DateTime.now();

    List<WorkingDay> newWorkingObj = (await NPreferences().getListDataWorkingDay(context.read<OutThemeProvider>().user.dayWork ?? '')) ?? [];

    for (int i = 0; i < newWorkingObj.length; i++) {}
    var startDate = now.subtract(Duration(days: now.weekday - 1));
    var endDate = now.add(Duration(days: 7 - now.weekday));
    List<WorkingWeek> newList = [];
    newList.add(getNowWeek(now));
    newList.add(getNextWeek(endDate));
    newList.insert(0, getLastWeek(startDate));

    for (int i = 0; i < newList.length; i++) {
      for (int j = 0; j < newList[i].dayOfWeek.length; j++) {
        for (int l = 0; l < newWorkingObj.length; l++) {
          if (DateUtils.isSameDay(newList[i].dayOfWeek[j].date, newWorkingObj[l].date)) {
            newList[i].dayOfWeek[j].checkin = newWorkingObj[l].checkin;
            newList[i].dayOfWeek[j].checkout = newWorkingObj[l].checkout;
          }
        }
      }
    }
    dataWeek.addAll(newList);
    notifyListeners();
  }

  WorkingWeek getNowWeek(DateTime date) {
    WorkingWeek week = WorkingWeek.init();
    List<WorkingDay> listWeekNow = [];
    var startDate = date.subtract(Duration(days: date.weekday - 1));
    final items = List<DateTime>.generate(7, (i) {
      DateTime list = startDate;
      return list.add(Duration(days: i));
    });
    for (int i = 0; i < items.length; i++) {
      listWeekNow.add(WorkingDay(date: items[i]));
    }
    week.dayOfWeek.addAll(listWeekNow);
    return week;
  }

  WorkingWeek getLastWeek(DateTime date) {
    WorkingWeek week = WorkingWeek.init();
    List<WorkingDay> listWeekLast = [];
    for (int i = 7; i > 0; i--) {
      var beforeDay = date.subtract(Duration(days: i));
      listWeekLast.add(WorkingDay(
        date: beforeDay,
      ));
    }
    week.dayOfWeek.addAll(listWeekLast);
    return week;
  }

  WorkingWeek getNextWeek(DateTime date) {
    WorkingWeek week = WorkingWeek.init();
    List<WorkingDay> listWeekNext = [];
    for (int i = 1; i <= 7; i++) {
      var behindDay = date.add(Duration(days: i));
      listWeekNext.add(WorkingDay(date: behindDay));
    }
    week.dayOfWeek.addAll(listWeekNext);
    return week;
  }

  getHandlePreviousButton() {
    if (dataWeek.isNotEmpty && dataWeek[0].dayOfWeek.first.date != null) {
      var lastWeek = getLastWeek(dataWeek[0].dayOfWeek.first.date!);
      dataWeek.insert(0, lastWeek);
    }
    notifyListeners();
  }

  getHandleNextButton() {
    if (dataWeek.isNotEmpty && dataWeek.last.dayOfWeek.last.date != null) {
      var nextWeek = getNextWeek(dataWeek.last.dayOfWeek.last.date!);

      dataWeek.add(nextWeek);
    }
    notifyListeners();
  }

  cleanData() {
    dataWeek = [];
    notifyListeners();
  }
}
