import 'package:app_u_checkin/providers/sign_up_provider.dart';
import 'package:app_u_checkin/values/app_assets.dart';
import 'package:app_u_checkin/values/app_colors.dart';
import 'package:app_u_checkin/values/app_styles.dart';
import 'package:app_u_checkin/widgets/app_signup_inputtext.dart';
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
          body: SingleChildScrollView(
            child: SizedBox(
              height: 844.h,
              width: 390.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 97.h),
                          child: SizedBox(
                            width: 141.w,
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
                                // height: 26.h,
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
                              child: Column(
                            children: [
                              SizedBox(
                                // height: 17.h,
                                width: 272.w,
                                child: Text(
                                  'Email',
                                  style: TextStyle(
                                      fontFamily: FontFamily.bai_jamjuree, fontWeight: FontWeight.bold, fontSize: 14.sp, color: AppColors.main),
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
                            ],
                          )),
                          SizedBox(
                            height: 16.h,
                          ),
                          AppSignUpInputText(
                            controller: signUp.passwordController,
                            hintText: 'Enter your passwoord',
                            label: 'Password',
                            hidden: signUp.isHidden,
                            onChanged: (text) {
                              setState(() {
                                signUp.isActiveSignUp = signUp.checkSignUp();
                              });
                            },
                            onTap: signUp.togglePasswordView,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          AppSignUpInputText(
                            controller: signUp.rePasswordController,
                            hintText: 'Re-Enter your passwoord',
                            label: 'Confirm Password',
                            hidden: signUp.isHidden,
                            onChanged: (textRe) {
                              setState(() {
                                signUp.isActiveSignUp = signUp.checkSignUp();
                              });
                            },
                            onTap: signUp.togglePasswordView,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          SizedBox(
                            width: 272.w,
                            // height: 19.h,
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
                                  borderRadius: BorderRadius.all(Radius.circular(8.r)),
                                  color: signUp.isActiveSignUp ? AppColors.checkout : Colors.grey),
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
            ),
          ),
        );
      },
    );
  }
}
