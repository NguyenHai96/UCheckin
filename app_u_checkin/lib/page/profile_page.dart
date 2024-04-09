// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:app_u_checkin/cache/cache_sharepreferences.dart';
import 'package:app_u_checkin/model/dayoff.dart';
import 'package:app_u_checkin/model/working_day.dart';
import 'package:app_u_checkin/model/working_year.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:app_u_checkin/model/user.dart';
import 'package:app_u_checkin/page/login_page.dart';
import 'package:app_u_checkin/values/app_assets.dart';
import 'package:app_u_checkin/values/app_colors.dart';
import 'package:app_u_checkin/values/app_styles.dart';
import 'package:table_calendar/table_calendar.dart';

class YourProFilePage extends StatefulWidget {
  User user;
  YourProFilePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<YourProFilePage> createState() => _YourProFilePageState();
}

class _YourProFilePageState extends State<YourProFilePage> {
  TextEditingController _date = TextEditingController();
  List<String> list = <String>['BA / QC', 'UI UX Designer', 'Web Developer', 'Mobile Developer', 'HR', 'General manager', 'Other'];
  String dropdownValue = '';
  TextEditingController nameController = TextEditingController();
  TextEditingController englishNameController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  DateTime? _selectedDate;

  WorkingYear dataDayOf = WorkingYear.init();

  int annualLeave = 0;
  double onTimeRate = 0;
  double enoughWorkTime = 0;

  getNumberDayOffAnnual() async {
    List<DayOff> listDayOff = await NPreferences().getListDataDayOff(widget.user.dayOff.toString());
    int restDayOff = 12;
    for (int i = 0; i < listDayOff.length; i++) {
      restDayOff = restDayOff - (listDayOff[i].getAnnualLeaveNumber());
    }
    return restDayOff;
  }

  getAnnualLeaveStart() async {
    int restDayOff = await getNumberDayOffAnnual();
    if (restDayOff > 0) {
      setState(() {
        annualLeave = restDayOff;
      });
    }
  }

  getRateTimeFromUser() async {
    int checkInOnTime = 0;
    List<WorkingDay> listWorkDay = await NPreferences().getListDataWorkingDay(widget.user.dayWork.toString());
    for (int i = 0; i < listWorkDay.length; i++) {
      if (listWorkDay[i].checkWrongTimeCheckIn() == true) {
        print('listWorkDay[i].checkin ------>>> ${listWorkDay[i].checkin}');
        checkInOnTime++;
      }
    }
    double _onTimeRate = ((checkInOnTime / listWorkDay.length) * 100);
    setState(() {
      onTimeRate = _onTimeRate;
    });
  }

  getWorkTime() async {
    int checkWorkTime = 0;
    List<WorkingDay> listWorkDay = await NPreferences().getListDataWorkingDay(widget.user.dayWork.toString());
    for (int i = 0; i < listWorkDay.length; i++) {
      if (listWorkDay[i].checkEnoughWorkTime() == true) {
        checkWorkTime++;
      }
    }
    double _enoughWorkTime = ((checkWorkTime / listWorkDay.length) * 100);
    setState(() {
      enoughWorkTime = _enoughWorkTime;
    });
  }

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
    getAnnualLeaveStart();
    getRateTimeFromUser();
    getWorkTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            top: false,
            bottom: false,
            minimum: EdgeInsets.only(top: 44.h),
            child: SingleChildScrollView(
              primary: true,
              child: Container(
                width: 390.w,
                height: 972.h,
                color: AppColors.login,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 16.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: 20.h,
                                height: 20.h,
                                child: Icon(Icons.arrow_back_ios_new_sharp),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
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
                                  '${widget.user.name}',
                                  style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 16.sp, fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () async {
                                await NPreferences().saveData('user', null);
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (context) => LoginPage()),
                                  (Route<dynamic> route) => false,
                                );
                              },
                              child: Container(
                                width: 20.h,
                                height: 20.h,
                                child: Icon(Icons.logout_sharp),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 24.h),
                      child: Container(
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
                                            '${annualLeave}',
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
                                      child: Container(height: 36.h, width: 36.h, child: Image.asset(AppAssets.time)),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 12.w),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${onTimeRate}%',
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
                                      child: Container(height: 36.h, width: 36.h, child: Image.asset(AppAssets.work)),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 12.w),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${enoughWorkTime}%',
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
                      child: Expanded(
                        child: Container(
                          width: 338.w,
                          color: Colors.white,
                          child: Expanded(
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
                                Container(
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
                                            controller: nameController,
                                            onChanged: (text) {
                                              setState(() {});
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: '${widget.user.name}',
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
                                        height: 16.h,
                                      ),
                                      Text(
                                        'English Name',
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
                                            controller: englishNameController,
                                            onChanged: (text) {
                                              setState(() {});
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: '${widget.user.nameEnglish}',
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
                                        height: 24.h,
                                      ),
                                      Text(
                                        'DoB',
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
                                            onChanged: (value) {
                                              setState(() {});
                                            },
                                            controller: _date,
                                            decoration: InputDecoration(
                                              hintText: '${widget.user.dOB}',
                                              suffixIcon: Icon(
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
                                                                      fontFamily: FontFamily.bai_jamjuree,
                                                                      fontSize: 14.sp,
                                                                      fontWeight: FontWeight.bold),
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
                                            controller: positionController,
                                            onChanged: (text) {
                                              setState(() {});
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: '${widget.user.position}',
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
                                          height: 48.h,
                                          width: 272.w,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(8.r)),
                                              color: colorDropDownValue(widget.user.team.toString())),
                                          child: DropdownButtonFormField<String>(
                                            icon: Icon(Icons.arrow_drop_down_rounded),
                                            hint: Text('${widget.user.team}'),
                                            onChanged: (String? value) {
                                              dropdownValue = value!;
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
                                                      // height: 48.h,
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
                                      SizedBox(
                                        height: 33.5.h,
                                      ),
                                      Center(
                                        child: InkWell(
                                          onTap: () async {
                                            setState(() {
                                              if (nameController.text != widget.user.name && nameController.text != '') {
                                                widget.user.name = nameController.text;
                                              }
                                              if (widget.user.nameEnglish != englishNameController.text && englishNameController.text != '') {
                                                widget.user.nameEnglish = englishNameController.text;
                                              }
                                              if (widget.user.dOB != _date.text && _date.text != '') {
                                                widget.user.dOB = _date.text;
                                              }
                                              if (widget.user.position != positionController.text && positionController.text != '') {
                                                widget.user.position = positionController.text;
                                              }
                                              if (widget.user.team != dropdownValue && dropdownValue != '') {
                                                widget.user.team = dropdownValue;
                                              }
                                            });

                                            final newUserJson = jsonEncode(widget.user.toJson());
                                            await NPreferences().saveData(widget.user.email.toString(), newUserJson);
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: 36.h,
                                            width: 136.w,
                                            decoration: BoxDecoration(color: AppColors.main, borderRadius: BorderRadius.all(Radius.circular(12.r))),
                                            child: Text(
                                              'Edit',
                                              style: TextStyle(
                                                  fontFamily: FontFamily.beVietnamPro,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
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
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}
