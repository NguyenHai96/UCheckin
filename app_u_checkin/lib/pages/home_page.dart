// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:app_u_checkin/pages/check_in_page.dart';
import 'package:app_u_checkin/pages/make_day_off.dart';
import 'package:app_u_checkin/providers/bottom_navigation_provider.dart';
import 'package:app_u_checkin/providers/homepage_provider.dart';
import 'package:app_u_checkin/providers/outthem_provider.dart';
import 'package:app_u_checkin/values/app_assets.dart';
import 'package:app_u_checkin/values/app_colors.dart';
import 'package:app_u_checkin/values/app_styles.dart';
import 'package:app_u_checkin/widgets/app_box_title_info.dart';
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
    getDataTimeWorkStart();
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
          backgroundColor: AppColors.blueF1FAFF,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AppBoxTitleInformaition(
                      onTap: () {
                        setState(() {
                          context.read<BottomNavigationBarProvider>().setCurentIndex();
                        });
                      },
                      labelName: context.watch<OutThemeProvider>().user.name ?? '',
                      labelPosition: 'Position: ${context.read<OutThemeProvider>().user.position}',
                      image: AppAssets.avatar),
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
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (_) => PageCheckIn(user: context.read<OutThemeProvider>().user)),
                                    );
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
                                  },
                                  image: AppAssets.checkIn),
                              AppButton(
                                  label: 'Make day-off',
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (_) => const MakeDayOff()));
                                  },
                                  image: AppAssets.makeDayOff),
                              Container(
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
                                          color: AppColors.grey777E90,
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
                                                      color: !shortCut.isWeekend() ? Colors.white : AppColors.whiteF0F0F1,
                                                      borderRadius: const BorderRadius.all(Radius.circular(8))),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Center(
                                                            child: Text(
                                                          shortCut.getDateString(),
                                                          style: TextStyle(
                                                              fontFamily: FontFamily.bai_jamjuree, fontSize: 14.sp, color: AppColors.grey777E90),
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
                                                                      color: shortCut.checkWrongTimeCheckIn() ? AppColors.grey777E90 : Colors.red)),
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
                                                                      color: shortCut.checkWrongTimeCheckOut() ? AppColors.grey777E90 : Colors.red)),
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
                                                                color: shortCut.checkWrongTimeWorkTime() ? AppColors.grey777E90 : Colors.red),
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
            ),
          ),
        );
      },
    );
  }
}
