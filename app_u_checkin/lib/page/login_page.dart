import 'dart:convert';

import 'package:app_u_checkin/cache/cache_sharepreferences.dart';
import 'package:app_u_checkin/model/user.dart';
import 'package:app_u_checkin/page/home_page.dart';
import 'package:app_u_checkin/page/sign_up_page.dart';
import 'package:app_u_checkin/values/app_assets.dart';
import 'package:app_u_checkin/values/app_colors.dart';
import 'package:app_u_checkin/values/app_styles.dart';
import 'package:app_u_checkin/values/share_keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isHidden = true;
  bool _isActiveSignUp = false;

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  bool _checkSignUp() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 97.h),
                  child: Container(
                    width: 141.w,
                    height: 141.h,
                    child: Image.asset(
                      AppAssets.logo,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 26.h,
                        width: 133.w,
                        child: Image.asset(
                          AppAssets.ucheckin,
                          fit: BoxFit.contain,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 64.h),
            child: SizedBox(
              width: 272.w,
              height: 269.h,
              child: SizedBox(
                width: 272.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 17.h,
                      width: 272.w,
                      child: Text(
                        'Email',
                        style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontWeight: FontWeight.bold, fontSize: 14.sp, color: AppColors.main),
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Container(
                      height: 48.h,
                      width: 272.w,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      decoration: BoxDecoration(color: AppColors.login, borderRadius: BorderRadius.all(Radius.circular(10.r))),
                      child: TextFormField(
                        controller: emailController,
                        onChanged: (value) {
                          setState(() {
                            _isActiveSignUp = _checkSignUp();
                          });
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter',
                          suffixStyle: TextStyle(fontSize: 16.sp, fontFamily: FontFamily.bai_jamjuree),
                          fillColor: AppColors.text,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16.h),
                      child: SizedBox(
                        height: 17.h,
                        width: 272.w,
                        child: Text(
                          'Password',
                          style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontWeight: FontWeight.bold, fontSize: 14.sp, color: AppColors.main),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Container(
                      height: 48.h,
                      width: 272.w,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      decoration: BoxDecoration(color: AppColors.login, borderRadius: BorderRadius.all(Radius.circular(10.r))),
                      child: TextFormField(
                        obscureText: _isHidden,
                        controller: passwordController,
                        onChanged: (value) {
                          setState(() {
                            _isActiveSignUp = _checkSignUp();
                          });
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter',
                            suffixStyle: TextStyle(fontSize: 16.sp, fontFamily: FontFamily.bai_jamjuree),
                            fillColor: AppColors.text,
                            suffix: InkWell(
                              onTap: _togglePasswordView,
                              child: Icon(_isHidden ? Icons.visibility : Icons.visibility_off),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    SizedBox(
                      width: 272.w,
                      height: 19.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (_) => SignUpPage()));
                            },
                            child: Text(
                              'Sign up',
                              style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 14.sp, color: AppColors.main),
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Text(
                              'Forgot password?',
                              style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 14.sp, color: AppColors.main),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                    InkWell(
                      onTap: _isActiveSignUp
                          ? () async {
                              List<String> listUser = await NPreferences().getDataString(ShareKeys.listKey) as List<String>;
                              for (int i = 0; i < listUser.length; i++) {
                                if (listUser[i] == emailController.text) {
                                  var user = await NPreferences().getData(emailController.text);
                                  Map<String, dynamic>? valueMap = jsonDecode(user as String);
                                  User ipUser = User();
                                  if (valueMap != null) {
                                    ipUser = User.formJson(valueMap);
                                    if (ipUser.password == passwordController.text) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => HomePage(
                                                    newUser: ipUser,
                                                  )));
                                    }
                                  }
                                }
                              }
                            }
                          : null,
                      child: Container(
                        height: 48.h,
                        width: 272.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8.r)), color: _isActiveSignUp ? AppColors.checkout : Colors.grey),
                        child: Text(
                          'Log in',
                          style: TextStyle(
                              fontFamily: FontFamily.bai_jamjuree,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: _isActiveSignUp ? Colors.white : Colors.black),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 80.h,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 51.5.w),
                    width: 272.w,
                    height: 48.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 40.h,
                          width: 40.w,
                          child: Image.asset(AppAssets.slack),
                        ),
                        Text(
                          'Log in by Slack',
                          style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 16.sp, color: AppColors.main, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.r)),
                      border: Border.all(width: 0.5.w, color: AppColors.main),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 272.w,
                    height: 48.h,
                    child: Text(
                      'Log in by Manager',
                      style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 16.sp, color: AppColors.main, fontWeight: FontWeight.bold),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.r)),
                      border: Border.all(width: 0.5.w, color: AppColors.main),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
