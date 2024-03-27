import 'package:app_u_checkin/values/app_colors.dart';
import 'package:app_u_checkin/values/app_styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController _date = TextEditingController();
  List<String> list = <String>['BA / QC', 'UI UX Designer', 'Web Developer', 'Mobile Developer', 'HR', 'General manager', 'Other'];
  String dropdownValue = '';
  TextEditingController nameController = TextEditingController();
  TextEditingController englishNameController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController teamController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.login,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 43.w),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 68.h),
              child: Container(
                width: 304.w,
                height: 568.h,
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
                    Container(
                      height: 440.h,
                      width: 272.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              alignment: Alignment.center,
                              child: Text(
                                'You need to input information to coutinue',
                                style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 13.sp, color: AppColors.textBasic),
                              )),
                          SizedBox(
                            height: 12.h,
                          ),
                          Text(
                            'Name',
                            style:
                                TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 13.sp, color: AppColors.main, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 4.h),
                            child: Container(
                              padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
                              height: 48.h,
                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8.r)), color: AppColors.login),
                              child: TextFormField(
                                controller: nameController,
                                onChanged: (text) {
                                  setState(() {});
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter',
                                  suffixStyle: TextStyle(fontSize: 16.sp, fontFamily: FontFamily.bai_jamjuree),
                                  fillColor: AppColors.text,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 14.h,
                          ),
                          Text(
                            'English Name',
                            style:
                                TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 13.sp, color: AppColors.main, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 4.h),
                            child: Container(
                              padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
                              height: 48.h,
                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8.r)), color: AppColors.login),
                              child: TextFormField(
                                controller: englishNameController,
                                onChanged: (text) {
                                  setState(() {});
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter',
                                  suffixStyle: TextStyle(fontSize: 16.sp, fontFamily: FontFamily.bai_jamjuree),
                                  fillColor: AppColors.text,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Text(
                            'DoB',
                            style:
                                TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 13.sp, color: AppColors.main, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 4.h),
                            child: Container(
                              padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
                              height: 48.h,
                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8.r)), color: AppColors.login),
                              child: TextFormField(
                                controller: _date,
                                decoration: InputDecoration(
                                  hintText: 'Select date',
                                  suffixIcon: Icon(
                                    Icons.calendar_month_rounded,
                                  ),
                                  suffixStyle: TextStyle(fontSize: 16.sp, fontFamily: FontFamily.bai_jamjuree),
                                  border: InputBorder.none,
                                ),
                                onTap: () async {
                                  DateTime? pickeddate = await showDatePicker(context: context, firstDate: DateTime(1900), lastDate: DateTime(2100));
                                  if (pickeddate != null) {
                                    setState(() {
                                      _date.text = DateFormat('dd/MM/yyyy').format(pickeddate);
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Text(
                            'Your position',
                            style:
                                TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 13.sp, color: AppColors.main, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 4.h),
                            child: Container(
                              padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
                              height: 48.h,
                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8.r)), color: AppColors.login),
                              child: TextFormField(
                                controller: positionController,
                                onChanged: (text) {
                                  setState(() {});
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter',
                                  suffixStyle: TextStyle(fontSize: 16.sp, fontFamily: FontFamily.bai_jamjuree),
                                  fillColor: AppColors.text,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Text(
                            'Your team',
                            style:
                                TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 13.sp, color: AppColors.main, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 4.h),
                            child: Container(
                              height: 48.h,
                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8.r)), color: AppColors.login),
                              child: DropdownButtonFormField<String>(
                                icon: Icon(Icons.keyboard_arrow_down_rounded),
                                controller: teamController,
                                initialSelection: list.first,
                                onSelected: (String? value) {
                                  setState(() {
                                    dropdownValue = value!;
                                  });
                                },
                                dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
                                  return DropdownMenuEntry<String>(value: value, label: value);
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
                        print('asdadasd');
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 36.h,
                        width: 136.w,
                        decoration: BoxDecoration(color: AppColors.main, borderRadius: BorderRadius.all(Radius.circular(12.r))),
                        child: Text(
                          'OK',
                          style: TextStyle(fontFamily: FontFamily.beVietnamPro, fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.white),
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
  }
}
