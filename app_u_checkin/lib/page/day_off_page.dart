// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_u_checkin/cache/cache_sharepreferences.dart';
import 'package:app_u_checkin/model/dayoff.dart';
import 'package:app_u_checkin/model/working_day.dart';
import 'package:app_u_checkin/model/working_week.dart';
import 'package:app_u_checkin/model/working_year.dart';
import 'package:app_u_checkin/page/home_page.dart';
import 'package:app_u_checkin/page/make_day_off.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:app_u_checkin/model/user.dart';
import 'package:app_u_checkin/page/profile_page.dart';
import 'package:app_u_checkin/values/app_assets.dart';
import 'package:app_u_checkin/values/app_colors.dart';
import 'package:app_u_checkin/values/app_styles.dart';

class DayOffHomePage extends StatefulWidget {
  User user;
  DayOffHomePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<DayOffHomePage> createState() => _DayOffHomePageState();
}

class _DayOffHomePageState extends State<DayOffHomePage> {
  late PageController _pageController;
  List<WorkingYear> dataYear = [];

  int _currentIndex = 1;
  DateTime systemTime() => DateTime.now();

  getDataDayOff() async {
    List<DayOff> newDayOffObj = await NPreferences().getListDataDayOff(widget.user.dayOff.toString());
    List<WorkingYear> newList = [];
    WorkingYear yearObj = WorkingYear.init();
    yearObj.dayOff.addAll(newDayOffObj);

    // newList.add(getNowWeek(now));
    // newList.add(getNextWeek(endDate));
    // newList.insert(0, getLastWeek(startDate));
    for (int i = 0; i < newDayOffObj.length; i++) {
      print('newDayOffObj[i].type ---->   ${newDayOffObj[i].type}');
      print('newDayOffObj[i].offFrom ---->   ${newDayOffObj[i].offFrom.toString()}');
      print('newDayOffObj[i].offTo ---->   ${newDayOffObj[i].offTo.toString()}');
      print('newDayOffObj[i].description ---->   ${newDayOffObj[i].description}');
    }
    newList.add(yearObj);
    setState(() {
      dataYear.addAll(newList);
    });
    await _pageController.animateToPage(_currentIndex, duration: Duration(milliseconds: 20), curve: Curves.bounceInOut);
  }

  // WorkingWeek getNowWeek(DateTime date) {
  //   WorkingWeek week = WorkingWeek.init();
  //   List<WorkingDay> listWeekNow = [];
  //   var startDate = date.subtract(Duration(days: date.weekday - 1));
  //   final items = List<DateTime>.generate(7, (i) {
  //     DateTime list = startDate;
  //     return list.add(Duration(days: i));
  //   });
  //   for (int i = 0; i < items.length; i++) {
  //     listWeekNow.add(WorkingDay(date: items[i]));
  //   }
  //   week.dayOfWeek.addAll(listWeekNow);
  //   return week;
  // }

  // WorkingWeek getLastWeek(DateTime date) {
  //   WorkingWeek week = WorkingWeek.init();
  //   List<WorkingDay> listWeekLast = [];
  //   for (int i = 7; i > 0; i--) {
  //     var beforeDay = date.subtract(Duration(days: i));
  //     listWeekLast.add(WorkingDay(
  //       date: beforeDay,
  //     ));
  //   }
  //   week.dayOfWeek.addAll(listWeekLast);
  //   return week;
  // }

  // WorkingWeek getNextWeek(DateTime date) {
  //   WorkingWeek week = WorkingWeek.init();
  //   List<WorkingDay> listWeekNext = [];
  //   for (int i = 1; i <= 7; i++) {
  //     var behindDay = date.add(Duration(days: i));
  //     listWeekNext.add(WorkingDay(date: behindDay));
  //   }
  //   week.dayOfWeek.addAll(listWeekNext);
  //   return week;
  // }

  handlePreviousButtonTapped() async {
    _currentIndex--;
    if (_currentIndex <= 0) {
      // if (dataYear.isNotEmpty && dataYear[0].dayOfWeek.first.date != null) {
      //   var lastWeek = await getLastWeek(dataYear[0].dayOfWeek.first.date!);
      //   _currentIndex = 1;
      //   setState(() {
      //     dataYear.insert(0, lastWeek);
      //   });
      // }
    } else {
      _pageController.animateToPage(_currentIndex, duration: Duration(milliseconds: 20), curve: Curves.bounceInOut);
    }
  }

