import 'package:app_u_checkin/cache/cache_sharepreferences.dart';
import 'package:app_u_checkin/model/dayoff.dart';
import 'package:app_u_checkin/model/working_year.dart';
import 'package:app_u_checkin/providers/homepage_provider.dart';
import 'package:app_u_checkin/providers/outthem_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DayOffProvider extends ChangeNotifier {
  List<WorkingYear> dataYear = [];

  int currentIndex = 1;
  DateTime now = DateTime.now();

  getData(BuildContext context) async {
    List<DayOff> newDayOffObj = await NPreferences().getListDataDayOff(context.read<OutThemeProvider>().user.dayOff.toString()) ?? [];
    List<WorkingYear> newList = [];
    WorkingYear yearObj = WorkingYear.init();
    yearObj.dayOff.addAll(newDayOffObj);
    newList.add(yearObj);
    dataYear.addAll(newList);
  }
}
