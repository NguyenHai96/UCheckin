// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:app_u_checkin/cache/cache_sharepreferences.dart';
import 'package:app_u_checkin/model/user.dart';
import 'package:app_u_checkin/pages/home_page.dart';
import 'package:app_u_checkin/providers/homepage_provider.dart';
import 'package:app_u_checkin/providers/outthem_provider.dart';
import 'package:app_u_checkin/providers/sign_up_provider.dart';
import 'package:app_u_checkin/values/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InputProfileProvider extends ChangeNotifier {
  InputProfileProvider();

  final TextEditingController date = TextEditingController();
  List<String> list = <String>['BA / QC', 'UI UX Designer', 'Web Developer', 'Mobile Developer', 'HR', 'General manager', 'Other'];
  String dropdownValue = '';
  TextEditingController nameController = TextEditingController();
  TextEditingController englishNameController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  DateTime? selectedDate;

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

  saveDataAndNavigator(BuildContext context) async {
    // final user = context.read<OutThemeProvider>().user;
    context.read<OutThemeProvider>().user.name = nameController.text;
    context.read<OutThemeProvider>().user.nameEnglish = englishNameController.text;
    context.read<OutThemeProvider>().user.dOB = date.text;
    context.read<OutThemeProvider>().user.position = positionController.text;
    context.read<OutThemeProvider>().user.team = dropdownValue;

    final newUserJson = jsonEncode(context.read<OutThemeProvider>().user.toJson());
    await NPreferences().saveData(context.read<OutThemeProvider>().user.email.toString(), newUserJson);
    Navigator.push(context, MaterialPageRoute(builder: (_) => const HomePage()));
  }
}
