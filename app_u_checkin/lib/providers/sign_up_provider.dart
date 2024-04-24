// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:app_u_checkin/cache/cache_sharepreferences.dart';
import 'package:app_u_checkin/pages/input_profile.dart';
import 'package:app_u_checkin/providers/outthem_provider.dart';
import 'package:app_u_checkin/values/share_keys.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  String valuePass = '';
  String valueEmail = '';
  bool isActiveSignUp = false;
  bool isHidden = true;
  String valueCheck = '';

  void togglePasswordView() {
    isHidden = !isHidden;
    notifyListeners();
  }

  bool checkSignUp() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty && rePasswordController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  void printEmail() {
    emailController.addListener(() {
      final String text = emailController.text;

      emailController.value = emailController.value
          .copyWith(text: text, selection: TextSelection(baseOffset: text.length, extentOffset: text.length), composing: TextRange.empty);
    });
    notifyListeners();
  }

  saveDataAndNavigator(BuildContext context) async {
    List<String> listKey = (await NPreferences().getDataString(ShareKeys.listUser));
    // var user = context.read<OutThemeProvider>().user;
    if (rePasswordController.text == passwordController.text) {
      context.read<OutThemeProvider>().user.id = DateTime.now().microsecondsSinceEpoch;
      context.read<OutThemeProvider>().user.email = emailController.text;
      context.read<OutThemeProvider>().user.password = passwordController.text;
      context.read<OutThemeProvider>().user.dayWork = '${context.read<OutThemeProvider>().user.id}dayWork';
      context.read<OutThemeProvider>().user.dayOff = '${context.read<OutThemeProvider>().user.id}dayOff';

      final newUserJson = jsonEncode(context.read<OutThemeProvider>().user.toJson());
      await NPreferences().saveData(context.read<OutThemeProvider>().user.email.toString(), newUserJson);
      listKey.add(emailController.text);
      await NPreferences().saveData(ShareKeys.listUser, listKey);
      await NPreferences().saveData(ShareKeys.checkLogin, emailController.text);
      Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfilePage()));
    } else {
      print('Nhap lai mat khau khong dung');
    }
    notifyListeners();
  }
}
