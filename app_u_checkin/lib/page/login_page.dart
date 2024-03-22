import 'package:app_u_checkin/values/app_assets.dart';
import 'package:app_u_checkin/values/app_colors.dart';
import 'package:app_u_checkin/values/app_styles.dart';
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
  bool _isHidden = true;

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
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
              child: Expanded(
                child: Container(
                  width: 272.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 17.h,
                        width: 272.w,
                        child: Text(
                          'Email',
                          style: TextStyle(
                              fontFamily: FontFamily.bai_jamjuree,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                              color: AppColors.main),
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
                        decoration: BoxDecoration(
                            color: AppColors.login,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.r))),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Enter',
                            suffixStyle: TextStyle(
                                fontSize: 16.sp,
                                fontFamily: FontFamily.bai_jamjuree),
                            fillColor: AppColors.text,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16.h),
                        child: SizedBox(
                          height: 17.h,
                          width: 272.w,
                          child: Text(
                            'Password',
                            style: TextStyle(
                                fontFamily: FontFamily.bai_jamjuree,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                                color: AppColors.main),
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
                        decoration: BoxDecoration(
                            color: AppColors.login,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.r))),
                        child: TextField(
                          obscureText: _isHidden,
                          decoration: InputDecoration(
                              hintText: 'Enter',
                              suffixStyle: TextStyle(
                                  fontSize: 16.sp,
                                  fontFamily: FontFamily.bai_jamjuree),
                              fillColor: AppColors.text,
                              suffix: InkWell(
                                onTap: _togglePasswordView,
                                child: Icon(_isHidden
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              )),
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
                              onTap: () {},
                              child: Text(
                                'Sign up',
                                style: TextStyle(
                                    fontFamily: FontFamily.bai_jamjuree,
                                    fontSize: 14.sp,
                                    color: AppColors.main),
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Text(
                                'Forgot password?',
                                style: TextStyle(
                                    fontFamily: FontFamily.bai_jamjuree,
                                    fontSize: 14.sp,
                                    color: AppColors.main),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                      Container(
                        height: 48.h,
                        width: 272.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.r)),
                            color: Colors.grey),
                        child: InkWell(
                          onTap: () {},
                          child: Text(
                            'Log in',
                            style: TextStyle(
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
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
