import 'dart:math';

import 'package:app_u_checkin/model/working_week.dart';
import 'package:app_u_checkin/note/date_time.dart';
import 'package:app_u_checkin/values/app_assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:app_u_checkin/model/working_day.dart';
import 'package:app_u_checkin/values/app_colors.dart';
import 'package:app_u_checkin/values/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;
  List<WorkingWeek> dataWeek = [];
  String weekTitle = '';
  int _currentIndex = 0;

  getDateTimeWork() {
    DateTime now = DateTime.now();
    var startDate = now.subtract(Duration(days: now.weekday - 1));
    var endDate = now.add(Duration(days: 7 - now.weekday));

    setState(() {
      dataWeek.add(getNowWeek(now));
      dataWeek.add(getNextWeek(endDate));
      dataWeek.insert(0, getLastWeek(startDate));
    });
  }

  String getWeekState() {
    weekTitle = dataWeek[_currentIndex].getWeekTitle();
    return weekTitle;
  }

  WorkingWeek getNowWeek(DateTime date) {
    WorkingWeek week = WorkingWeek.init();
    List<WorkingDay> listWeekNow = [];
    var startDate = date.subtract(Duration(days: date.weekday - 1));
    final items = List<DateTime>.generate(7, (i) {
      DateTime list = startDate;
      return list.add(Duration(days: i));
    });
    for (int i = 0; i < items.length; i++) {
      listWeekNow.add(WorkingDay(
          date: items[i],
          checkin: DateFormat('HH:mm').format(date),
          checkout: DateFormat('HH:mm').format(date.add(Duration(hours: 9)))));
    }
    week.dayOfWeek.addAll(listWeekNow);
    return week;
  }

  WorkingWeek getLastWeek(DateTime date) {
    WorkingWeek week = WorkingWeek.init();
    List<WorkingDay> listWeekLast = [];
    for (int i = 7; i > 0; i--) {
      var beforeDay = date.subtract(Duration(days: i));
      listWeekLast.add(WorkingDay(
          date: beforeDay,
          checkin: DateFormat('HH:mm').format(date),
          checkout: DateFormat('HH:mm').format(date.add(Duration(hours: 9)))));
    }
    week.dayOfWeek.addAll(listWeekLast);
    return week;
  }

  WorkingWeek getNextWeek(DateTime date) {
    WorkingWeek week = WorkingWeek.init();
    List<WorkingDay> listWeekNext = [];
    for (int i = 1; i <= 7; i++) {
      var behindDay = date.add(Duration(days: i));
      listWeekNext.add(WorkingDay(
          date: behindDay,
          checkin: DateFormat('HH:mm').format(date),
          checkout: DateFormat('HH:mm').format(date.add(Duration(hours: 9)))));
    }
    week.dayOfWeek.addAll(listWeekNext);
    return week;
  }

  getLastWeekArrow(int index) async {
    var data = await getLastWeek(dataWeek[0].dayOfWeek.first.date!);
    setState(() {
      dataWeek.insert(0, data);
      _currentIndex = index;
    });
    // - Timf ngay dau tien
    // - lấy ngày đầu tiên để tìm ra danh sách các ngày của tuần trước
    // - insert tuần đó vào list dataWeek ở vị trí 0
    // - setState lại list dataweek.
    // - setState lại current.//
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    getDateTimeWork();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.login,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 44.h),
            child: Container(
              padding: EdgeInsets.all(16.w),
              width: 390.w,
              height: 111.h,
              color: AppColors.main,
              child: Row(
                children: [
                  Container(
                    width: 71.w,
                    height: 71.h,
                    child: Image.asset(AppAssets.avatar),
                  ),
                  SizedBox(
                    width: 35.w,
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nguyen Thi Mai A',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: FontFamily.bai_jamjuree,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Position: BE Developer',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: FontFamily.bai_jamjuree,
                              fontSize: 14.sp,
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
              width: 359.w,
              height: 158.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 247.w,
                    height: 51.h,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(12.r))),
                    child: Text(
                      'Hi, have a effective work day!!!',
                      style: TextStyle(
                          fontFamily: FontFamily.bellefair,
                          fontSize: 19.sp,
                          color: Colors.black),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 91.h,
                        width: 109.w,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.r)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(1, 3),
                                  blurRadius: 2.6)
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                width: 32.w,
                                height: 32.h,
                                child: Image.asset(
                                  AppAssets.checkIn,
                                  fit: BoxFit.cover,
                                )),
                            Padding(
                              padding: EdgeInsets.only(top: 8.h),
                              child: Text(
                                'Checkin',
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
                      Container(
                        height: 91.h,
                        width: 109.w,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.r)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(1, 3),
                                  blurRadius: 2.6)
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                width: 32.w,
                                height: 32.h,
                                child: Image.asset(
                                  AppAssets.makeDayOff,
                                  fit: BoxFit.cover,
                                )),
                            Padding(
                              padding: EdgeInsets.only(top: 8.h),
                              child: Text(
                                'Make day-off',
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
                      Container(
                        height: 91.h,
                        width: 109.w,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.r)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(1, 3),
                                  blurRadius: 2.6)
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                width: 32.w,
                                height: 32.h,
                                child: Image.asset(
                                  AppAssets.overtime,
                                  fit: BoxFit.cover,
                                )),
                            Padding(
                              padding: EdgeInsets.only(top: 8.h),
                              child: Text(
                                'Apply OT',
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
                    ],
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 32.h),
            child: Container(
              width: 358.w,
              height: 384.h,
              child: Column(
                children: [
                  Expanded(
                      child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your punch in table',
                        style: TextStyle(
                            fontFamily: FontFamily.bai_jamjuree,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  )),
                  Container(
                    width: 358.w,
                    height: 352.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 358.w,
                          height: 75.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: 358.w,
                                      height: 32.h,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12.w),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: 24.w,
                                              height: 24.h,
                                              child: InkWell(
                                                onTap: () {
                                                  getLastWeekArrow(
                                                      _currentIndex);
                                                  _pageController.animateToPage(
                                                      --_currentIndex,
                                                      duration: Duration(
                                                          milliseconds: 20),
                                                      curve:
                                                          Curves.bounceInOut);
                                                },
                                                child: Image.asset(
                                                    AppAssets.leftArrow),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                  alignment: Alignment.center,
                                                  child: SizedBox(
                                                    child: Text(
                                                      getWeekState(),
                                                      style: TextStyle(
                                                          fontFamily: FontFamily
                                                              .bai_jamjuree,
                                                          fontSize: 16.sp,
                                                          color: Colors.black),
                                                    ),
                                                  )),
                                            ),
                                            Container(
                                              width: 24.w,
                                              height: 24.h,
                                              child: InkWell(
                                                onTap: () async {
                                                  dataWeek.add(
                                                      await getNextWeek(dataWeek
                                                          .last
                                                          .dayOfWeek
                                                          .last
                                                          .date!));
                                                  _pageController.animateToPage(
                                                      ++_currentIndex,
                                                      duration: Duration(
                                                          milliseconds: 20),
                                                      curve:
                                                          Curves.bounceInOut);
                                                },
                                                child: Image.asset(
                                                    AppAssets.rightArrow),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    width: 83.w,
                                    height: 31.h,
                                    decoration: BoxDecoration(
                                        color: AppColors.date,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4.r))),
                                    child: Text(
                                      'Date',
                                      style: TextStyle(
                                          fontFamily: FontFamily.bai_jamjuree,
                                          fontSize: 14.sp,
                                          color: Colors.white),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: 83.w,
                                    height: 31.h,
                                    decoration: BoxDecoration(
                                        color: AppColors.checkin,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4.r))),
                                    child: Text(
                                      'Check in',
                                      style: TextStyle(
                                          fontFamily: FontFamily.bai_jamjuree,
                                          fontSize: 14.sp,
                                          color: Colors.white),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: 83.w,
                                    height: 31.h,
                                    decoration: BoxDecoration(
                                        color: AppColors.checkout,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4.r))),
                                    child: Text(
                                      'Check out',
                                      style: TextStyle(
                                          fontFamily: FontFamily.bai_jamjuree,
                                          fontSize: 14.sp,
                                          color: Colors.white),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: 83.w,
                                    height: 31.h,
                                    decoration: BoxDecoration(
                                        color: AppColors.worktime,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4.r))),
                                    child: Text(
                                      'Work time',
                                      style: TextStyle(
                                          fontFamily: FontFamily.bai_jamjuree,
                                          fontSize: 14.sp,
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Expanded(
                          child: PageView.builder(
                              controller: _pageController,
                              onPageChanged: (i) {
                                setState(() {
                                  _currentIndex = i;
                                });
                              },
                              itemCount: dataWeek.length,
                              itemBuilder: (context, i) {
                                return Container(
                                  child: ListView.separated(
                                      padding: EdgeInsets.only(top: 0.h),
                                      itemCount: dataWeek[i].dayOfWeek.length,
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                      itemBuilder: (context, index) {
                                        double work = convertString(dataWeek[i]
                                                .dayOfWeek[index]
                                                .checkout) -
                                            convertString(dataWeek[i]
                                                .dayOfWeek[index]
                                                .checkin) -
                                            1;
                                        dataWeek[i].dayOfWeek[index].workTime =
                                            work.toPrecision(2);
                                        return Container(
                                            width: 358.w,
                                            height: 31.h,
                                            decoration: BoxDecoration(
                                                color: dataWeek[i]
                                                        .dayOfWeek[index]
                                                        .isWeekend()
                                                    ? Colors.white
                                                    : AppColors.visible,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8))),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Center(
                                                      child: Text(
                                                    dataWeek[i]
                                                        .dayOfWeek[index]
                                                        .getDateString(),
                                                    style: TextStyle(
                                                        fontFamily: FontFamily
                                                            .bai_jamjuree,
                                                        fontSize: 14.sp,
                                                        color: AppColors.text),
                                                  )),
                                                ),
                                                Expanded(
                                                  child: Visibility(
                                                    visible: dataWeek[i]
                                                        .dayOfWeek[index]
                                                        .isWeekend(),
                                                    child: Center(
                                                        child: Text(
                                                      '${dataWeek[i].dayOfWeek[index].checkin}',
                                                      style: TextStyle(
                                                          fontFamily: FontFamily
                                                              .bai_jamjuree,
                                                          fontSize: 14.sp,
                                                          color:
                                                              AppColors.text),
                                                    )),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Visibility(
                                                    visible: dataWeek[i]
                                                        .dayOfWeek[index]
                                                        .isWeekend(),
                                                    child: Center(
                                                        child: Text(
                                                      '${dataWeek[i].dayOfWeek[index].checkout}',
                                                      style: TextStyle(
                                                          fontFamily: FontFamily
                                                              .bai_jamjuree,
                                                          fontSize: 14.sp,
                                                          color:
                                                              AppColors.text),
                                                    )),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Visibility(
                                                    visible: dataWeek[i]
                                                        .dayOfWeek[index]
                                                        .isWeekend(),
                                                    child: Center(
                                                        child: Text(
                                                      '${dataWeek[i].dayOfWeek[index].workTime}',
                                                      style: TextStyle(
                                                          fontFamily: FontFamily
                                                              .bai_jamjuree,
                                                          fontSize: 14.sp,
                                                          color: dataWeek[i]
                                                                      .dayOfWeek[
                                                                          index]
                                                                      .workTime! <
                                                                  8
                                                              ? Colors.red
                                                              : AppColors.text),
                                                    )),
                                                  ),
                                                ),
                                              ],
                                            ));
                                      }),
                                );
                              }),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

double convertString(String? input) {
  String firstHalf = input!.substring(0, input.indexOf(':'));
  String secHalf = input.substring(input.indexOf(':') + 1);

  int hour = int.parse(firstHalf);
  int min = int.parse(secHalf);

  double output = hour + min / 60;

  return output;
}

extension Ex on double {
  double toPrecision(int n) => double.parse(toStringAsFixed(n));
}
