import 'dart:convert';
import 'dart:math';

import 'package:app_u_checkin/cache/cache_sharepreferences.dart';
import 'package:app_u_checkin/model/working_day.dart';
import 'package:app_u_checkin/model/working_month.dart';
import 'package:app_u_checkin/values/app_assets.dart';
import 'package:app_u_checkin/values/app_colors.dart';
import 'package:app_u_checkin/values/app_styles.dart';
import 'package:app_u_checkin/values/share_keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageCheckIn extends StatefulWidget {
  const PageCheckIn({super.key});

  @override
  State<PageCheckIn> createState() => _PageCheckInState();
}

class _PageCheckInState extends State<PageCheckIn> {
  late PageController _pageController;
  List<WorkingMonth> dataMonth = [];
  int _currentIndex = 1;
  DateTime systemTime() => DateTime.now();

  getDateTimeWork() async {
    DateTime now = DateTime.now();

    final newWorkingObj =
        await NPreferences().getDataWorkingDay(ShareKeys.checkTime);
    var encodedString = jsonEncode(newWorkingObj);
    Map<String, dynamic>? valueMap = json.decode(encodedString);
    WorkingDay? dataWorkingday;
    if (valueMap != null) {
      dataWorkingday = WorkingDay.fromJson(valueMap);
    } else {
      dataWorkingday = null;
    }

    List<WorkingMonth> newList = [];

    newList.add(getNowMonth(now));
    newList.add(getNextMonth(now));
    newList.insert(0, getLastMonth(now));

    for (int i = 0; i < newList.length; i++) {
      for (int j = 0; j < newList[i].dayOfWeek.length; j++) {
        if (newList[i].dayOfWeek[j].date == dataWorkingday?.date) {
          newList[i].dayOfWeek[j].checkin = dataWorkingday?.checkin;
          newList[i].dayOfWeek[j].checkout = dataWorkingday?.checkout;
        }
      }
    }
    setState(() {
      dataMonth.addAll(newList);
    });
  }

  WorkingMonth getNowMonth(DateTime date) {
    WorkingMonth month = WorkingMonth.init();
    List<WorkingDay> listMonthNow = [];
    DateTime startDateMonth = DateTime(date.year, date.month);
    DateTime endDateMonth = DateTime(date.year, date.month + 1);
    int daysInMonth =
        DateTimeRange(start: startDateMonth, end: endDateMonth).duration.inDays;

    final items = List<DateTime>.generate(daysInMonth, (i) {
      DateTime fristDay = DateTime(date.year, date.month, 1);
      return fristDay.add(Duration(days: i));
    });
    for (int i = 0; i < items.length; i++) {
      listMonthNow.add(WorkingDay(date: items[i]));
    }
    month.dayOfWeek.addAll(listMonthNow);
    return month;
  }

  WorkingMonth getLastMonth(DateTime date) {
    WorkingMonth month = WorkingMonth.init();
    List<WorkingDay> listMonthLast = [];
    DateTime startDateMonth = DateTime(date.year, date.month - 1);
    DateTime endDateMonth = DateTime(date.year, date.month);
    int daysInMonth =
        DateTimeRange(start: startDateMonth, end: endDateMonth).duration.inDays;

    final items = List<DateTime>.generate(daysInMonth, (i) {
      DateTime fristDay = DateTime(date.year, date.month - 1, 1);
      return fristDay.add(Duration(days: i));
    });
    for (int i = 0; i < items.length; i++) {
      listMonthLast.add(WorkingDay(date: items[i]));
    }
    month.dayOfWeek.addAll(listMonthLast);
    return month;
  }

  WorkingMonth getNextMonth(DateTime date) {
    WorkingMonth month = WorkingMonth.init();
    List<WorkingDay> listMonthNext = [];
    DateTime startDateMonth = DateTime(date.year, date.month + 1);
    DateTime endDateMonth = DateTime(date.year, date.month + 2);
    int daysInMonth =
        DateTimeRange(start: startDateMonth, end: endDateMonth).duration.inDays;

    final items = List<DateTime>.generate(daysInMonth, (i) {
      DateTime fristDay = DateTime(date.year, date.month + 1, 1);
      return fristDay.add(Duration(days: i));
    });
    for (int i = 0; i < items.length; i++) {
      listMonthNext.add(WorkingDay(date: items[i]));
    }
    month.dayOfWeek.addAll(listMonthNext);
    return month;
  }

