// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, prefer_typing_uninitialized_variables
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:app_u_checkin/cache/cache_sharepreferences.dart';
import 'package:app_u_checkin/model/user.dart';
import 'package:app_u_checkin/model/working_day.dart';
import 'package:app_u_checkin/pages/check_in_page.dart';
import 'package:app_u_checkin/pages/home_page.dart';
import 'package:app_u_checkin/pages/input_profile.dart';
import 'package:app_u_checkin/pages/login_page.dart';
import 'package:app_u_checkin/pages/profile_page.dart';
import 'package:app_u_checkin/pages/sign_up_page.dart';
import 'package:app_u_checkin/providers/checkin_page_provider.dart';
import 'package:app_u_checkin/providers/dayoff_provider.dart';
import 'package:app_u_checkin/providers/homepage_provider.dart';
import 'package:app_u_checkin/providers/input_profile_provider.dart';
import 'package:app_u_checkin/providers/login_provider.dart';
import 'package:app_u_checkin/providers/makedayoff_provider.dart';
import 'package:app_u_checkin/providers/outthem_provider.dart';
import 'package:app_u_checkin/providers/profile_provider.dart';
import 'package:app_u_checkin/providers/sign_up_provider.dart';
import 'package:app_u_checkin/values/share_keys.dart';

void main() async {
  String checkUser = '';
  WidgetsFlutterBinding.ensureInitialized();
  User userHome = User();
  if (ShareKeys.checkLogin.isNotEmpty) {
    checkUser = await NPreferences().getData(ShareKeys.checkLogin) ?? '';
    var takeUser = checkUser;
    if (checkUser != '') {
      var checkUser = await NPreferences().getData(takeUser);
      Map<String, dynamic>? valueMap = jsonDecode(checkUser as String);
      if (valueMap != null) {
        userHome = User.formJson(valueMap);
      }
    }
  }

  runApp(MyApp(
    checkLogin: checkUser,
    tempUser: userHome,
  ));
}

class MyApp extends StatelessWidget {
  String checkLogin;
  User tempUser;

  MyApp({
    super.key,
    required this.checkLogin,
    required this.tempUser,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OutThemeProvider(user: tempUser)),
        ChangeNotifierProvider(create: (_) => HomePageProvider()),
        ChangeNotifierProvider(create: (_) => CheckInPageProvider()),
        ChangeNotifierProvider(create: (_) => ProfilePageProvider()),
        ChangeNotifierProvider(create: (_) => LoginPageProvider()),
        ChangeNotifierProvider(create: (_) => SignUpProvider()),
        ChangeNotifierProvider(create: (_) => InputProfileProvider()),
        ChangeNotifierProvider(create: (_) => MakeDayOffProvider()),
        ChangeNotifierProvider(create: (_) => DayOffProvider())
      ],
      child: ScreenUtilInit(
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
            home: checkLogin == '' ? const LoginPage() : const HomePage(),
          );
        },
      ),
    );
  }
}
