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
    super.key,
    required this.user,
  });

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

    newList.add(yearObj);
    setState(() {
      dataYear.addAll(newList);
    });
    await _pageController.animateToPage(_currentIndex, duration: const Duration(milliseconds: 20), curve: Curves.bounceInOut);
  }

  handlePreviousButtonTapped() async {
    _currentIndex--;
    if (_currentIndex <= 0) {
    } else {
      _pageController.animateToPage(_currentIndex, duration: const Duration(milliseconds: 20), curve: Curves.bounceInOut);
    }
  }

  handleNextButtonTapped() async {
    _currentIndex++;
    if (_currentIndex >= dataYear.length - 1) {}
    _pageController.animateToPage(_currentIndex, duration: const Duration(milliseconds: 20), curve: Curves.bounceInOut);
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
                    child: SizedBox(
                      width: 71.w,
                      height: 71.h,
                      child: Image.asset(AppAssets.avatar),
                    ),
                  ),
                  SizedBox(
                    width: 35.w,
                  ),
                  Expanded(
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
            child: SizedBox(
              width: 358.w,
              height: 584.h,
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
                  SizedBox(
                    width: 358.w,
                    height: 552.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          // width: 358.w,
                          height: 75.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
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
                                            SizedBox(
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
                                return ListView.separated(
                                    padding: EdgeInsets.only(top: 0.h),
                                    itemCount: dataYear[i].dayOff.length,
                                    separatorBuilder: (context, index) => SizedBox(
                                          height: 8.h,
                                        ),
                                    itemBuilder: (context, index) {
                                      var shortCut = dataYear[i].dayOff[index];
                                      return Container(
                                          height: 31.h,
                                          decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(8))),
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
                                    });
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
