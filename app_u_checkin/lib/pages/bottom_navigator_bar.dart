import 'package:app_u_checkin/providers/bottom_navigation_provider.dart';
import 'package:app_u_checkin/values/app_assets.dart';
import 'package:app_u_checkin/values/app_colors.dart';
import 'package:app_u_checkin/values/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class BottomNavigatorBar extends StatefulWidget {
  const BottomNavigatorBar({super.key});

  @override
  State<BottomNavigatorBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<BottomNavigatorBar> {
  final iconList = <String>[AppAssets.homeIcon, AppAssets.coffeeIcon, AppAssets.personIcon];
  final iconChoseList = <String>[
    AppAssets.choseHomeIcon,
    AppAssets.chosecoffeeIcon,
    AppAssets.choseProfileIcon,
  ];
  final textList = <String>['Home', 'Day Off', 'Profile'];

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, BottomNavigationBarProvider bottomBar, _) {
        return Scaffold(
            body: bottomBar.listScreen[bottomBar.curentIndex],
            bottomNavigationBar: PreferredSize(
              preferredSize: Size.fromHeight(64.h),
              child: AnimatedBottomNavigationBar.builder(
                activeIndex: bottomBar.curentIndex,
                onTap: (index) {
                  setState(() {
                    bottomBar.curentIndex = index;
                  });
                },
                splashColor: AppColors.main,
                gapWidth: 0.w,
                backgroundColor: Colors.white,
                itemCount: iconList.length,
                tabBuilder: (int index, bool isActive) {
                  return SizedBox(
                    width: 130.w,
                    height: 64.h,
                    child: Center(
                      child: Container(
                        height: 36.h,
                        width: 90.w,
                        decoration:
                            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8.r)), color: isActive ? AppColors.main : Colors.white),
                        alignment: Alignment.center,
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                          SizedBox(
                              height: 24.h,
                              width: 24.h,
                              child: Image.asset(
                                isActive ? iconChoseList[index] : iconList[index],
                                color: isActive ? Colors.white : AppColors.grey5E5F60,
                              )),
                          Visibility(
                              visible: isActive,
                              child: Text(
                                textList[index],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: FontFamily.bai_jamjuree,
                                  fontSize: 14.sp,
                                ),
                              ))
                        ]),
                      ),
                    ),
                  );
                },
                notchSmoothness: NotchSmoothness.verySmoothEdge,
              ),
            ));
      },
    );
  }
}
