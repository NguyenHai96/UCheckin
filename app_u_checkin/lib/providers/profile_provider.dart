import 'dart:convert';

import 'package:app_u_checkin/cache/cache_sharepreferences.dart';
import 'package:app_u_checkin/model/dayoff.dart';
import 'package:app_u_checkin/model/user.dart';
import 'package:app_u_checkin/model/working_day.dart';
import 'package:app_u_checkin/model/working_year.dart';
import 'package:app_u_checkin/providers/homepage_provider.dart';
import 'package:app_u_checkin/providers/outthem_provider.dart';
import 'package:app_u_checkin/values/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePageProvider extends ChangeNotifier {
  ProfilePageProvider();

  TextEditingController date = TextEditingController();
  List<String> list = <String>['BA / QC', 'UI UX Designer', 'Web Developer', 'Mobile Developer', 'HR', 'General manager', 'Other'];
  String dropdownValue = '';
  TextEditingController nameController = TextEditingController();
  TextEditingController englishNameController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  DateTime? selectedDate;

  WorkingYear dataDayOf = WorkingYear.init();
  List<WorkingDay> listWorkDay = [];

  int annualLeave = 0;
  double onTimeRate = 0;
  double enoughWorkTime = 0;

  getNumberDayOffAnnual(BuildContext context) async {
    // final tempUser = context.read<OutThemeProvider>().user;
    List<DayOff> listDayOff = await NPreferences().getListDataDayOff(context.read<OutThemeProvider>().user.dayOff ?? '') ?? [];
    int restDayOff = 12;
    for (int i = 0; i < listDayOff.length; i++) {
      restDayOff = restDayOff - (listDayOff[i].getAnnualLeaveNumber());
    }
    notifyListeners();
    return restDayOff;
  }

  getAnnualLeaveStart(BuildContext context) async {
    int restDayOff = await getNumberDayOffAnnual(context);
    if (restDayOff > 0) {
      annualLeave = restDayOff;
    }
    notifyListeners();
  }

  getRateTimeFromUser(BuildContext context) async {
    // final tempUser = context.read<OutThemeProvider>().user;
    int checkInOnTime = 0;
    List<WorkingDay> listWorkDay = (await NPreferences().getListDataWorkingDay(context.read<OutThemeProvider>().user.dayWork ?? ''));
    for (int i = 0; i < listWorkDay.length; i++) {
      if (listWorkDay[i].checkWrongTimeCheckIn() == true) {
        print('listWorkDay[i].checkin ------>>> ${listWorkDay[i].checkin}');
        checkInOnTime++;
      }
    }
    onTimeRate = ((checkInOnTime / listWorkDay.length) * 100);

    notifyListeners();
  }

  getWorkTime(BuildContext context) async {
    final tempUser = context.read<OutThemeProvider>().user;
    int checkWorkTime = 0;
    listWorkDay = (await NPreferences().getListDataWorkingDay(tempUser.dayWork.toString())).cast<WorkingDay>();
    for (int i = 0; i < listWorkDay.length; i++) {
      if (listWorkDay[i].checkEnoughWorkTime() == true) {
        checkWorkTime++;
      }
    }
    enoughWorkTime = ((checkWorkTime / listWorkDay.length) * 100);
    notifyListeners();
  }

  colorDropDownValue(String value) {
    if (value == 'BA / QC') {
      return AppColors.baQc;
    } else {
      if (value == 'UI UX Designer') {
        return AppColors.uiUx;
      } else if (value == 'Web Developer') {
        return AppColors.webDev;
      } else if (value == 'Mobile Developer') {
        return AppColors.mobileDev;
      } else if (value == 'HR') {
        return AppColors.hr;
      } else if (value == 'General manager') {
        return AppColors.generalManager;
      } else if (value == 'Other') {
        return AppColors.other;
      } else {
        return Colors.transparent;
      }
    }
  }

  User valuePop = User();

  saveChangeInfoProfile(BuildContext context) {
    // User tempUser = NPreferences().getUser(context.read<HomePageProvider>().user.email.toString()) as User;
    if (nameController.text != context.read<OutThemeProvider>().user.name && nameController.text != '') {
      context.read<OutThemeProvider>().user.name = nameController.text;
    }

    if (context.read<OutThemeProvider>().user.nameEnglish != englishNameController.text && englishNameController.text != '') {
      context.read<OutThemeProvider>().user.nameEnglish = englishNameController.text;
    }
    if (context.read<OutThemeProvider>().user.dOB != date.text && date.text != '') {
      context.read<OutThemeProvider>().user.dOB = date.text;
    }
    if (context.read<OutThemeProvider>().user.position != positionController.text && positionController.text != '') {
      context.read<OutThemeProvider>().user.position = positionController.text;
    }
    if (context.read<OutThemeProvider>().user.team != dropdownValue && dropdownValue != '') {
      context.read<OutThemeProvider>().user.team = dropdownValue;
    }

    valuePop = context.read<OutThemeProvider>().user;
    final newUserJson = jsonEncode(context.read<OutThemeProvider>().user.toJson());

    NPreferences().saveData(context.read<OutThemeProvider>().user.email ?? '', newUserJson);
    notifyListeners();
  }
}
