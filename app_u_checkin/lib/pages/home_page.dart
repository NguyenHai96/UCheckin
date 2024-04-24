// ignore_for_file: must_be_immutable

import 'package:app_u_checkin/cache/cache_sharepreferences.dart';
import 'package:app_u_checkin/model/user.dart';
import 'package:app_u_checkin/model/working_week.dart';
import 'package:app_u_checkin/pages/check_in_page.dart';
import 'package:app_u_checkin/pages/day_off_page.dart';
import 'package:app_u_checkin/pages/make_day_off.dart';
import 'package:app_u_checkin/pages/profile_page.dart';
import 'package:app_u_checkin/providers/homepage_provider.dart';
import 'package:app_u_checkin/providers/outthem_provider.dart';
import 'package:app_u_checkin/values/app_assets.dart';
import 'package:app_u_checkin/model/working_day.dart';
import 'package:app_u_checkin/values/app_colors.dart';
import 'package:app_u_checkin/values/app_styles.dart';
import 'package:app_u_checkin/widgets/app_button_page.dart';
import 'package:app_u_checkin/widgets/app_handle_title.dart';
import 'package:app_u_checkin/widgets/app_title_colum.dart';
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

  getDataTimeWorkStart() async {
    await context.read<HomePageProvider>().getDateTimeWork(context);
    await _pageController.animateToPage(context.read<HomePageProvider>().currentIndex,
        duration: const Duration(milliseconds: 20), curve: Curves.bounceInOut);
  }

  handlePreviousButtonTapped() async {
    context.read<HomePageProvider>().currentIndex--;
    if (context.read<HomePageProvider>().currentIndex <= 0) {
      context.read<HomePageProvider>().getHandlePreviousButton();
      context.read<HomePageProvider>().currentIndex = 1;
    } else {
      _pageController.animateToPage(context.read<HomePageProvider>().currentIndex,
          duration: const Duration(milliseconds: 20), curve: Curves.bounceInOut);
    }
  }

  handleNextButtonTapped() async {
    context.read<HomePageProvider>().currentIndex++;
    if (context.read<HomePageProvider>().currentIndex >= context.read<HomePageProvider>().dataWeek.length - 1) {
      context.read<HomePageProvider>().getHandleNextButton();
    }
    _pageController.animateToPage(context.read<HomePageProvider>().currentIndex,
        duration: const Duration(milliseconds: 20), curve: Curves.bounceInOut);
  }

  String getWeekState() {
    var weekTitle = "";
    if (context.read<HomePageProvider>().currentIndex < context.read<HomePageProvider>().dataWeek.length) {
      weekTitle = context.read<HomePageProvider>().dataWeek[context.read<HomePageProvider>().currentIndex].getWeekTitle();
    }
    return weekTitle;
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: context.read<HomePageProvider>().currentIndex);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getDataTimeWorkStart();
    });
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
        print('build');
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
                              context.read<OutThemeProvider>().user.name ?? '',
                              style:
                                  TextStyle(color: Colors.white, fontFamily: FontFamily.bai_jamjuree, fontSize: 16.sp, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Position: ${context.read<OutThemeProvider>().user.position}',
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
                          AppButton(
                              label: 'Checkin',
                              onTap: () async {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => PageCheckIn(user: context.read<OutThemeProvider>().user)),
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
                              image: AppAssets.checkIn),
                          AppButton(
                              label: 'Make day-off',
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_) => MakeDayOff()));
                              },
                              image: AppAssets.makeDayOff),
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (_) => DayOffHomePage()));
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
                                  AppHandleTitle(
                                    label: getWeekState(),
                                    imageRight: AppAssets.rightArrow,
                                    imageLeft: AppAssets.leftArrow,
                                    onTapRight: () {
                                      handleNextButtonTapped();
                                    },
                                    onTapLeft: () {
                                      handlePreviousButtonTapped();
                                    },
                                  ),
                                  const AppTitleIdie(colum1: 'Date', colum2: 'Check in', colum3: 'Check out', colum4: 'Work time')
                                ],
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Expanded(
                              child: PageView.builder(
                                  controller: _pageController,
                                  onPageChanged: (i) {
                                    setState(() {
                                      context.read<HomePageProvider>().currentIndex = i;
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