  handleNextButtonTapped() async {
    _currentIndex++;
    if (_currentIndex >= dataYear.length - 1) {
      //   var nextWeek = await getNextWeek(dataYear.last.dayOfWeek.last.date!);
      //   setState(() {
      //     dataYear.add(nextWeek);
      //   });
    }
    _pageController.animateToPage(_currentIndex, duration: Duration(milliseconds: 20), curve: Curves.bounceInOut);
  }

  @override
  void initState() {
    super.initState();
    getDataDayOff();
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
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => HomePage(
                                    newUser: widget.user,
                                  )));
                    },
                    child: Container(
                      width: 71.w,
                      height: 71.h,
                      child: Image.asset(AppAssets.avatar),
                    ),
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
                            widget.user.name.toString(),
                            style: TextStyle(color: Colors.white, fontFamily: FontFamily.bai_jamjuree, fontSize: 16.sp, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Position: ${widget.user.position}',
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
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => MakeDayOff(
                              user: widget.user,
                            )));
              },
              child: Container(
                  alignment: Alignment.center,
                  width: 181.w,
                  height: 36.h,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(12.r)), border: Border.all(width: 1.w, color: AppColors.main)),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 25.w),
                        child: Image.asset(AppAssets.addCircle),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.w),
                        child: Text(
                          'Make day-off',
                          style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 14.sp, fontWeight: FontWeight.bold, color: AppColors.main),
                        ),
                      )
                    ],
                  )),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 24.h),
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
                        'Your day off table',
                        style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 16.sp, fontWeight: FontWeight.bold),
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
                                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                  child: SizedBox(
                                                    child: Text(
                                                      '2024',
                                                      style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 16.sp, color: Colors.black),
                                                    ),
                                                  )),
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    width: 83.w,
                                    height: 31.h,
                                    decoration: BoxDecoration(color: AppColors.date, borderRadius: BorderRadius.all(Radius.circular(4.r))),
                                    child: Text(
                                      'Date',
                                      style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 14.sp, color: Colors.white),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: 83.w,
                                    height: 31.h,
                                    decoration: BoxDecoration(color: AppColors.checkin, borderRadius: BorderRadius.all(Radius.circular(4.r))),
                                    child: Text(
                                      'Type',
                                      style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 14.sp, color: Colors.white),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: 83.w,
                                    height: 31.h,
                                    decoration: BoxDecoration(color: AppColors.worktime, borderRadius: BorderRadius.all(Radius.circular(4.r))),
                                    child: Text(
                                      'Description',
                                      style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 14.sp, color: Colors.white),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: 83.w,
                                    height: 31.h,
                                    decoration: BoxDecoration(color: AppColors.checkout, borderRadius: BorderRadius.all(Radius.circular(4.r))),
                                    child: Text(
                                      'Status',
                                      style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 14.sp, color: Colors.white),
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
                              itemCount: dataYear.length,
                              itemBuilder: (context, i) {
                                return Container(
                                  child: ListView.separated(
                                      padding: EdgeInsets.only(top: 0.h),
                                      itemCount: dataYear[i].dayOff.length,
                                      separatorBuilder: (context, index) => SizedBox(
                                            height: 8.h,
                                          ),
                                      itemBuilder: (context, index) {
                                        var shortCut = dataYear[i].dayOff[index];
                                        print(shortCut.dateString());
                                        return Container(
                                            height: 31.h,
                                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(8))),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Center(
                                                      child: Text(
                                                    shortCut.dateString(),
                                                    style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 14.sp, color: AppColors.text),
                                                    overflow: TextOverflow.ellipsis,
                                                  )),
                                                ),
                                                Expanded(
                                                  child: SizedBox(
                                                    height: 34.h,
                                                    width: 83.w,
                                                    child: Center(
                                                      child: Text(shortCut.type.toString(),
                                                          style:
                                                              TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 14.sp, color: AppColors.text)),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: SizedBox(
                                                    height: 34.h,
                                                    width: 83.w,
                                                    child: Center(
                                                      child: Text(
                                                        shortCut.description.toString(),
                                                        style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 14.sp, color: AppColors.text),
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Center(
                                                      child: Text(
                                                    'Submitted',
                                                    style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 14.sp, color: AppColors.text),
                                                  )),
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
