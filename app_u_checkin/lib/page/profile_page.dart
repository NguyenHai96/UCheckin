// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously, no_leading_underscores_for_local_identifiers, must_be_immutable
import 'dart:convert';

import 'package:app_u_checkin/cache/cache_sharepreferences.dart';
import 'package:app_u_checkin/model/dayoff.dart';
import 'package:app_u_checkin/model/working_day.dart';
import 'package:app_u_checkin/model/working_year.dart';
import 'package:app_u_checkin/page/check_in_page.dart';
import 'package:app_u_checkin/page/home_page.dart';
import 'package:app_u_checkin/providers/homepage_provider.dart';
import 'package:app_u_checkin/providers/outthem_provider.dart';
import 'package:app_u_checkin/providers/profile_provider.dart';
import 'package:app_u_checkin/values/share_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:app_u_checkin/model/user.dart';
import 'package:app_u_checkin/page/login_page.dart';
import 'package:app_u_checkin/values/app_assets.dart';
import 'package:app_u_checkin/values/app_colors.dart';
import 'package:app_u_checkin/values/app_styles.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class YourProFilePage extends StatefulWidget {
  const YourProFilePage({
    super.key,
  });

  @override
  State<YourProFilePage> createState() => _YourProFilePageState();
}

class _YourProFilePageState extends State<YourProFilePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ProfilePageProvider>().getAnnualLeaveStart(context);
    context.read<ProfilePageProvider>().getRateTimeFromUser(context);
    context.read<ProfilePageProvider>().getWorkTime(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfilePageProvider>(
      builder: (BuildContext context, ProfilePageProvider profile, _) {
        return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
                child: SingleChildScrollView(
              child: Container(
                color: AppColors.login,
                padding: EdgeInsets.all(16.h),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: SizedBox(
                              width: 20.h,
                              height: 20.h,
                              child: const Icon(Icons.arrow_back_ios_new_sharp),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 71.h,
                                height: 71.h,
                                child: Image.asset(
                                  AppAssets.avatar,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              Text(
                                '${context.watch<OutThemeProvider>().user.name}',
                                style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 16.sp, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () async {
                              String logout = '';
                              await context.read<OutThemeProvider>().cleanUser();
                              await NPreferences().saveData(ShareKeys.checkLogin, logout);
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => const LoginPage()),
                                (Route<dynamic> route) => false,
                              );
                            },
                            child: SizedBox(
                              width: 20.h,
                              child: const Icon(Icons.logout_sharp),
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 24.h),
                      child: SizedBox(
                        height: 141.h,
                        width: 342.w,
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              top: 0,
                              left: 0,
                              child: Container(
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
                                      child: SizedBox(height: 36.h, width: 36.h, child: Image.asset(AppAssets.home)),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 12.w),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${profile.annualLeave}',
                                            style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 16.sp, fontWeight: FontWeight.bold),
                                          ),
                                          Text('Annual leaves',
                                              style: TextStyle(
                                                fontFamily: FontFamily.bai_jamjuree,
                                                fontSize: 14.sp,
                                              ))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                height: 65.h,
                                width: 163.w,
                                decoration: BoxDecoration(
                                  boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(3.h, 2.w), blurRadius: 4.r)],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(18.r)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 8.w),
                                      child: SizedBox(height: 36.h, width: 36.h, child: Image.asset(AppAssets.time)),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 12.w),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${profile.onTimeRate.toPrecision(2)}%',
                                            style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 16.sp, fontWeight: FontWeight.bold),
                                          ),
                                          Text('On-time rate',
                                              style: TextStyle(
                                                fontFamily: FontFamily.bai_jamjuree,
                                                fontSize: 14.sp,
                                              ))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              child: Container(
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
                                      child: SizedBox(height: 36.h, width: 36.h, child: Image.asset(AppAssets.work)),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 12.w),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${profile.enoughWorkTime.toPrecision(2)}%',
                                            style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 16.sp, fontWeight: FontWeight.bold),
                                          ),
                                          Text('Work time',
                                              style: TextStyle(
                                                fontFamily: FontFamily.bai_jamjuree,
                                                fontSize: 14.sp,
                                              ))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 24.h),
                      child: Container(
                        width: 338.w,
                        color: Colors.white,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 12.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Your profile',
                                    style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontWeight: FontWeight.bold, fontSize: 16.sp),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 24.h,
                            ),
                            SizedBox(
                              width: 272.w,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Name',
                                    style: TextStyle(
                                        fontFamily: FontFamily.bai_jamjuree, fontSize: 14.sp, color: AppColors.main, fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 4.h),
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
                                      height: 48.h,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8.r)), color: AppColors.login),
                                      child: TextFormField(
                                        controller: profile.nameController,
                                        onChanged: (text) {},
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: '${context.read<OutThemeProvider>().user.name}',
                                          suffixStyle: TextStyle(fontSize: 16.sp, fontFamily: FontFamily.bai_jamjuree),
                                          fillColor: AppColors.text,
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your name';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 16.h),
                                    child: Text(
                                      'English Name',
                                      style: TextStyle(
                                          fontFamily: FontFamily.bai_jamjuree, fontSize: 14.sp, color: AppColors.main, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 4.h),
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
                                      height: 48.h,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8.r)), color: AppColors.login),
                                      child: TextFormField(
                                        controller: profile.englishNameController,
                                        onChanged: (text) {},
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: '${context.read<OutThemeProvider>().user.nameEnglish}',
                                          suffixStyle: TextStyle(fontSize: 16.sp, fontFamily: FontFamily.bai_jamjuree),
                                          fillColor: AppColors.text,
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your name english';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 16.h),
                                    child: Text(
                                      'DoB',
                                      style: TextStyle(
                                          fontFamily: FontFamily.bai_jamjuree, fontSize: 14.sp, color: AppColors.main, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 4.h),
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
                                      height: 48.h,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8.r)), color: AppColors.login),
                                      child: TextFormField(
                                        onChanged: (value) {},
                                        controller: profile.date,
                                        decoration: InputDecoration(
                                          hintText: '${context.read<OutThemeProvider>().user.dOB}',
                                          suffixIcon: const Icon(
                                            Icons.calendar_month_rounded,
                                          ),
                                          suffixStyle: TextStyle(fontSize: 16.sp, fontFamily: FontFamily.bai_jamjuree),
                                          border: InputBorder.none,
                                        ),
                                        onTap: () async {
                                          showModalBottomSheet(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Container(
                                                  height: 410.h,
                                                  color: Colors.white,
                                                  child: Column(
                                                    children: [
                                                      TableCalendar(
                                                        firstDay: DateTime(2000),
                                                        lastDay: DateTime(2050),
                                                        focusedDay: DateTime.now(),
                                                        availableCalendarFormats: const {CalendarFormat.month: 'Month'},
                                                        calendarStyle: const CalendarStyle(
                                                            selectedDecoration: BoxDecoration(
                                                              color: Colors.blue,
                                                            ),
                                                            todayDecoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                                                            todayTextStyle: TextStyle(color: Colors.blue, fontSize: 16)),
                                                        selectedDayPredicate: (date) {
                                                          return isSameDay(profile.selectedDate, date);
                                                        },
                                                        onDaySelected: (date, focusedDay) {
                                                          setState(() {
                                                            profile.selectedDate = date;
                                                            profile.date.text = DateFormat('dd/MM/yyyy').format(profile.selectedDate!);
                                                          });

                                                          Navigator.pop(context);
                                                        },
                                                        calendarBuilders: CalendarBuilders(
                                                          headerTitleBuilder: (context, date) => Center(
                                                            child: Text(
                                                              DateFormat('MMM yyyy').format(date),
                                                              style: TextStyle(
                                                                  fontFamily: FontFamily.bai_jamjuree, fontSize: 14.sp, fontWeight: FontWeight.bold),
                                                            ),
                                                          ),
                                                          selectedBuilder: (context, date, _) => Center(
                                                            child: Text(
                                                              date.day.toString(),
                                                              style: TextStyle(color: Colors.blue, fontSize: 15.sp),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              });
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  Text(
                                    'Your position',
                                    style: TextStyle(
                                        fontFamily: FontFamily.bai_jamjuree, fontSize: 14.sp, color: AppColors.main, fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 4.h),
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
                                      height: 48.h,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8.r)), color: AppColors.login),
                                      child: TextFormField(
                                        controller: profile.positionController,
                                        onChanged: (text) {},
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: '${context.read<OutThemeProvider>().user.position}',
                                          suffixStyle: TextStyle(fontSize: 16.sp, fontFamily: FontFamily.bai_jamjuree),
                                          fillColor: AppColors.text,
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your position';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  Text(
                                    'Your team',
                                    style: TextStyle(
                                        fontFamily: FontFamily.bai_jamjuree, fontSize: 14.sp, color: AppColors.main, fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 4.h),
                                    child: Container(
                                      // height: 48.h,
                                      width: 272.w,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(8.r)),
                                          color: profile.colorDropDownValue(context.read<OutThemeProvider>().user.team.toString())),
                                      child: DropdownButtonFormField<String>(
                                        icon: const Icon(Icons.arrow_drop_down_rounded),
                                        hint: Text('${context.read<OutThemeProvider>().user.team}'),
                                        onChanged: (String? value) {
                                          profile.dropdownValue = value!;
                                        },
                                        decoration: InputDecoration(
                                          constraints: const BoxConstraints(),
                                          border: InputBorder.none,
                                          fillColor: profile.colorDropDownValue(profile.dropdownValue),
                                          filled: true,
                                        ),
                                        items: profile.list.map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem(
                                              value: value,
                                              child: Container(
                                                  alignment: Alignment.centerLeft,
                                                  padding: EdgeInsets.only(left: 10.w),
                                                  height: 48.h,
                                                  decoration: BoxDecoration(
                                                    color: profile.colorDropDownValue(value),
                                                  ),
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
                                    height: 33.5.h,
                                  ),
                                  Center(
                                    child: InkWell(
                                      onTap: () async {
                                        profile.saveChangeInfoProfile(context);
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 36.h,
                                        width: 136.w,
                                        decoration: BoxDecoration(color: AppColors.main, borderRadius: BorderRadius.all(Radius.circular(12.r))),
                                        child: Text(
                                          'Edit',
                                          style: TextStyle(
                                              fontFamily: FontFamily.beVietnamPro, fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 12.h,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )));
      },
    );
  }
}
