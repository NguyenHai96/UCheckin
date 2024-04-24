// ignore_for_file: use_build_context_synchronously, annotate_overrides

import 'dart:convert';

import 'package:app_u_checkin/cache/cache_sharepreferences.dart';
import 'package:app_u_checkin/model/user.dart';
import 'package:app_u_checkin/pages/home_page.dart';
import 'package:app_u_checkin/providers/outthem_provider.dart';
import 'package:app_u_checkin/values/share_keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPageProvider extends ChangeNotifier {
  LoginPageProvider();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isHidden = true;
  bool isActiveSignUp = false;

  void togglePasswordView() {
    isHidden = !isHidden;
    notifyListeners();
  }

  bool checkSignUp() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      notifyListeners();
      return true;
    }
    notifyListeners();
    return false;
  }

  saveDataAndLogin(BuildContext context) async {
    List<String> listUser = await NPreferences().getDataString(ShareKeys.listUser);
    for (int i = 0; i < listUser.length; i++) {
      if (listUser[i] == emailController.text) {
        var user = await NPreferences().getData(emailController.text);
        Map<String, dynamic>? valueMap = jsonDecode(user as String);
        User tempUser = User();
        if (valueMap != null) {
          tempUser = User.formJson(valueMap);
          if (tempUser.password == passwordController.text) {
            context.read<OutThemeProvider>().user = tempUser;

            await NPreferences().saveData(ShareKeys.checkLogin, emailController.text);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext ctx) => const HomePage()));
          } else {
            print('Ten dang nhap hoac mat khau khong dung! Xin moi nhap lai');
          }
        }
      }
    }
    notifyListeners();
  }

  cleanData() {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    notifyListeners();
  }
}
