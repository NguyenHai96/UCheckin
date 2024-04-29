// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, use_build_context_synchronously, unnecessary_brace_in_string_interps, unnecessary_const

import 'package:app_u_checkin/providers/makedayoff_provider.dart';
import 'package:app_u_checkin/providers/outthem_provider.dart';
import 'package:app_u_checkin/widgets/app_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:app_u_checkin/values/app_assets.dart';
import 'package:app_u_checkin/values/app_colors.dart';
import 'package:app_u_checkin/values/app_styles.dart';

class MakeDayOff extends StatefulWidget {
  const MakeDayOff({
    super.key,
  });

  @override
  State<MakeDayOff> createState() => _MakeDayOffState();
}

class _MakeDayOffState extends State<MakeDayOff> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<MakeDayOffProvider>().getAnnualLeaveStart(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, MakeDayOffProvider dayoff, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            shadowColor: Colors.black12,
            backgroundColor: Colors.white,
            title: Text(
              'Make day-off',
              style: TextStyle(fontFamily: FontFamily.beVietnamPro, fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(AppAssets.leftArrow),
            ),
          ),
          body: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 16.h,
                ),
                SizedBox(
                  width: 272.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Type',
                        style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 14.sp, color: AppColors.main, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 4.h),
                        child: Container(
                          // height: 48.h,
                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8.r)), color: AppColors.blueF1FAFF),
                          child: DropdownButtonFormField<String>(
                            icon: const Icon(Icons.arrow_drop_down_rounded),
                            hint: const Text('Select'),
                            onChanged: (String? value) {
                              setState(() {
                                dayoff.dropdownValue = value!;
                                dayoff.isActiveSave = dayoff.checkSaveDayOff();
                              });
                            },
                            decoration: const InputDecoration(
                              constraints: BoxConstraints(),
                              border: InputBorder.none,
                              fillColor: AppColors.blueF1FAFF,
                              filled: true,
                            ),
                            items: dayoff.list.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem(
                                  value: value,
                                  child: Container(
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.only(left: 10.w),
                                      // height: 48.h,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8.r))),
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                          fontFamily: FontFamily.bai_jamjuree,
                                          fontSize: 16.sp,
                                        ),
                                      )));
                            }).toList(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Text(
                        'From',
                        style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 13.sp, color: AppColors.main, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 4.h),
                        child: CalendarBottom(
                          controller: dayoff.dateFromControler,
                          selectedDate: dayoff.selectedFormDate,
                          hintText: 'dd/MM/yyyy',
                          onDaySelected: (date, focusedDay) {
                            setState(() {
                              dayoff.chooseDayOffStart(date, context);
                            });
                          },
                          onChanged: (value) {
                            if (value != '') {
                              setState(() {
                                dayoff.inputValueFrom(value, context);
                                dayoff.isActiveSave = dayoff.checkSaveDayOff();
                              });
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Text(
                        'To',
                        style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 13.sp, color: AppColors.main, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 4.h),
                        child: CalendarBottom(
                          controller: dayoff.dateToControler,
                          selectedDate: dayoff.selectedToDate,
                          hintText: 'dd/MM/yyyy',
                          onDaySelected: (date, focusedDay) {
                            setState(() {
                              dayoff.chooseDayOffEnd(date, context);
                            });
                          },
                          onChanged: (value) {
                            if (value != '') {
                              setState(() {
                                dayoff.inputValueTo(value, context);
                                dayoff.isActiveSave = dayoff.checkSaveDayOff();
                              });
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Center(
                        child: Text('Annual leave : ${dayoff.annualLeave}',
                            style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 14.sp, color: Colors.grey, fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Text(
                        'Description',
                        style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 13.sp, color: AppColors.main, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 4.h),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
                          height: 88.h,
                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8.r)), color: AppColors.blueF1FAFF),
                          child: TextFormField(
                            controller: dayoff.descriptionControler,
                            onChanged: (value) {
                              setState(() {
                                dayoff.isActiveSave = dayoff.checkSaveDayOff();
                              });
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter',
                              suffixStyle: TextStyle(fontSize: 16.sp, fontFamily: FontFamily.bai_jamjuree),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Center(
                        child: InkWell(
                          onTap: dayoff.isActiveSave
                              ? () async {
                                  await context.read<OutThemeProvider>().saveDataAndNavigatorDayOff(context);
                                }
                              : null,
                          child: Container(
                            alignment: Alignment.center,
                            height: 36.h,
                            width: 136.w,
                            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(12.r)), color: AppColors.main),
                            child: Text(
                              'Save',
                              style:
                                  TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 14.sp, color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
