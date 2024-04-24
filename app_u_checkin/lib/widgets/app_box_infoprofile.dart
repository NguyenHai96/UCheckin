import 'package:app_u_checkin/values/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBoxInfoProfile extends StatelessWidget {
  final String image;
  final String label;
  final String info;
  const AppBoxInfoProfile({super.key, required this.image, required this.info, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65.h,
      width: 163.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(18.r)),
        boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(3.h, 2.w), blurRadius: 4.r)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.w),
            child: SizedBox(height: 36.h, width: 36.h, child: Image.asset(image)),
          ),
          Padding(
            padding: EdgeInsets.only(left: 12.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  info,
                  style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
                Text(label,
                    style: TextStyle(
                      fontFamily: FontFamily.bai_jamjuree,
                      fontSize: 14.sp,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
