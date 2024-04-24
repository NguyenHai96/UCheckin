import 'package:app_u_checkin/values/app_colors.dart';
import 'package:app_u_checkin/values/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppProfileInputText extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  const AppProfileInputText({super.key, required this.controller, required this.label, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 14.sp, color: AppColors.main, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: Container(
              padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
              height: 48.h,
              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8.r)), color: AppColors.login),
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hintText,
                  suffixStyle: TextStyle(fontSize: 16.sp, fontFamily: FontFamily.bai_jamjuree),
                  fillColor: AppColors.text,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
