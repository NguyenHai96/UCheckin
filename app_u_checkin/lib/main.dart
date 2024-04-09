// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, prefer_typing_uninitialized_variables
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:app_u_checkin/cache/cache_sharepreferences.dart';
import 'package:app_u_checkin/model/user.dart';
import 'package:app_u_checkin/page/check_in_page.dart';
import 'package:app_u_checkin/page/home_page.dart';
import 'package:app_u_checkin/page/input_profile.dart';
import 'package:app_u_checkin/page/login_page.dart';
import 'package:app_u_checkin/page/profile_page.dart';
import 'package:app_u_checkin/page/sign_up_page.dart';
import 'package:app_u_checkin/values/share_keys.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var user = await NPreferences().getData('user');

  runApp(MyApp(
    user: user,
  ));
}

class MyApp extends StatelessWidget {
  var user;

  MyApp({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    User tempUser = User();
    if (user != null) {
      Map<String, dynamic>? valueMap = jsonDecode(user);
      if (valueMap != null) {
        tempUser = User.formJson(valueMap);
      }
    }
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: user == null ? const LoginPage() : HomePage(newUser: tempUser),
        );
      },
    );
  }
}
