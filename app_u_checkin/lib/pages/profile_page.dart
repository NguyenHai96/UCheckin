// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously, no_leading_underscores_for_local_identifiers, must_be_immutable

import 'package:app_u_checkin/cache/cache_sharepreferences.dart';
import 'package:app_u_checkin/pages/check_in_page.dart';
import 'package:app_u_checkin/providers/outthem_provider.dart';
import 'package:app_u_checkin/providers/profile_provider.dart';
import 'package:app_u_checkin/values/share_keys.dart';
import 'package:app_u_checkin/widgets/app_box_infoprofile.dart';
import 'package:app_u_checkin/widgets/app_calendar.dart';
import 'package:app_u_checkin/widgets/app_profile_inputtext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:app_u_checkin/pages/login_page.dart';
import 'package:app_u_checkin/values/app_assets.dart';
import 'package:app_u_checkin/values/app_colors.dart';
import 'package:app_u_checkin/values/app_styles.dart';
import 'package:provider/provider.dart';

class YourProFilePage extends StatefulWidget {
  const YourProFilePage({
    super.key,
  });

  @override
  State<YourProFilePage> createState() => _YourProFilePageState();
}

class _YourProFilePageState extends State<YourProFilePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ProfilePageProvider>().getAnnualLeaveStart(context);
    context.read<ProfilePageProvider>().getRateTimeFromUser(context);
    context.read<ProfilePageProvider>().getWorkTime(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfilePageProvider>(
      builder: (BuildContext context, ProfilePageProvider profile, _) {
        return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
                child: SingleChildScrollView(
              child: Container(
                color: AppColors.blueF1FAFF,
                padding: EdgeInsets.all(16.h),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            width: 20.h,
                            height: 20.h,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 71.h,
                                height: 71.h,
                                child: Image.asset(
                                  AppAssets.avatar,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              Text(
                                '${context.watch<OutThemeProvider>().user.name}',
                                style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 16.sp, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () async {
                              String logout = '';
                              await NPreferences().saveData(ShareKeys.checkLogin, logout);
                              profile.cleanData(context);
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => const LoginPage()),
                                (Route<dynamic> route) => false,
                              );
                            },
                            child: SizedBox(
                              width: 20.h,
                              child: const Icon(Icons.logout_sharp),
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 24.h),
                      child: SizedBox(
                        height: 141.h,
                        width: 342.w,
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                                top: 0,
                                left: 0,
                                child: AppBoxInfoProfile(image: AppAssets.home, info: '${profile.annualLeave}', label: 'Annual leaves')),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: AppBoxInfoProfile(image: AppAssets.time, info: '${profile.onTimeRate.toPrecision(2)}%', label: 'On-time rate'),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              child: AppBoxInfoProfile(image: AppAssets.work, info: '${profile.enoughWorkTime.toPrecision(2)}%', label: 'Work time'),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 24.h),
                      child: Container(
                        width: 338.w,
                        color: Colors.white,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 12.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Your profile',
                                    style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontWeight: FontWeight.bold, fontSize: 16.sp),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 24.h,
                            ),
                            SizedBox(
                              width: 272.w,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppProfileInputText(
                                      controller: profile.nameController, label: 'Name', hintText: '${context.read<OutThemeProvider>().user.name}'),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  AppProfileInputText(
                                      controller: profile.englishNameController,
                                      label: 'English Name',
                                      hintText: '${context.read<OutThemeProvider>().user.nameEnglish}'),
                                  Padding(
                                    padding: EdgeInsets.only(top: 16.h),
                                    child: Text(
                                      'DoB',
                                      style: TextStyle(
                                          fontFamily: FontFamily.bai_jamjuree, fontSize: 14.sp, color: AppColors.main, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 4.h),
                                    child: CalendarBottom(
                                      controller: profile.date,
                                      selectedDate: profile.selectedDate,
                                      hintText: '${context.read<OutThemeProvider>().user.dOB}',
                                      onDaySelected: (date, focusedDay) {
                                        setState(() {
                                          profile.selectedDate = date;
                                          profile.date.text = DateFormat('dd/MM/yyyy').format(profile.selectedDate!);
                                        });
                                        Navigator.pop(context);
                                      },
                                      onChanged: (value) {
                                        if (value != '') {
                                          profile.inputValueBOD(value, context);
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  AppProfileInputText(
                                      controller: profile.positionController,
                                      label: 'Your position',
                                      hintText: '${context.read<OutThemeProvider>().user.position}'),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  Text(
                                    'Your team',
                                    style: TextStyle(
                                        fontFamily: FontFamily.bai_jamjuree, fontSize: 14.sp, color: AppColors.main, fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 4.h),
                                    child: Container(
                                      width: 272.w,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(8.r)),
                                          color: profile.colorDropDownValue(context.read<OutThemeProvider>().user.team.toString())),
                                      child: DropdownButtonFormField<String>(
                                        icon: const Icon(Icons.arrow_drop_down_rounded),
                                        hint: Text('${context.read<OutThemeProvider>().user.team}'),
                                        onChanged: (String? value) {
                                          profile.dropdownValue = value!;
                                        },
                                        decoration: InputDecoration(
                                          constraints: const BoxConstraints(),
                                          border: InputBorder.none,
                                          fillColor: profile.colorDropDownValue(profile.dropdownValue),
                                          filled: true,
                                        ),
                                        items: profile.list.map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem(
                                              value: value,
                                              child: Container(
                                                  alignment: Alignment.centerLeft,
                                                  padding: EdgeInsets.only(left: 10.w),
                                                  height: 48.h,
                                                  decoration: BoxDecoration(
                                                    color: profile.colorDropDownValue(value),
                                                  ),
                                                  child: Text(
                                                    value,
                                                    style: TextStyle(
                                                      fontFamily: FontFamily.bai_jamjuree,
                                                      fontSize: 16.sp,
                                                    ),
                                                  )));
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 33.5.h,
                                  ),
                                  Center(
                                    child: InkWell(
                                      onTap: () {
                                        context.read<OutThemeProvider>().saveChangeInfoProfile(context);
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 36.h,
                                        width: 136.w,
                                        decoration: BoxDecoration(color: AppColors.main, borderRadius: BorderRadius.all(Radius.circular(12.r))),
                                        child: Text(
                                          'Edit',
                                          style: TextStyle(
                                              fontFamily: FontFamily.beVietnamPro, fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 12.h,
                                  ),
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
            )));
      },
    );
  }
}
