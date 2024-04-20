import 'dart:convert';

import 'package:app_u_checkin/cache/cache_sharepreferences.dart';
import 'package:app_u_checkin/model/user.dart';
import 'package:flutter/material.dart';

class OutThemeProvider extends ChangeNotifier {
  User user = User();
  OutThemeProvider({required this.user});

  getUserThenStartApp(String key) {
    user = NPreferences().getUser(key) as User;
    return user;
  }

  resetData() {
    user = User();
  }
}
