import 'package:app_u_checkin/cache/cache_sharepreferences.dart';
import 'package:app_u_checkin/model/working_week.dart';
import 'package:app_u_checkin/page/check_in_page.dart';
import 'package:app_u_checkin/values/app_assets.dart';
import 'package:app_u_checkin/model/working_day.dart';
import 'package:app_u_checkin/values/app_colors.dart';
import 'package:app_u_checkin/values/app_styles.dart';
import 'package:app_u_checkin/values/share_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;
  List<WorkingWeek> dataWeek = [];
  int _currentIndex = 1;
  DateTime systemTime() => DateTime.now();

  getDateTimeWork() async {
    DateTime now = DateTime.now();

    List<WorkingDay> newWorkingObj =
        await NPreferences().getListDataWorkingDay(ShareKeys.timeWorking);
    for (int i = 0; i < newWorkingObj.length; i++) {}
    var startDate = now.subtract(Duration(days: now.weekday - 1));
    var endDate = now.add(Duration(days: 7 - now.weekday));
    List<WorkingWeek> newList = [];
    newList.add(getNowWeek(now));
    newList.add(getNextWeek(endDate));
    newList.insert(0, getLastWeek(startDate));

    for (int i = 0; i < newList.length; i++) {
      for (int j = 0; j < newList[i].dayOfWeek.length; j++) {
        for (int l = 0; l < newWorkingObj.length; l++) {
          if (DateUtils.isSameDay(
              newList[i].dayOfWeek[j].date, newWorkingObj[l].date)) {
            newList[i].dayOfWeek[j].checkin = newWorkingObj[l].checkin;
            newList[i].dayOfWeek[j].checkout = newWorkingObj[l].checkout;
            print(newList[i].dayOfWeek[j].checkin);
            print(newList[i].dayOfWeek[j].checkout);
          }
        }
      }
    }

    setState(() {
      dataWeek.addAll(newList);
    });
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
      listWeekNow.add(WorkingDay(date: items[i]));
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
      ));
    }
    week.dayOfWeek.addAll(listWeekLast);
    return week;
  }

  WorkingWeek getNextWeek(DateTime date) {
    WorkingWeek week = WorkingWeek.init();
    List<WorkingDay> listWeekNext = [];
    for (int i = 1; i <= 7; i++) {
      var behindDay = date.add(Duration(days: i));
      listWeekNext.add(WorkingDay(date: behindDay));
    }
    week.dayOfWeek.addAll(listWeekNext);
    return week;
  }

  handlePreviousButtonTapped() async {
    _currentIndex--;
    if (_currentIndex <= 0) {
      if (dataWeek.isNotEmpty && dataWeek[0].dayOfWeek.first.date != null) {
        var lastWeek = await getLastWeek(dataWeek[0].dayOfWeek.first.date!);
        _currentIndex = 1;
        setState(() {
          dataWeek.insert(0, lastWeek);
        });
      }
    } else {
      _pageController.animateToPage(_currentIndex,
          duration: Duration(milliseconds: 20), curve: Curves.bounceInOut);
    }
  }

  handleNextButtonTapped() async {
    _currentIndex++;
    if (_currentIndex >= dataWeek.length - 1) {
      if (dataWeek.isNotEmpty && dataWeek.last.dayOfWeek.last.date != null) {
        var nextWeek = await getNextWeek(dataWeek.last.dayOfWeek.last.date!);
        setState(() {
          dataWeek.add(nextWeek);
        });
      }
    }
    _pageController.animateToPage(_currentIndex,
        duration: Duration(milliseconds: 20), curve: Curves.bounceInOut);
  }

  String getWeekState() {
    var weekTitle = "";
    if (_currentIndex < dataWeek.length) {
      weekTitle = dataWeek[_currentIndex].getWeekTitle();
    }
    return weekTitle;
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
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => PageCheckIn()));
                          },
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
                                                  handlePreviousButtonTapped();
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
                                                onTap: () {
                                                  handleNextButtonTapped();
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
                                        var shortCut =
                                            dataWeek[i].dayOfWeek[index];

                                        return Container(
                                            width: 358.w,
                                            height: 31.h,
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
                                                        fontFamily: FontFamily
                                                            .bai_jamjuree,
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
                                                          shortCut.checkin !=
                                                              null,
                                                      child: Center(
                                                        child: Text(
                                                            shortCut
                                                                .checkinTimeString(),
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    FontFamily
                                                                        .bai_jamjuree,
                                                                fontSize: 14.sp,
                                                                color: shortCut
                                                                        .checkWrongTimeCheckIn()
                                                                    ? AppColors
                                                                        .text
                                                                    : Colors
                                                                        .red)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: SizedBox(
                                                    height: 34.h,
                                                    width: 83.w,
                                                    child: Visibility(
                                                      visible:
                                                          shortCut.checkout !=
                                                              null,
                                                      child: Center(
                                                        child: Text(
                                                            shortCut
                                                                .checkoutTimeString(),
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    FontFamily
                                                                        .bai_jamjuree,
                                                                fontSize: 14.sp,
                                                                color: shortCut
                                                                        .checkWrongTimeCheckOut()
                                                                    ? AppColors
                                                                        .text
                                                                    : Colors
                                                                        .red)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Visibility(
                                                    visible:
                                                        shortCut.showWorkTime(),
                                                    child: Center(
                                                        child: Text(
                                                      '${shortCut.resultWorkTime()} h',
                                                      style: TextStyle(
                                                          fontFamily: FontFamily
                                                              .bai_jamjuree,
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
