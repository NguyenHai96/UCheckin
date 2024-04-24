// ignore_for_file: must_be_immutable

import 'package:app_u_checkin/values/app_colors.dart';
import 'package:app_u_checkin/values/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSignUpInputText extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final String hintText;
  final String label;
  final FormFieldValidator? validator;
  final GestureTapCallback? onTap;
  bool hidden = false;
  AppSignUpInputText(
      {super.key,
      required this.controller,
      this.onChanged,
      required this.hintText,
      required this.label,
      this.validator,
      required this.hidden,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Column(
      children: [
        SizedBox(
          // height: 17.h,
          width: 272.w,
          child: Text(
            label,
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
              obscureText: hidden,
              controller: controller,
              onChanged: onChanged,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hintText,
                  suffixStyle: TextStyle(fontSize: 16.sp, fontFamily: FontFamily.bai_jamjuree),
                  fillColor: AppColors.hintText,
                  suffix: InkWell(
                    onTap: onTap,
                    child: Icon(hidden ? Icons.visibility : Icons.visibility_off),
                  )),
              validator: validator),
        ),
      ],
    ));
  }
}
