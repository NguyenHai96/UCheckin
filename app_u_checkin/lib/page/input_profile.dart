// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:convert';

import 'package:app_u_checkin/cache/cache_sharepreferences.dart';
import 'package:app_u_checkin/model/user.dart';
import 'package:app_u_checkin/page/home_page.dart';
import 'package:app_u_checkin/values/app_colors.dart';
import 'package:app_u_checkin/values/app_styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class ProfilePage extends StatefulWidget {
  User newUser = User();
  ProfilePage({super.key, required this.newUser});

  @override
  State<ProfilePage> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _date = TextEditingController();
  List<String> list = <String>['BA / QC', 'UI UX Designer', 'Web Developer', 'Mobile Developer', 'HR', 'General manager', 'Other'];
  String dropdownValue = '';
  TextEditingController nameController = TextEditingController();
  TextEditingController englishNameController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  DateTime? _selectedDate;

  colorDropDownValue(String value) {
    if (value == 'BA / QC') {
      return AppColors.baQc;
    } else {
      if (value == 'UI UX Designer') {
        return AppColors.uiUx;
      } else if (value == 'Web Developer') {
        return AppColors.webDev;
      } else if (value == 'Mobile Developer') {
        return AppColors.mobileDev;
      } else if (value == 'HR') {
        return AppColors.hr;
      } else if (value == 'General manager') {
        return AppColors.generalManager;
      } else if (value == 'Other') {
        return AppColors.other;
      } else {
        return Colors.transparent;
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.login,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 43.w),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 68.h),
              child: Container(
                width: 304.w,
                // height: 568.h,
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(
                      height: 12.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Your profile',
                          style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontWeight: FontWeight.bold, fontSize: 16.sp),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    SizedBox(
                      // height: 440.h,
                      width: 272.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              alignment: Alignment.center,
                              child: Text(
                                'You need to input information to coutinue',
                                style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 13.sp, color: AppColors.textBasic),
                              )),
                          SizedBox(
                            height: 12.h,
                          ),
                          Text(
                            'Name',
                            style:
                                TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 13.sp, color: AppColors.main, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 4.h),
                            child: Container(
                              padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
                              height: 48.h,
                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8.r)), color: AppColors.login),
                              child: TextFormField(
                                controller: nameController,
                                onChanged: (text) {
                                  setState(() {});
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter',
                                  suffixStyle: TextStyle(fontSize: 16.sp, fontFamily: FontFamily.bai_jamjuree),
                                  fillColor: AppColors.text,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 14.h,
                          ),
                          Text(
                            'English Name',
                            style:
                                TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 13.sp, color: AppColors.main, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 4.h),
                            child: Container(
                              padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
                              height: 48.h,
                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8.r)), color: AppColors.login),
                              child: TextFormField(
                                controller: englishNameController,
                                onChanged: (text) {
                                  setState(() {});
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter',
                                  suffixStyle: TextStyle(fontSize: 16.sp, fontFamily: FontFamily.bai_jamjuree),
                                  fillColor: AppColors.text,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Text(
                            'DoB',
                            style:
                                TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 13.sp, color: AppColors.main, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 4.h),
                            child: Container(
                              padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
                              height: 48.h,
                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8.r)), color: AppColors.login),
                              child: TextFormField(
                                controller: _date,
                                decoration: InputDecoration(
                                  hintText: 'Select date',
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
                                                  return isSameDay(_selectedDate, date);
                                                },
                                                onDaySelected: (date, focusedDay) {
                                                  setState(() {
                                                    _selectedDate = date;
                                                    _date.text = DateFormat('dd/MM/yyyy').format(_selectedDate!);
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
                            height: 15.h,
                          ),
                          Text(
                            'Your position',
                            style:
                                TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 13.sp, color: AppColors.main, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 4.h),
                            child: Container(
                              padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
                              height: 48.h,
                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8.r)), color: AppColors.login),
                              child: TextFormField(
                                controller: positionController,
                                onChanged: (text) {
                                  setState(() {});
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter',
                                  suffixStyle: TextStyle(fontSize: 16.sp, fontFamily: FontFamily.bai_jamjuree),
                                  fillColor: AppColors.text,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Text(
                            'Your team',
                            style:
                                TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 13.sp, color: AppColors.main, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 4.h),
                            child: Container(
                              // height: 48.h,
                              width: 272.w,
                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8.r)), color: AppColors.login),
                              child: DropdownButtonFormField<String>(
                                icon: const Icon(Icons.arrow_drop_down_rounded),
                                hint: const Text('Select'),
                                onChanged: (String? value) {
                                  setState(() {
                                    dropdownValue = value!;
                                  });
                                },
                                decoration: InputDecoration(
                                  constraints: const BoxConstraints(),
                                  border: InputBorder.none,
                                  fillColor: colorDropDownValue(dropdownValue),
                                  filled: true,
                                ),
                                items: list.map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem(
                                      value: value,
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.only(left: 10.w),
                                          height: 48.h,
                                          decoration: BoxDecoration(
                                            color: colorDropDownValue(value),
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
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    InkWell(
                      onTap: () async {
                        setState(() {
                          widget.newUser.name = nameController.text;
                          widget.newUser.nameEnglish = englishNameController.text;
                          widget.newUser.dOB = _date.text;
                          widget.newUser.position = positionController.text;
                          widget.newUser.team = dropdownValue;
                        });
                        final newUserJson = jsonEncode(widget.newUser.toJson());
                        await NPreferences().saveData(widget.newUser.email.toString(), newUserJson);
                        Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 36.h,
                        width: 136.w,
                        decoration: BoxDecoration(color: AppColors.main, borderRadius: BorderRadius.all(Radius.circular(12.r))),
                        child: Text(
                          'OK',
                          style: TextStyle(fontFamily: FontFamily.beVietnamPro, fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12.h,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
