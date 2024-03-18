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
                      Text(
                        'U-',
                        style: TextStyle(
                            fontFamily: FontFamily.bai_jamjuree,
                            fontSize: 26.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.u),
                      ),
                      Text(
                        'C',
                        style: TextStyle(
                            fontFamily: FontFamily.bai_jamjuree,
                            fontSize: 26.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.main),
                      ),
                      Text(
                        'HECKIN',
                        style: TextStyle(
                            fontFamily: FontFamily.bai_jamjuree,
                            fontSize: 26.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.u),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 64.h),
            child: Container(
              width: 272.w,
              height: 269.h,
              child: Column(
                children: [
                  Container(
                    width: 272.w,
                    height: 69.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email',
                          style: TextStyle(
                              fontFamily: FontFamily.bai_jamjuree,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                              color: AppColors.main),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Container(
                          height: 48.h,
                          width: 272.w,
                          decoration: BoxDecoration(
                              color: AppColors.login,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.r))),
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: 'Enter',
                              fillColor: AppColors.text,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
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
