import 'package:app_u_checkin/values/app_assets.dart';
import 'package:app_u_checkin/values/app_colors.dart';
import 'package:app_u_checkin/values/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class MakeDayOff extends StatefulWidget {
  const MakeDayOff({super.key});

  @override
  State<MakeDayOff> createState() => _MakeDayOffState();
}

class _MakeDayOffState extends State<MakeDayOff> {
  TextEditingController typeControler = TextEditingController();
  TextEditingController _dateFromControler = TextEditingController();
  TextEditingController _dateToControler = TextEditingController();
  TextEditingController descriptionControler = TextEditingController();
  List<String> list = <String>['Annual leave', 'Sick leave', 'Wedding leave', 'Meternity leave', 'Other'];
  String dropdownValue = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black12,
        backgroundColor: Colors.white,
        title: Text(
          'Make day-off',
          style: TextStyle(fontFamily: FontFamily.beVietnamPro, fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset(AppAssets.leftArrow),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 16.h,
            ),
            Container(
              width: 272.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Type',
                    style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 14.sp, color: AppColors.main, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 4.h),
                    child: Container(
                      height: 48.h,
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8.r)), color: AppColors.login),
                      child: DropdownButtonFormField<String>(
                        icon: Icon(Icons.arrow_drop_down_rounded),
                        hint: Text('Select'),
                        onChanged: (String? value) {
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
                        decoration: InputDecoration(
                          constraints: const BoxConstraints(),
                          border: InputBorder.none,
                          fillColor: AppColors.login,
                          filled: true,
                        ),
                        items: list.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem(
                              value: value,
                              child: Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(left: 10.w),
                                  height: 48.h,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8.r))),
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
                    height: 16.h,
                  ),
                  Text(
                    'From',
                    style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 13.sp, color: AppColors.main, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 4.h),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
                      height: 48.h,
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8.r)), color: AppColors.login),
                      child: TextFormField(
                        controller: _dateFromControler,
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
                              _dateFromControler.text = DateFormat('dd/MM/yyyy').format(pickeddate);
                            });
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Text(
                    'To',
                    style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 13.sp, color: AppColors.main, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 4.h),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
                      height: 48.h,
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8.r)), color: AppColors.login),
                      child: TextFormField(
                        controller: _dateToControler,
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
                              _dateToControler.text = DateFormat('dd/MM/yyyy').format(pickeddate);
                            });
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Center(
                    child: Container(
                      height: 17.h,
                      width: 112.w,
                      child: Text('Annual leave : 12'),
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Text(
                    'Description',
                    style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 13.sp, color: AppColors.main, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 4.h),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
                      height: 88.h,
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8.r)), color: AppColors.login),
                      child: TextFormField(
                        controller: descriptionControler,
                        decoration: InputDecoration(
                          hintText: 'Enter',
                          suffixStyle: TextStyle(fontSize: 16.sp, fontFamily: FontFamily.bai_jamjuree),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        alignment: Alignment.center,
                        height: 36.h,
                        width: 136.w,
                        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(12.r)), color: AppColors.main),
                        child: Text(
                          'Save',
                          style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 14.sp, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
