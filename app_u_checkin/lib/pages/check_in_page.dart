// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, use_build_context_synchronously
import 'package:app_u_checkin/providers/checkin_page_provider.dart';
import 'package:app_u_checkin/providers/homepage_provider.dart';
import 'package:app_u_checkin/providers/outthem_provider.dart';
import 'package:app_u_checkin/widgets/app_button_check.dart';
import 'package:app_u_checkin/widgets/app_handle_title.dart';
import 'package:app_u_checkin/widgets/app_title_colum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_u_checkin/model/user.dart';
import 'package:app_u_checkin/model/working_day.dart';
import 'package:app_u_checkin/values/app_assets.dart';
import 'package:app_u_checkin/values/app_colors.dart';
import 'package:app_u_checkin/values/app_styles.dart';
import 'package:provider/provider.dart';

class PageCheckIn extends StatefulWidget {
  User user;
  PageCheckIn({
    super.key,
    required this.user,
  });

  @override
  State<PageCheckIn> createState() => _PageCheckInState();
}

class _PageCheckInState extends State<PageCheckIn> {
  late PageController _pageController;
  DateTime systemTime() => DateTime.now();
  WorkingDay? valuePop;

  getDateTimeWork() async {
    await context.read<CheckInPageProvider>().getDateTimeWork(context);
    await _pageController.animateToPage(context.read<CheckInPageProvider>().currentIndex,
        duration: const Duration(milliseconds: 20), curve: Curves.bounceInOut);
    context.read<CheckInPageProvider>().monthTitle =
        context.read<CheckInPageProvider>().dataMonth[context.read<CheckInPageProvider>().currentIndex].getMonthTitle();
  }

  handlePreviousButtonTapped() async {
    context.read<CheckInPageProvider>().currentIndex--;
    if (context.read<CheckInPageProvider>().currentIndex <= 0) {
      context.read<CheckInPageProvider>().getHandlePreviousButton();
    } else {
      _pageController.animateToPage(context.read<CheckInPageProvider>().currentIndex,
          duration: const Duration(milliseconds: 20), curve: Curves.bounceInOut);
    }
  }

  handleNextButtonTapped() async {
    context.read<CheckInPageProvider>().currentIndex++;
    context.read<CheckInPageProvider>().getHandleNextButton();
    _pageController.animateToPage(context.read<CheckInPageProvider>().currentIndex,
        duration: const Duration(milliseconds: 20), curve: Curves.bounceInOut);
  }

  @override
  void initState() {
    super.initState();
    getDateTimeWork();
    _pageController = PageController(initialPage: context.read<CheckInPageProvider>().currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CheckInPageProvider>(
      builder: (BuildContext context, checkIn, _) {
        return Scaffold(
          appBar: AppBar(
            shadowColor: Colors.black12,
            backgroundColor: Colors.white,
            title: Text(
              'Check in',
              style: TextStyle(fontFamily: FontFamily.beVietnamPro, fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            leading: InkWell(
              onTap: () async {
                Navigator.pop(context);
                await context.read<HomePageProvider>().getDateTimeWork(context);
              },
              child: Image.asset(AppAssets.leftArrow),
            ),
          ),
          body: Container(
            color: AppColors.blueF1FAFF,
            child: Padding(
              padding: EdgeInsets.all(16.h),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Your puch in table',
                      style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 16.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Expanded(
                      child: Column(
                    children: [
                      AppHandleTitle(
                          label: checkIn.monthTitle,
                          imageRight: AppAssets.rightArrow,
                          imageLeft: AppAssets.leftArrow,
                          onTapRight: () {
                            handleNextButtonTapped();
                            checkIn.doMonthState();
                          },
                          onTapLeft: () {
                            handlePreviousButtonTapped();
                            checkIn.doMonthState();
                          }),
                      SizedBox(
                        height: 12.h,
                      ),
                      const AppTitleIdie(colum1: 'Date', colum2: 'Check in', colum3: 'Check out', colum4: 'Work time'),
                      SizedBox(
                        height: 12.h,
                      ),
                      Expanded(
                        child: PageView.builder(
                            controller: _pageController,
                            onPageChanged: (i) {
                              setState(() {
                                checkIn.currentIndex = i;
                              });
                            },
                            itemCount: checkIn.dataMonth.length,
                            itemBuilder: (context, i) {
                              return ListView.separated(
                                  padding: EdgeInsets.only(top: 0.h),
                                  itemCount: checkIn.dataMonth[i].dayOfWeek.length,
                                  separatorBuilder: (context, index) => SizedBox(
                                        height: 8.h,
                                      ),
                                  itemBuilder: (context, index) {
                                    var shortCut = checkIn.dataMonth[i].dayOfWeek[index];
                                    return Container(
                                        width: 358.w,
                                        height: 34.h,
                                        decoration: BoxDecoration(
                                            color: !shortCut.isWeekend() ? Colors.white : AppColors.whiteF0F0F1,
                                            borderRadius: const BorderRadius.all(Radius.circular(8))),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Center(
                                                  child: Text(
                                                shortCut.getDateString(),
                                                style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 14.sp, color: AppColors.grey777E90),
                                              )),
                                            ),
                                            ButtonCheck(
                                                checkVisibility: shortCut.checkinAvailable(),
                                                onTap: () async {
                                                  setState(() {
                                                    shortCut.checkin = systemTime();
                                                  });
                                                  await context.read<OutThemeProvider>().saveDataInLocalCheckIn(shortCut, context);
                                                },
                                                label: 'Check in',
                                                checkColor: shortCut.checkWrongTimeCheckIn(),
                                                checkTime: shortCut.checkinTimeString()),
                                            Expanded(
                                              child: SizedBox(
                                                height: 34.h,
                                                width: 83.w,
                                                child: Visibility(
                                                  visible: shortCut.checkoutAvailable(),
                                                  replacement: Center(
                                                    child: Text(shortCut.checkoutTimeString(),
                                                        style: TextStyle(
                                                            fontFamily: FontFamily.bai_jamjuree,
                                                            fontSize: 14.sp,
                                                            color: shortCut.checkWrongTimeCheckOut() ? AppColors.grey777E90 : Colors.red)),
                                                  ),
                                                  child: Center(
                                                    child: Container(
                                                      alignment: Alignment.center,
                                                      height: 22.h,
                                                      width: 64.w,
                                                      decoration: BoxDecoration(
                                                          color: shortCut.checkin != null ? AppColors.main : Colors.grey,
                                                          borderRadius: BorderRadius.all(Radius.circular(4.r))),
                                                      child: InkWell(
                                                        onTap: shortCut.checkin != null
                                                            ? () async {
                                                                setState(() {
                                                                  shortCut.checkout = systemTime();
                                                                });

                                                                await context.read<OutThemeProvider>().saveDataInLocalCheckIn(shortCut, context);
                                                              }
                                                            : null,
                                                        child: Text(
                                                          'Check out',
                                                          style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 12.sp, color: Colors.white),
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
                  ))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

extension Ex on double {
  double toPrecision(int n) => double.parse(toStringAsFixed(n));
}
