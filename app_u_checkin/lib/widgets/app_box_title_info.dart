import 'package:app_u_checkin/values/app_colors.dart';
import 'package:app_u_checkin/values/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBoxTitleInformaition extends StatelessWidget {
  final VoidCallback onTap;
  final String labelName;
  final String labelPosition;
  final String image;

  AppBoxTitleInformaition({super.key, required this.onTap, required this.labelName, required this.labelPosition, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      width: 390.w,
      height: 111.h,
      color: AppColors.main,
      child: Row(
        children: [
          InkWell(
            onTap: () {
              onTap();
            },
            child: SizedBox(
              width: 71.w,
              height: 71.h,
              child: Image.asset(image),
            ),
          ),
          SizedBox(
            width: 35.w,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  labelName,
                  style: TextStyle(color: Colors.white, fontFamily: FontFamily.bai_jamjuree, fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
                Text(
                  labelPosition,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: FontFamily.bai_jamjuree,
                    fontSize: 14.sp,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
