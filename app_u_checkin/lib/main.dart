// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, prefer_typing_uninitialized_variables
import 'dart:convert';

import 'package:app_u_checkin/model/working_day.dart';
import 'package:app_u_checkin/providers/checkin_page_provider.dart';
import 'package:app_u_checkin/providers/homepage_provider.dart';
import 'package:app_u_checkin/providers/login_provider.dart';
import 'package:app_u_checkin/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
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
  String checkUser = '';
  if (ShareKeys.checkLogin != null) {
    checkUser = (await NPreferences().getData(ShareKeys.checkLogin)) ?? '';
  }

  runApp(MyApp(
    user: checkUser,
  ));
}

class MyApp extends StatelessWidget {
  String user;

  MyApp({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    // var checkUser;
    User userHome = User();
    if (user != '') {
      var checkUser = NPreferences().getData(user);
      if (checkUser != null) {
        Map<String, dynamic>? valueMap = jsonDecode(checkUser as String);
        if (valueMap != null) {
          userHome = User.formJson(valueMap);
          // userHome = NPreferences().getUser(checkUser.email.toString());
          // if (tempUser != null) {
          // Map<String, dynamic> valueMapHome = jsonDecode(tempUser);
          // userHome = User.formJson(valueMapHome);
        }
      }
    }
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomePageProvider(user: userHome)),
        ChangeNotifierProvider(create: (_) => CheckInPageProvider(user: userHome)),
        ChangeNotifierProvider(create: (_) => ProfilePageProvider()),
        ChangeNotifierProvider(create: (_) => LoginPageProvider())
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
            home: user == '' ? const LoginPage() : const HomePage(),
          );
        },
      ),
    );
  }
}
