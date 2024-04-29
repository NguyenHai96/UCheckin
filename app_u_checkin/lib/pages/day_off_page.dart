// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'package:app_u_checkin/pages/make_day_off.dart';
import 'package:app_u_checkin/providers/bottom_navigation_provider.dart';
import 'package:app_u_checkin/providers/dayoff_provider.dart';
import 'package:app_u_checkin/providers/outthem_provider.dart';
import 'package:app_u_checkin/widgets/app_box_title_info.dart';
import 'package:app_u_checkin/widgets/app_handle_title.dart';
import 'package:app_u_checkin/widgets/app_title_colum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  int currentIndex = 1;

  getDataDayOff() async {
    await context.read<DayOffProvider>().getData(context);
    await _pageController.animateToPage(currentIndex, duration: const Duration(milliseconds: 20), curve: Curves.bounceInOut);
  }

  handlePreviousButtonTapped() async {
    currentIndex--;
    if (currentIndex < 0) {
      setState(() {
        currentIndex = 0;
      });
    } else {
      await _pageController.animateToPage(currentIndex, duration: const Duration(milliseconds: 20), curve: Curves.bounceInOut);
    }
  }

  handleNextButtonTapped() async {
    currentIndex++;
    if (currentIndex >= context.read<DayOffProvider>().dataYear.length - 1) {
      setState(() {
        currentIndex = 2;
      });
    }
    await _pageController.animateToPage(currentIndex, duration: const Duration(milliseconds: 20), curve: Curves.bounceInOut);
  }

  String getTitleState() {
    var titleYear = '';
    if (context.read<DayOffProvider>().dataYear.isEmpty) {
      return titleYear = DateTime.now().year.toString();
    } else {
      titleYear = context.read<DayOffProvider>().dataYear[currentIndex].getWeekTitle();
    }
    return titleYear;
  }

  @override
  void initState() {
    super.initState();
    getDataDayOff();
    getTitleState();
    _pageController = PageController(initialPage: currentIndex);
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
          backgroundColor: AppColors.blueF1FAFF,
          body: SafeArea(
            child: Column(
              children: [
                AppBoxTitleInformaition(
                    onTap: () {
                      setState(() {
                        context.read<BottomNavigationBarProvider>().setCurentIndex();
                      });
                    },
                    labelName: context.read<OutThemeProvider>().user.name.toString(),
                    labelPosition: 'Position: ${context.read<OutThemeProvider>().user.position}',
                    image: AppAssets.avatar),
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
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12.r)), border: Border.all(width: 1.w, color: AppColors.main)),
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
                                style: TextStyle(
                                    fontFamily: FontFamily.bai_jamjuree, fontSize: 14.sp, fontWeight: FontWeight.bold, color: AppColors.main),
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
                    height: 500.h,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20.h,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Your day off table',
                                style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 16.sp, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 12.h),
                          child: SizedBox(
                            width: 358.w,
                            height: 460.h,
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
                                        label: getTitleState(),
                                        imageRight: AppAssets.rightArrow,
                                        imageLeft: AppAssets.leftArrow,
                                        onTapRight: (currentIndex <= 2 && currentIndex >= 0)
                                            ? () async {
                                                await handleNextButtonTapped();
                                              }
                                            : () {},
                                        onTapLeft: (currentIndex <= 2 && currentIndex >= 0)
                                            ? () async {
                                                await handlePreviousButtonTapped();
                                              }
                                            : () {},
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
                                          currentIndex = i;
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
                                                      SizedBox(
                                                        height: 34.h,
                                                        width: 83.w,
                                                        child: Center(
                                                            child: Text(
                                                          shortCut.dateString(),
                                                          style: TextStyle(
                                                              fontFamily: FontFamily.bai_jamjuree, fontSize: 14.sp, color: AppColors.grey777E90),
                                                          overflow: TextOverflow.ellipsis,
                                                        )),
                                                      ),
                                                      SizedBox(
                                                        width: 8.w,
                                                      ),
                                                      Container(
                                                        alignment: Alignment.centerLeft,
                                                        height: 34.h,
                                                        width: 83.w,
                                                        child: Text(shortCut.type.toString(),
                                                            style: TextStyle(
                                                                fontFamily: FontFamily.bai_jamjuree,
                                                                fontSize: 14.sp,
                                                                color: AppColors.grey777E90,
                                                                overflow: TextOverflow.ellipsis)),
                                                      ),
                                                      SizedBox(
                                                        width: 8.w,
                                                      ),
                                                      Container(
                                                        height: 34.h,
                                                        width: 83.w,
                                                        alignment: Alignment.centerLeft,
                                                        child: Text(
                                                          shortCut.description.toString(),
                                                          style: TextStyle(
                                                              fontFamily: FontFamily.bai_jamjuree, fontSize: 14.sp, color: AppColors.grey777E90),
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 8.w,
                                                      ),
                                                      SizedBox(
                                                        height: 34.h,
                                                        width: 83.w,
                                                        child: Center(
                                                            child: Text(
                                                          'Submitted',
                                                          style: TextStyle(
                                                              fontFamily: FontFamily.bai_jamjuree, fontSize: 14.sp, color: AppColors.grey777E90),
                                                        )),
                                                      ),
                                                    ],
                                                  ));
                                            });
                                      }),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
