import 'dart:convert';
import 'dart:developer';

import 'package:app_u_checkin/cache/cache_sharepreferences.dart';
import 'package:app_u_checkin/model/user.dart';
import 'package:app_u_checkin/pages/input_profile.dart';
import 'package:app_u_checkin/providers/sign_up_provider.dart';
import 'package:app_u_checkin/values/app_assets.dart';
import 'package:app_u_checkin/values/app_colors.dart';
import 'package:app_u_checkin/values/app_styles.dart';
import 'package:app_u_checkin/values/share_keys.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, SignUpProvider signUp, _) {
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 97.h),
                      child: SizedBox(
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
                          SizedBox(
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
                padding: EdgeInsets.only(top: 65.h),
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
                        padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
                        decoration: BoxDecoration(color: AppColors.login, borderRadius: BorderRadius.all(Radius.circular(10.r))),
                        child: TextFormField(
                          controller: signUp.emailController,
                          onChanged: (text) => {
                            setState(() {
                              signUp.isActiveSignUp = signUp.checkSignUp();
                            })
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter your email',
                            suffixStyle: TextStyle(fontSize: 16.sp, fontFamily: FontFamily.bai_jamjuree),
                            fillColor: AppColors.hintText,
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
                            style:
                                TextStyle(fontFamily: FontFamily.bai_jamjuree, fontWeight: FontWeight.bold, fontSize: 14.sp, color: AppColors.main),
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
                        padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
                        decoration: BoxDecoration(color: AppColors.login, borderRadius: BorderRadius.all(Radius.circular(10.r))),
                        child: TextFormField(
                          obscureText: signUp.isHidden,
                          controller: signUp.passwordController,
                          onChanged: (text) {
                            setState(() {
                              signUp.isActiveSignUp = signUp.checkSignUp();
                            });
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter your passwoord',
                              suffixStyle: TextStyle(fontSize: 16.sp, fontFamily: FontFamily.bai_jamjuree),
                              fillColor: AppColors.text,
                              suffix: InkWell(
                                onTap: signUp.togglePasswordView,
                                child: Icon(signUp.isHidden ? Icons.visibility : Icons.visibility_off),
                              )),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
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
                            'Confirm Password',
                            style:
                                TextStyle(fontFamily: FontFamily.bai_jamjuree, fontWeight: FontWeight.bold, fontSize: 14.sp, color: AppColors.main),
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
                        padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
                        decoration: BoxDecoration(color: AppColors.login, borderRadius: BorderRadius.all(Radius.circular(10.r))),
                        child: TextFormField(
                          obscureText: signUp.isHidden,
                          controller: signUp.rePasswordController,
                          onChanged: (textRe) {
                            setState(() {
                              signUp.isActiveSignUp = signUp.checkSignUp();
                            });
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Re-Enter your passwoord',
                              suffixStyle: TextStyle(fontSize: 16.sp, fontFamily: FontFamily.bai_jamjuree),
                              fillColor: AppColors.text,
                              suffix: InkWell(
                                onTap: signUp.togglePasswordView,
                                child: Icon(signUp.isHidden ? Icons.visibility : Icons.visibility_off),
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
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Login',
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
                        onTap: signUp.isActiveSignUp
                            ? () async {
                                await signUp.saveDataAndNavigator(context);
                              }
                            : null,
                        child: Container(
                          height: 48.h,
                          width: 272.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(8.r)), color: signUp.isActiveSignUp ? AppColors.checkout : Colors.grey),
                          child: Text(
                            'Sign up',
                            style: TextStyle(
                                color: signUp.isActiveSignUp ? Colors.white : Colors.black,
                                fontFamily: FontFamily.bai_jamjuree,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
