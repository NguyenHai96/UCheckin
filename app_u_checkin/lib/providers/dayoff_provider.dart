import 'package:app_u_checkin/cache/cache_sharepreferences.dart';
import 'package:app_u_checkin/model/dayoff.dart';
import 'package:app_u_checkin/model/working_year.dart';
import 'package:app_u_checkin/providers/outthem_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DayOffProvider extends ChangeNotifier {
  List<WorkingYear> dataYear = [];

  getData(BuildContext context) async {
    DateTime now = DateTime.now();
    List<DayOff> newDayOffObj = await NPreferences().getListDataDayOff(context.read<OutThemeProvider>().user.dayOff ?? '') ?? [];
    WorkingYear yearObj = WorkingYear.init();
    WorkingYear yearObjNext = WorkingYear.init();
    WorkingYear yearObjPrevious = WorkingYear.init();
    if (newDayOffObj.isNotEmpty) {
      for (int i = 0; i < newDayOffObj.length; i++) {
        if (newDayOffObj[i].offFrom?.year != null) {
          if (newDayOffObj[i].offFrom!.year == now.year) {
            yearObj.dayOff.add(newDayOffObj[i]);
          }
          if (newDayOffObj[i].offFrom!.year > now.year) {
            yearObjNext.dayOff.add(newDayOffObj[i]);
          }
          if (newDayOffObj[i].offFrom!.year < now.year) {
            yearObjPrevious.dayOff.add(newDayOffObj[i]);
          }
        }
      }
    }
    List<WorkingYear> newList = [];
    newList.add(yearObj);
    newList.insert(0, yearObjPrevious);
    newList.add(yearObjNext);

    dataYear.addAll(newList);
    notifyListeners();
  }

  cleanData() {
    dataYear = [];
    notifyListeners();
  }
}
