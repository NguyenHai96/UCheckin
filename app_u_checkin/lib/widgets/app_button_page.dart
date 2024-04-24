import 'package:app_u_checkin/values/app_colors.dart';
import 'package:app_u_checkin/values/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  final String label;
  final String image;
  final VoidCallback onTap;

  const AppButton({super.key, required this.label, required this.onTap, required this.image});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 91.h,
        width: 109.w,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(12.r)),
            boxShadow: const [BoxShadow(color: Colors.black26, offset: Offset(1, 3), blurRadius: 2.6)]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: 32.w,
                height: 32.h,
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                )),
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Text(
                label,
                style: TextStyle(
                  color: AppColors.text,
                  fontFamily: FontFamily.bai_jamjuree,
                  fontSize: 14.sp,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
