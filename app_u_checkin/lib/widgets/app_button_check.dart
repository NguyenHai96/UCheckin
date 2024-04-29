// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:app_u_checkin/values/app_colors.dart';
import 'package:app_u_checkin/values/app_styles.dart';

class ButtonCheck extends StatefulWidget {
  final bool checkVisibility;
  final bool checkColor;
  final String checkTime;
  final VoidCallback onTap;
  final String label;
  const ButtonCheck({
    super.key,
    required this.checkVisibility,
    required this.onTap,
    required this.label,
    required this.checkColor,
    required this.checkTime,
  });

  @override
  State<ButtonCheck> createState() => _ButtonCheckState();
}

class _ButtonCheckState extends State<ButtonCheck> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 34.h,
        width: 83.w,
        child: Visibility(
          visible: widget.checkVisibility,
          replacement: Center(
            child: Text(widget.checkTime,
                style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 14.sp, color: widget.checkColor ? AppColors.grey777E90 : Colors.red)),
          ),
          child: Center(
            child: Container(
              alignment: Alignment.center,
              height: 22.h,
              width: 56.w,
              decoration: BoxDecoration(color: AppColors.blue00B4EA, borderRadius: BorderRadius.all(Radius.circular(4.r))),
              child: InkWell(
                onTap: () async {
                  widget.onTap();
                },
                child: Text(
                  widget.label,
                  style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 12.sp, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
