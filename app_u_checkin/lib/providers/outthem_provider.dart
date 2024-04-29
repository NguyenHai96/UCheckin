// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:app_u_checkin/cache/cache_sharepreferences.dart';
import 'package:app_u_checkin/model/dayoff.dart';
import 'package:app_u_checkin/model/user.dart';
import 'package:app_u_checkin/model/working_day.dart';
import 'package:app_u_checkin/pages/bottom_navigator_bar.dart';
import 'package:app_u_checkin/pages/day_off_page.dart';
import 'package:app_u_checkin/providers/bottom_navigation_provider.dart';
import 'package:app_u_checkin/providers/dayoff_provider.dart';
import 'package:app_u_checkin/providers/makedayoff_provider.dart';
import 'package:app_u_checkin/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OutThemeProvider extends ChangeNotifier {
  User user = User();
  OutThemeProvider({required this.user});

  getUserThenStartApp(String key) {
    user = NPreferences().getUser(key) as User;
    return user;
  }

  saveChangeInfoProfile(BuildContext context) {
    // User tempUser = NPreferences().getUser(context.read<HomePageProvider>().user.email.toString()) as User;
    if (context.read<ProfilePageProvider>().nameController.text != user.name && context.read<ProfilePageProvider>().nameController.text != '') {
      user.name = context.read<ProfilePageProvider>().nameController.text;
    }

    if (user.nameEnglish != context.read<ProfilePageProvider>().englishNameController.text &&
        context.read<ProfilePageProvider>().englishNameController.text != '') {
      user.nameEnglish = context.read<ProfilePageProvider>().englishNameController.text;
    }
    if (user.dOB != context.read<ProfilePageProvider>().date.text && context.read<ProfilePageProvider>().date.text != '') {
      user.dOB = context.read<ProfilePageProvider>().date.text;
    }
    if (user.position != context.read<ProfilePageProvider>().positionController.text &&
        context.read<ProfilePageProvider>().positionController.text != '') {
      user.position = context.read<ProfilePageProvider>().positionController.text;
    }
    if (user.team != context.read<ProfilePageProvider>().dropdownValue && context.read<ProfilePageProvider>().dropdownValue != '') {
      user.team = context.read<ProfilePageProvider>().dropdownValue;
    }

    // valuePop = context.read<OutThemeProvider>().user;
    final newUserJson = jsonEncode(user.toJson());

    NPreferences().saveData(user.email.toString(), newUserJson);
    notifyListeners();
  }

  saveDataAndNavigatorDayOff(BuildContext context) async {
    List<DayOff> listDayOff = await NPreferences().getListDataDayOff(user.dayOff.toString());
    int numberDayOff = 0;
    DateTime? fromDate = context.read<MakeDayOffProvider>().selectedFormDate;
    DateTime? toDate = context.read<MakeDayOffProvider>().selectedToDate;
    if (toDate != null && fromDate != null) {
      while (toDate.difference(fromDate!).inDays > 0) {
        fromDate = fromDate.add(const Duration(days: 1));
        if (fromDate.weekday != DateTime.saturday && fromDate.weekday != DateTime.sunday) {
          numberDayOff++;
        }
      }
    }
    context.read<MakeDayOffProvider>().dayoff.type = context.read<MakeDayOffProvider>().dropdownValue;
    context.read<MakeDayOffProvider>().dayoff.offFrom = context.read<MakeDayOffProvider>().selectedFormDate;
    context.read<MakeDayOffProvider>().dayoff.offTo = context.read<MakeDayOffProvider>().selectedToDate;
    context.read<MakeDayOffProvider>().dayoff.description = context.read<MakeDayOffProvider>().descriptionControler.text;
    context.read<MakeDayOffProvider>().dayoff.numberDayOff = numberDayOff;

    listDayOff.add(context.read<MakeDayOffProvider>().dayoff);
    List<String> newDayOffJson = listDayOff.map((e) => jsonEncode(e.toJson())).toList();
    await NPreferences().saveData(user.dayOff.toString(), newDayOffJson);
    context.read<DayOffProvider>().cleanData();
    Navigator.push(context, MaterialPageRoute(builder: (_) => const BottomNavigatorBar()));
    context.read<BottomNavigationBarProvider>().setCurentIndexToDayOff();
    notifyListeners();
  }

  saveDataInLocalCheckIn(WorkingDay value, BuildContext context) async {
    List<WorkingDay> listWorkingDay = await NPreferences().getListDataWorkingDay(user.dayWork.toString());
    listWorkingDay.add(value);
    List<String> newWokingDayJson = listWorkingDay.map((e) => jsonEncode(e.toJson())).toList();
    await NPreferences().saveData(user.dayWork.toString(), newWokingDayJson);
    notifyListeners();
  }

  resetData() {
    user = User();
    notifyListeners();
  }
}
