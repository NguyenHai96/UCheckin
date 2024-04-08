// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'dart:convert';

import 'package:app_u_checkin/model/dayoff.dart';
import 'package:app_u_checkin/page/day_off_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:app_u_checkin/cache/cache_sharepreferences.dart';
import 'package:app_u_checkin/model/user.dart';
import 'package:app_u_checkin/values/app_assets.dart';
import 'package:app_u_checkin/values/app_colors.dart';
import 'package:app_u_checkin/values/app_styles.dart';

class MakeDayOff extends StatefulWidget {
  User user;
  MakeDayOff({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<MakeDayOff> createState() => _MakeDayOffState();
}

class _MakeDayOffState extends State<MakeDayOff> {
  TextEditingController _dateFromControler = TextEditingController();
  TextEditingController _dateToControler = TextEditingController();
  TextEditingController _descriptionControler = TextEditingController();
  List<String> list = <String>['Annual leave', 'Sick leave', 'Wedding leave', 'Meternity leave', 'Other'];
  String dropdownValue = '';
  bool _isActiveSave = false;
  DateTime? _selectedFormDate;
  DateTime? _selectedToDate;
  DayOff dayoff = DayOff();

  int annualLeave = 0;

  getAnnualLeaveStart() async {
    List<DayOff> listDayOff = await NPreferences().getListDataDayOff(widget.user.dayOff.toString());
    int restDayOff = 12;
    for (int i = 0; i < listDayOff.length; i++) {
      restDayOff = restDayOff - (listDayOff[i].getAnnualLeaveNumber());
    }
    if (restDayOff > 0) {
      setState(() {
        annualLeave = restDayOff;
      });
    }
  }

  int getNumberDayOff() {
    int annual = 1;
    if (_selectedFormDate != null && _selectedToDate != null) {
      DateTime? fromDate = _selectedFormDate;
      DateTime? toDate = _selectedToDate;
      while (toDate!.difference(fromDate!).inDays > 0) {
        print(fromDate.difference(fromDate).inDays);
        fromDate = fromDate.add(Duration(days: 1));
        if (fromDate.weekday != DateTime.saturday && fromDate.weekday != DateTime.sunday) {
          annual++;
        }
      }
    }
    return annual;
  }

  getAnnualLeaveState() {
    if (dropdownValue == 'Annual leave') {
      int annual = 1;
      if (annualLeave > 0 && _selectedFormDate != null && _selectedToDate != null) {
        DateTime? fromDate = _selectedFormDate;
        DateTime? toDate = _selectedToDate;
        while (toDate!.difference(fromDate!).inDays > 0) {
          print(fromDate.difference(fromDate).inDays);
          fromDate = fromDate.add(Duration(days: 1));
          if (fromDate.weekday != DateTime.saturday && fromDate.weekday != DateTime.sunday) {
            annual++;
          }
        }
        // int newAnnual = annualLeave - annual;
        // setState(() {
        //   annualLeave = newAnnual;
        // });
        if (annual >= annualLeave) {
          setState(() {
            annualLeave = 0;
          });
        } else {
          int newAnnual = annualLeave - annual;
          setState(() {
            annualLeave = newAnnual;
          });
        }
      }
    }
  }

  bool _checkSaveDayOff() {
    if (dropdownValue.isNotEmpty && _dateFromControler.text.isNotEmpty && _dateToControler.text.isNotEmpty && _descriptionControler.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAnnualLeaveStart();
  }

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
                            _isActiveSave = _checkSaveDayOff();
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
                        onChanged: (value) {
                          setState(() {
                            _isActiveSave = _checkSaveDayOff();
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Select date',
                          suffixIcon: Icon(
                            Icons.calendar_month_rounded,
                          ),
                          suffixStyle: TextStyle(fontSize: 16.sp, fontFamily: FontFamily.bai_jamjuree),
                          border: InputBorder.none,
                        ),
                        onTap: () async {
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  height: double.maxFinite,
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      TableCalendar(
                                        firstDay: DateTime(2000),
                                        lastDay: DateTime(2050),
                                        focusedDay: DateTime.now(),
                                        availableCalendarFormats: {CalendarFormat.month: 'Month'},
                                        calendarStyle: CalendarStyle(
                                          selectedDecoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                                          todayDecoration: BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
                                        ),
                                        selectedDayPredicate: (date) {
                                          return isSameDay(_selectedFormDate, date);
                                        },
                                        onDaySelected: (date, focusedDay) {
                                          setState(() {
                                            _selectedFormDate = date;
                                            _dateFromControler.text = DateFormat('dd/MM/yyyy').format(_selectedFormDate!);
                                            print('_selectedDate ->>>> ${_selectedFormDate}');
                                          });
                                          Navigator.pop(context);
                                        },
                                        calendarBuilders: CalendarBuilders(
                                          headerTitleBuilder: (context, date) => Center(
                                            child: Text(
                                              DateFormat('MMM yyyy').format(date),
                                              style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 14.sp, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          selectedBuilder: (context, date, _) => Container(
                                            decoration: BoxDecoration(color: AppColors.main, shape: BoxShape.circle),
                                            child: Center(
                                              child: Text(
                                                date.day.toString(),
                                                style: TextStyle(color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              });
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
                        onChanged: (value) {
                          _isActiveSave = _checkSaveDayOff();
                        },
                        decoration: InputDecoration(
                          hintText: 'Select date',
                          suffixIcon: Icon(
                            Icons.calendar_month_rounded,
                          ),
                          suffixStyle: TextStyle(fontSize: 16.sp, fontFamily: FontFamily.bai_jamjuree),
                          border: InputBorder.none,
                        ),
                        onTap: () async {
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  height: double.maxFinite,
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      TableCalendar(
                                        firstDay: DateTime(2000),
                                        lastDay: DateTime(2050),
                                        focusedDay: DateTime.now(),
                                        availableCalendarFormats: {CalendarFormat.month: 'Month'},
                                        calendarStyle: CalendarStyle(
                                          selectedDecoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                                          todayDecoration: BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
                                        ),
                                        selectedDayPredicate: (date) {
                                          return isSameDay(_selectedToDate, date);
                                        },
                                        onDaySelected: (date, focusedDay) {
                                          setState(() {
                                            _selectedToDate = date;
                                            _dateToControler.text = DateFormat('dd/MM/yyyy').format(_selectedToDate!);
                                            print(_selectedToDate);
                                            print(getNumberDayOff());
                                            getAnnualLeaveState();
                                          });
                                          Navigator.pop(context);
                                        },
                                        calendarBuilders: CalendarBuilders(
                                          headerTitleBuilder: (context, date) => Center(
                                            child: Text(
                                              DateFormat('MMM yyyy').format(date),
                                              style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 14.sp, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          selectedBuilder: (context, date, _) => Container(
                                            decoration: BoxDecoration(color: AppColors.main, shape: BoxShape.circle),
                                            child: Center(
                                              child: Text(
                                                date.day.toString(),
                                                style: TextStyle(color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              });
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
                      child: Text('Annual leave : ${annualLeave}',
                          style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 14.sp, color: Colors.grey, fontWeight: FontWeight.bold)),
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
                        controller: _descriptionControler,
                        onChanged: (value) {
                          setState(() {
                            _isActiveSave = _checkSaveDayOff();
                          });
                        },
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
                      onTap: _isActiveSave
                          ? () async {
                              List<DayOff> listDayOff = await NPreferences().getListDataDayOff(widget.user.dayOff.toString());
                              setState(() {
                                dayoff.type = dropdownValue;
                                dayoff.offFrom = _selectedFormDate;
                                dayoff.offTo = _selectedToDate;
                                dayoff.description = _descriptionControler.text;
                                dayoff.numberDayOff = getNumberDayOff();
                              });
                              listDayOff.add(dayoff);
                              List<String> newDayOffJson = listDayOff.map((e) => jsonEncode(e.toJson())).toList();
                              await NPreferences().saveData(widget.user.dayOff.toString(), newDayOffJson);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => DayOffHomePage(
                                            user: widget.user,
                                          )));

                              print('asdadadadas');
                            }
                          : null,
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