  handlePreviousButtonTapped() async {
    _currentIndex--;
    if (_currentIndex <= 0) {
      if (dataMonth.isNotEmpty && dataMonth[0].dayOfWeek.first.date != null) {
        var lastMonth = await getLastMonth(dataMonth[0].dayOfWeek.first.date!);
        _currentIndex = 1;
        setState(() {
          dataMonth.insert(0, lastMonth);
        });
      }
    } else {
      _pageController.animateToPage(_currentIndex,
          duration: Duration(milliseconds: 20), curve: Curves.bounceInOut);
    }
  }

  handleNextButtonTapped() async {
    _currentIndex++;
    if (_currentIndex >= dataMonth.length - 1) {
      if (dataMonth.isNotEmpty && dataMonth.last.dayOfWeek.last.date != null) {
        var nextMonth = await getNextMonth(dataMonth.last.dayOfWeek.last.date!);
        setState(() {
          dataMonth.add(nextMonth);
        });
      }
    }
    _pageController.animateToPage(_currentIndex,
        duration: Duration(milliseconds: 20), curve: Curves.bounceInOut);
  }

  String getMonthState() {
    var monthTitle = " ";
    if (_currentIndex < dataMonth.length) {
      monthTitle = dataMonth[_currentIndex].getMonthTitle();
    }
    return monthTitle;
  }

