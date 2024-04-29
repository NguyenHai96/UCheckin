import 'package:app_u_checkin/values/app_colors.dart';
import 'package:app_u_checkin/values/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTitleIdie extends StatelessWidget {
  final String colum1;
  final String colum2;
  final String colum3;
  final String colum4;
  const AppTitleIdie({super.key, required this.colum1, required this.colum2, required this.colum3, required this.colum4});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          alignment: Alignment.center,
          width: 83.w,
          height: 31.h,
          decoration: BoxDecoration(color: AppColors.yellowEFC471, borderRadius: BorderRadius.all(Radius.circular(4.r))),
          child: Text(
            colum1,
            style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 14.sp, color: Colors.white),
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: 83.w,
          height: 31.h,
          decoration: BoxDecoration(color: AppColors.green64B880, borderRadius: BorderRadius.all(Radius.circular(4.r))),
          child: Text(
            colum2,
            style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 14.sp, color: Colors.white),
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: 83.w,
          height: 31.h,
          decoration: BoxDecoration(color: AppColors.blue00B4EA, borderRadius: BorderRadius.all(Radius.circular(4.r))),
          child: Text(
            colum3,
            style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 14.sp, color: Colors.white),
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: 83.w,
          height: 31.h,
          decoration: BoxDecoration(color: AppColors.magenta, borderRadius: BorderRadius.all(Radius.circular(4.r))),
          child: Text(
            colum4,
            style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 14.sp, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
