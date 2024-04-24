import 'package:app_u_checkin/cache/cache_sharepreferences.dart';
import 'package:app_u_checkin/model/dayoff.dart';
import 'package:app_u_checkin/model/working_day.dart';
import 'package:app_u_checkin/model/working_year.dart';
import 'package:app_u_checkin/providers/checkin_page_provider.dart';
import 'package:app_u_checkin/providers/dayoff_provider.dart';
import 'package:app_u_checkin/providers/homepage_provider.dart';
import 'package:app_u_checkin/providers/login_provider.dart';
import 'package:app_u_checkin/providers/outthem_provider.dart';
import 'package:app_u_checkin/values/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProfilePageProvider extends ChangeNotifier {
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
    int checkInOnTime = 0;
    List<WorkingDay> listWorkDay = (await NPreferences().getListDataWorkingDay(context.read<OutThemeProvider>().user.dayWork ?? ''));
    for (int i = 0; i < listWorkDay.length; i++) {
      if (listWorkDay[i].checkWrongTimeCheckIn() == true) {
        checkInOnTime++;
      }
    }
    if (checkInOnTime != 0) {
      onTimeRate = ((checkInOnTime / listWorkDay.length) * 100);
    } else {
      onTimeRate = 0;
    }
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

    if (checkWorkTime != 0) {
      enoughWorkTime = ((checkWorkTime / listWorkDay.length) * 100);
    } else {
      enoughWorkTime = 0;
    }
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

  // bool checkEditData() {
  //   if (dropdownValue.isNotEmpty &&
  //       nameController.text.isNotEmpty &&
  //       englishNameController.text.isNotEmpty &&
  //       positionController.text.isNotEmpty &&
  //       date.text.isNotEmpty) {
  //     return true;
  //   }
  //   return false;
  // }

  bool isDate(String input, String format) {
    try {
      final DateTime d = DateFormat(format).parseStrict(input);
      return true;
    } catch (e) {
      return false;
    }
  }

  inputValueBOD(String value, BuildContext context) {
    if (value != '' && isDate(value, "dd/MM/yyyy")) {
      print('vao trong roi');
      selectedDate = DateFormat("dd/MM/yyyy").parse(value);
      date.text = DateFormat('dd/MM/yyyy').format(selectedDate!);
    }
    notifyListeners();
  }

  cleanData(BuildContext context) {
    dropdownValue = '';
    nameController = TextEditingController();
    englishNameController = TextEditingController();
    positionController = TextEditingController();
    context.read<CheckInPageProvider>().cleanData();
    context.read<HomePageProvider>().cleanData();
    context.read<DayOffProvider>().cleanData();
    context.read<OutThemeProvider>().resetData();
    context.read<LoginPageProvider>().cleanData();
    notifyListeners();
  }
}
