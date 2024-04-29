// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:app_u_checkin/providers/input_profile_provider.dart';
import 'package:app_u_checkin/values/app_colors.dart';
import 'package:app_u_checkin/values/app_styles.dart';
import 'package:app_u_checkin/widgets/app_calendar.dart';
import 'package:app_u_checkin/widgets/app_inputprofile_inputtext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, InputProfileProvider inputInfo, _) {
        return Scaffold(
          backgroundColor: AppColors.blueF1FAFF,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 43.w),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 68.h),
                  child: Container(
                    width: 304.w,
                    // height: 568.h,
                    color: Colors.white,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 12.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Your profile',
                              style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontWeight: FontWeight.bold, fontSize: 16.sp),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        SizedBox(
                          // height: 440.h,
                          width: 272.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'You need to input information to coutinue',
                                    style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 13.sp, color: AppColors.grey5E5F60),
                                  )),
                              SizedBox(
                                height: 12.h,
                              ),
                              AppBoxInputProfileInputText(controller: inputInfo.nameController, label: 'Name'),
                              SizedBox(
                                height: 14.h,
                              ),
                              AppBoxInputProfileInputText(controller: inputInfo.englishNameController, label: 'English Name'),
                              SizedBox(
                                height: 15.h,
                              ),
                              Text(
                                'DoB',
                                style: TextStyle(
                                    fontFamily: FontFamily.bai_jamjuree, fontSize: 13.sp, color: AppColors.main, fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 4.h),
                                child: CalendarBottom(
                                  controller: inputInfo.date,
                                  selectedDate: inputInfo.selectedDate,
                                  hintText: 'dd/MM/yyyy',
                                  onDaySelected: (date, focusedDay) {
                                    setState(() {
                                      inputInfo.selectedDate = date;
                                      inputInfo.date.text = DateFormat('dd/MM/yyyy').format(inputInfo.selectedDate!);
                                    });
                                    Navigator.pop(context);
                                  },
                                  onChanged: (String value) {},
                                ),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              AppBoxInputProfileInputText(controller: inputInfo.positionController, label: 'Your position'),
                              SizedBox(
                                height: 15.h,
                              ),
                              Text(
                                'Your team',
                                style: TextStyle(
                                    fontFamily: FontFamily.bai_jamjuree, fontSize: 13.sp, color: AppColors.main, fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 4.h),
                                child: Container(
                                  // height: 48.h,
                                  width: 272.w,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8.r)), color: AppColors.blueF1FAFF),
                                  child: DropdownButtonFormField<String>(
                                    icon: const Icon(Icons.arrow_drop_down_rounded),
                                    hint: const Text('Select'),
                                    onChanged: (String? value) {
                                      setState(() {
                                        inputInfo.dropdownValue = value!;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      constraints: const BoxConstraints(),
                                      border: InputBorder.none,
                                      fillColor: inputInfo.colorDropDownValue(inputInfo.dropdownValue),
                                      filled: true,
                                    ),
                                    items: inputInfo.list.map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem(
                                          value: value,
                                          child: Container(
                                              alignment: Alignment.centerLeft,
                                              padding: EdgeInsets.only(left: 10.w),
                                              height: 48.h,
                                              decoration: BoxDecoration(
                                                color: inputInfo.colorDropDownValue(value),
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
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        InkWell(
                          onTap: () {
                            inputInfo.saveDataAndNavigator(context);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 36.h,
                            width: 136.w,
                            decoration: BoxDecoration(color: AppColors.main, borderRadius: BorderRadius.all(Radius.circular(12.r))),
                            child: Text(
                              'OK',
                              style:
                                  TextStyle(fontFamily: FontFamily.beVietnamPro, fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12.h,
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
