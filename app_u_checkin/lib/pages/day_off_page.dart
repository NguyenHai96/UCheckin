// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'package:app_u_checkin/cache/cache_sharepreferences.dart';
import 'package:app_u_checkin/model/dayoff.dart';
import 'package:app_u_checkin/model/working_week.dart';
import 'package:app_u_checkin/model/working_year.dart';
import 'package:app_u_checkin/pages/home_page.dart';
import 'package:app_u_checkin/pages/make_day_off.dart';
import 'package:app_u_checkin/providers/dayoff_provider.dart';
import 'package:app_u_checkin/providers/homepage_provider.dart';
import 'package:app_u_checkin/providers/outthem_provider.dart';
import 'package:app_u_checkin/widgets/app_handle_title.dart';
import 'package:app_u_checkin/widgets/app_title_colum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:app_u_checkin/model/user.dart';
import 'package:app_u_checkin/pages/profile_page.dart';
import 'package:app_u_checkin/values/app_assets.dart';
import 'package:app_u_checkin/values/app_colors.dart';
import 'package:app_u_checkin/values/app_styles.dart';
import 'package:provider/provider.dart';

class DayOffHomePage extends StatefulWidget {
  const DayOffHomePage({
    super.key,
  });

  @override
  State<DayOffHomePage> createState() => _DayOffHomePageState();
}

class _DayOffHomePageState extends State<DayOffHomePage> {
  late PageController _pageController;

  getDataDayOff() async {
    await context.read<DayOffProvider>().getData(context);

    await _pageController.animateToPage(context.read<DayOffProvider>().currentIndex,
        duration: const Duration(milliseconds: 20), curve: Curves.bounceInOut);
  }

  handlePreviousButtonTapped() async {
    context.read<DayOffProvider>().currentIndex--;
    if (context.read<DayOffProvider>().currentIndex <= 0) {
    } else {
      _pageController.animateToPage(context.read<DayOffProvider>().currentIndex,
          duration: const Duration(milliseconds: 20), curve: Curves.bounceInOut);
    }
  }

  handleNextButtonTapped() async {
    context.read<DayOffProvider>().currentIndex++;
    if (context.read<DayOffProvider>().currentIndex >= context.read<DayOffProvider>().dataYear.length - 1) {}
    _pageController.animateToPage(context.read<DayOffProvider>().currentIndex, duration: const Duration(milliseconds: 20), curve: Curves.bounceInOut);
  }

  @override
  void initState() {
    super.initState();
    getDataDayOff();
    _pageController = PageController(initialPage: context.read<DayOffProvider>().currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, DayOffProvider infoDayOff, _) {
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
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const HomePage()));
                        },
                        child: SizedBox(
                          width: 71.h,
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
                              context.read<OutThemeProvider>().user.name.toString(),
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
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const MakeDayOff()));
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
                              style:
                                  TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 14.sp, fontWeight: FontWeight.bold, color: AppColors.main),
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
                  height: 565.h,
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
                        height: 533.h,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              // width: 358.w,
                              height: 75.h,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  AppHandleTitle(
                                    label: '${infoDayOff.now.year}',
                                    imageRight: AppAssets.rightArrow,
                                    imageLeft: AppAssets.leftArrow,
                                    onTapRight: () {
                                      handleNextButtonTapped();
                                    },
                                    onTapLeft: () {
                                      handlePreviousButtonTapped();
                                    },
                                  ),
                                  const AppTitleIdie(colum1: 'Date', colum2: 'Type', colum3: 'Description', colum4: 'Status')
                                ],
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Expanded(
                              child: PageView.builder(
                                  controller: _pageController,
                                  onPageChanged: (i) {
                                    setState(() {
                                      infoDayOff.currentIndex = i;
                                    });
                                  },
                                  itemCount: infoDayOff.dataYear.length,
                                  itemBuilder: (context, i) {
                                    return ListView.separated(
                                        padding: EdgeInsets.only(top: 0.h),
                                        itemCount: infoDayOff.dataYear[i].dayOff.length,
                                        separatorBuilder: (context, index) => SizedBox(
                                              height: 8.h,
                                            ),
                                        itemBuilder: (context, index) {
                                          var shortCut = infoDayOff.dataYear[i].dayOff[index];
                                          return Container(
                                              height: 31.h,
                                              decoration:
                                                  const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(8))),
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
                                                            style: TextStyle(
                                                                fontFamily: FontFamily.bai_jamjuree, fontSize: 14.sp, color: AppColors.text)),
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
                                                          style:
                                                              TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 14.sp, color: AppColors.text),
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
      },
    );
  }
}
