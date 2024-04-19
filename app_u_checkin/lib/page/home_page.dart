// ignore_for_file: must_be_immutable

import 'package:app_u_checkin/cache/cache_sharepreferences.dart';
import 'package:app_u_checkin/model/user.dart';
import 'package:app_u_checkin/model/working_week.dart';
import 'package:app_u_checkin/page/check_in_page.dart';
import 'package:app_u_checkin/page/day_off_page.dart';
import 'package:app_u_checkin/page/make_day_off.dart';
import 'package:app_u_checkin/page/profile_page.dart';
import 'package:app_u_checkin/providers/homepage_provider.dart';
import 'package:app_u_checkin/values/app_assets.dart';
import 'package:app_u_checkin/model/working_day.dart';
import 'package:app_u_checkin/values/app_colors.dart';
import 'package:app_u_checkin/values/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;
  int _currentIndex = 1;

  handlePreviousButtonTapped() async {
    _currentIndex--;
    if (_currentIndex <= 0) {
      context.read<HomePageProvider>().getHandlePreviousButton();
      _currentIndex = 1;
    } else {
      _pageController.animateToPage(_currentIndex, duration: const Duration(milliseconds: 20), curve: Curves.bounceInOut);
    }
  }

  handleNextButtonTapped() async {
    _currentIndex++;
    if (_currentIndex >= context.read<HomePageProvider>().dataWeek.length - 1) {
      context.read<HomePageProvider>().getHandleNextButton();
    }
    _pageController.animateToPage(_currentIndex, duration: const Duration(milliseconds: 20), curve: Curves.bounceInOut);
  }

  String getWeekState() {
    var weekTitle = "";
    if (_currentIndex < context.read<HomePageProvider>().dataWeek.length) {
      weekTitle = context.read<HomePageProvider>().dataWeek[_currentIndex].getWeekTitle();
    }
    return weekTitle;
  }

  @override
  void initState() {
    super.initState();
    context.read<HomePageProvider>().getDateTimeWork();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageProvider>(
      builder: (BuildContext context, homePage, _) {
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
                        onTap: () async {
                          // final result = await Navigator.push(context, MaterialPageRoute(builder: (_) => const YourProFilePage()));
                          // if (result != null) {
                          //   for (int i = 0; i < homePage.dataWeek.length; i++) {
                          //     for (int j = 0; j < homePage.dataWeek[i].dayOfWeek.length; j++) {
                          //       if (DateUtils.isSameDay(homePage.dataWeek[i].dayOfWeek[j].date, result.date)) {
                          //         setState(() {
                          //           homePage.dataWeek[i].dayOfWeek[j].checkin = result.checkin;
                          //           homePage.dataWeek[i].dayOfWeek[j].checkout = result.checkout;
                          //         });
                          //       }
                          //     }
                          //   }
                          // }
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const YourProFilePage()));
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
                              homePage.user.name ?? '',
                              style:
                                  TextStyle(color: Colors.white, fontFamily: FontFamily.bai_jamjuree, fontSize: 16.sp, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Position: ${homePage.user.position}',
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
                child: SizedBox(
                  width: 359.w,
                  height: 158.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 247.w,
                        height: 51.h,
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(12.r))),
                        child: Text(
                          'Hi, have a effective work day!!!',
                          style: TextStyle(fontFamily: FontFamily.bellefair, fontSize: 19.sp, color: Colors.black),
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
                                borderRadius: BorderRadius.all(Radius.circular(12.r)),
                                boxShadow: const [BoxShadow(color: Colors.black26, offset: Offset(1, 3), blurRadius: 2.6)]),
                            child: InkWell(
                              onTap: () async {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => PageCheckIn(user: homePage.user)),
                                );
                                if (result != null) {
                                  for (int i = 0; i < homePage.dataWeek.length; i++) {
                                    for (int j = 0; j < homePage.dataWeek[i].dayOfWeek.length; j++) {
                                      if (DateUtils.isSameDay(homePage.dataWeek[i].dayOfWeek[j].date, result.date)) {
                                        setState(() {
                                          homePage.dataWeek[i].dayOfWeek[j].checkin = result.checkin;
                                          homePage.dataWeek[i].dayOfWeek[j].checkout = result.checkout;
                                        });
                                      }
                                    }
                                  }
                                }
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
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
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => MakeDayOff(
                                            user: homePage.user,
                                          )));
                            },
                            child: Container(
                              height: 91.h,
                              width: 109.w,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(12.r)),
                                  boxShadow: const [BoxShadow(color: Colors.black26, offset: Offset(1, 3), blurRadius: 2.6)]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
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
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => DayOffHomePage(
                                            user: homePage.user,
                                          )));
                            },
                            child: Container(
                              height: 91.h,
                              width: 109.w,
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.all(Radius.circular(12.r)),
                                  boxShadow: const [BoxShadow(color: Colors.black26, offset: Offset(1, 3), blurRadius: 2.6)]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
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
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 32.h),
                child: SizedBox(
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
                            style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 16.sp, fontWeight: FontWeight.bold),
                          )
                        ],
                      )),
                      SizedBox(
                        width: 358.w,
                        height: 352.h,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 358.w,
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
                                                          // homePage.getWeekState(),
                                                          getWeekState(),
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
                                          'Check in',
                                          style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 14.sp, color: Colors.white),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        width: 83.w,
                                        height: 31.h,
                                        decoration: BoxDecoration(color: AppColors.checkout, borderRadius: BorderRadius.all(Radius.circular(4.r))),
                                        child: Text(
                                          'Check out',
                                          style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 14.sp, color: Colors.white),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        width: 83.w,
                                        height: 31.h,
                                        decoration: BoxDecoration(color: AppColors.worktime, borderRadius: BorderRadius.all(Radius.circular(4.r))),
                                        child: Text(
                                          'Work time',
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
                                  itemCount: homePage.dataWeek.length,
                                  itemBuilder: (context, i) {
                                    return ListView.separated(
                                        padding: EdgeInsets.only(top: 0.h),
                                        itemCount: homePage.dataWeek[i].dayOfWeek.length,
                                        separatorBuilder: (context, index) => SizedBox(
                                              height: 8.h,
                                            ),
                                        itemBuilder: (context, index) {
                                          var shortCut = homePage.dataWeek[i].dayOfWeek[index];
                                          return Container(
                                              width: 358.w,
                                              height: 31.h,
                                              decoration: BoxDecoration(
                                                  color: !shortCut.isWeekend() ? Colors.white : AppColors.visible,
                                                  borderRadius: const BorderRadius.all(Radius.circular(8))),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Center(
                                                        child: Text(
                                                      shortCut.getDateString(),
                                                      style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 14.sp, color: AppColors.text),
                                                    )),
                                                  ),
                                                  Expanded(
                                                    child: SizedBox(
                                                      height: 34.h,
                                                      width: 83.w,
                                                      child: Visibility(
                                                        visible: shortCut.checkin != null,
                                                        child: Center(
                                                          child: Text(shortCut.checkinTimeString(),
                                                              style: TextStyle(
                                                                  fontFamily: FontFamily.bai_jamjuree,
                                                                  fontSize: 14.sp,
                                                                  color: shortCut.checkWrongTimeCheckIn() ? AppColors.text : Colors.red)),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: SizedBox(
                                                      height: 34.h,
                                                      width: 83.w,
                                                      child: Visibility(
                                                        visible: shortCut.checkout != null,
                                                        child: Center(
                                                          child: Text(shortCut.checkoutTimeString(),
                                                              style: TextStyle(
                                                                  fontFamily: FontFamily.bai_jamjuree,
                                                                  fontSize: 14.sp,
                                                                  color: shortCut.checkWrongTimeCheckOut() ? AppColors.text : Colors.red)),
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
                                                            fontFamily: FontFamily.bai_jamjuree,
                                                            fontSize: 14.sp,
                                                            color: shortCut.checkWrongTimeWorkTime() ? AppColors.text : Colors.red),
                                                      )),
                                                    ),
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
      },
    );
  }
}
