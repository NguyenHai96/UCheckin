import 'package:app_u_checkin/values/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppHandleTitle extends StatelessWidget {
  final String label;
  final String imageRight;
  final String imageLeft;
  final VoidCallback onTapRight;
  final VoidCallback onTapLeft;
  const AppHandleTitle(
      {super.key, required this.label, required this.imageRight, required this.imageLeft, required this.onTapRight, required this.onTapLeft});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            width: 358.w,
            height: 32.h,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 24.w,
                    height: 24.h,
                    child: InkWell(
                      onTap: () {
                        onTapLeft();
                      },
                      child: Image.asset(imageLeft),
                    ),
                  ),
                  Expanded(
                    child: Container(
                        alignment: Alignment.center,
                        child: Text(label, style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 16.sp, color: Colors.black))),
                  ),
                  SizedBox(
                    width: 24.w,
                    height: 24.h,
                    child: InkWell(
                      onTap: () {
                        onTapRight();
                      },
                      child: Image.asset(imageRight),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