  @override
  void initState() {
    super.initState();
    getDateTimeWork();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black12,
        backgroundColor: Colors.white,
        title: Text(
          'Check in',
          style: TextStyle(
              fontFamily: FontFamily.beVietnamPro,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold),
        ),
        leading: InkWell(
          onTap: () {
            NPreferences().clear();
            Navigator.pop(context);
          },
          child: Image.asset(AppAssets.leftArrow),
        ),
      ),
      body: Container(
        color: AppColors.login,
        child: Padding(
          padding: EdgeInsets.all(16.h),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Your puch in table',
                  style: TextStyle(
                      fontFamily: FontFamily.bai_jamjuree,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              Expanded(
                  child: Column(
                children: [
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            width: 358.w,
                            height: 32.h,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 24.w,
                                    height: 24.h,
                                    child: InkWell(
                                      onTap: () {
                                        handlePreviousButtonTapped();
                                      },
                                      child: Image.asset(AppAssets.leftArrow),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                        alignment: Alignment.center,
                                        child: Text(getMonthState(),
                                            style: TextStyle(
                                                fontFamily:
                                                    FontFamily.bai_jamjuree,
                                                fontSize: 16.sp,
                                                color: Colors.black))),
                                  ),
                                  Container(
                                    width: 24.w,
                                    height: 24.h,
                                    child: InkWell(
                                      onTap: () {
                                        handleNextButtonTapped();
                                      },
                                      child: Image.asset(AppAssets.rightArrow),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 83.w,
                        height: 31.h,
                        decoration: BoxDecoration(
                            color: AppColors.date,
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.r))),
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.r))),
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.r))),
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.r))),
                        child: Text(
                          'Work time',
                          style: TextStyle(
                              fontFamily: FontFamily.bai_jamjuree,
                              fontSize: 14.sp,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Expanded(
                    child: PageView.builder(
                        controller: _pageController,
                        onPageChanged: (i) {
                          setState(() {
                            _currentIndex = i;
                          });
                        },
                        itemCount: dataMonth.length,
                        itemBuilder: (context, i) {
                          return Container(
                            child: ListView.separated(
                                padding: EdgeInsets.only(top: 0.h),
                                itemCount: dataMonth[i].dayOfWeek.length,
                                separatorBuilder: (context, index) => SizedBox(
                                      height: 8.h,
                                    ),
                                itemBuilder: (context, index) {
                                  var shortCut = dataMonth[i].dayOfWeek[index];
                                  return Container(
                                      width: 358.w,
                                      height: 34.h,
                                      decoration: BoxDecoration(
                                          color: !shortCut.isWeekend()
                                              ? Colors.white
                                              : AppColors.visible,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Center(
                                                child: Text(
                                              shortCut.getDateString(),
                                              style: TextStyle(
                                                  fontFamily:
                                                      FontFamily.bai_jamjuree,
                                                  fontSize: 14.sp,
                                                  color: AppColors.text),
                                            )),
                                          ),
                                          Expanded(
                                            child: SizedBox(
                                              height: 34.h,
                                              width: 83.w,
                                              child: Visibility(
                                                visible:
                                                    shortCut.checkinAvailable(),
                                                replacement: Center(
                                                  child: Text(
                                                      shortCut
                                                          .checkinTimeString(),
                                                      style: TextStyle(
                                                          fontFamily: FontFamily
                                                              .bai_jamjuree,
                                                          fontSize: 14.sp,
                                                          color: shortCut
                                                                  .checkWrongTimeCheckIn()
                                                              ? AppColors.text
                                                              : Colors.red)),
                                                ),
                                                child: Center(
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height: 22.h,
                                                    width: 56.w,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            AppColors.checkout,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    4.r))),
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          shortCut.checkin =
                                                              systemTime();
                                                          shortCut
                                                              .checkinTimeString();
                                                        });

                                                        final newWokingDayJson =
                                                            jsonEncode(shortCut
                                                                .toJson());
                                                        NPreferences().saveData(
                                                            ShareKeys.checkTime,
                                                            newWokingDayJson);
                                                      },
                                                      child: Text(
                                                        'Check in',
                                                        style: TextStyle(
                                                            fontFamily: FontFamily
                                                                .bai_jamjuree,
                                                            fontSize: 12.sp,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: SizedBox(
                                              height: 34.h,
                                              width: 83.w,
                                              child: Visibility(
                                                visible: shortCut
                                                    .checkoutAvailable(),
                                                replacement: Center(
                                                  child: Text(
                                                      shortCut
                                                          .checkoutTimeString(),
                                                      style: TextStyle(
                                                          fontFamily: FontFamily
                                                              .bai_jamjuree,
                                                          fontSize: 14.sp,
                                                          color: shortCut
                                                                  .checkWrongTimeCheckOut()
                                                              ? AppColors.text
                                                              : Colors.red)),
                                                ),
                                                child: Center(
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height: 22.h,
                                                    width: 64.w,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            shortCut.checkin !=
                                                                    null
                                                                ? AppColors.main
                                                                : Colors.grey,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    4.r))),
                                                    child: InkWell(
                                                      onTap: shortCut.checkin !=
                                                              null
                                                          ? () async {
                                                              setState(() {
                                                                shortCut.checkout =
                                                                    systemTime();
                                                              });

                                                              final newWorkingObj =
                                                                  jsonEncode(
                                                                      shortCut
                                                                          .toJson());

                                                              NPreferences().saveData(
                                                                  ShareKeys
                                                                      .checkTime,
                                                                  newWorkingObj);
                                                            }
                                                          : null,
                                                      child: Text(
                                                        'Check out',
                                                        style: TextStyle(
                                                            fontFamily: FontFamily
                                                                .bai_jamjuree,
                                                            fontSize: 12.sp,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Visibility(
                                              visible: shortCut.showWorkTime(),
                                              child: Center(
                                                  child: Text(
                                                '${shortCut.resultWorkTime()} h',
                                                style: TextStyle(
                                                    fontFamily:
                                                        FontFamily.bai_jamjuree,
                                                    fontSize: 14.sp,
                                                    color: shortCut
                                                            .checkWrongTimeWorkTime()
                                                        ? AppColors.text
                                                        : Colors.red),
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
              ))
            ],
          ),
        ),
      ),
    );
  }
}

String getTimeString(DateTime time) {
  String formattedTime = DateFormat('HH:mm').format(time);
  String timeNow = formattedTime;
  return timeNow;
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
