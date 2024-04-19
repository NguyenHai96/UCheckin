// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, use_build_context_synchronously, unnecessary_brace_in_string_interps, unnecessary_const
import 'dart:convert';

import 'package:app_u_checkin/model/dayoff.dart';
import 'package:app_u_checkin/page/day_off_page.dart';
import 'package:app_u_checkin/providers/makedayoff_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:app_u_checkin/cache/cache_sharepreferences.dart';
import 'package:app_u_checkin/model/user.dart';
import 'package:app_u_checkin/values/app_assets.dart';
import 'package:app_u_checkin/values/app_colors.dart';
import 'package:app_u_checkin/values/app_styles.dart';

class MakeDayOff extends StatefulWidget {
  const MakeDayOff({
    super.key,
  });

  @override
  State<MakeDayOff> createState() => _MakeDayOffState();
}

class _MakeDayOffState extends State<MakeDayOff> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<MakeDayOffProvider>().getAnnualLeaveStart(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, MakeDayOffProvider dayoff, Widget? child) {
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
                SizedBox(
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
                          // height: 48.h,
                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8.r)), color: AppColors.login),
                          child: DropdownButtonFormField<String>(
                            icon: const Icon(Icons.arrow_drop_down_rounded),
                            hint: const Text('Select'),
                            onChanged: (String? value) {
                              setState(() {
                                dayoff.dropdownValue = value!;
                                dayoff.isActiveSave = dayoff.checkSaveDayOff();
                              });
                            },
                            decoration: const InputDecoration(
                              constraints: BoxConstraints(),
                              border: InputBorder.none,
                              fillColor: AppColors.login,
                              filled: true,
                            ),
                            items: dayoff.list.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem(
                                  value: value,
                                  child: Container(
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.only(left: 10.w),
                                      // height: 48.h,
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
                            controller: dayoff.dateFromControler,
                            onChanged: (value) {
                              setState(() {
                                dayoff.isActiveSave = dayoff.checkSaveDayOff();
                              });
                            },
                            decoration: InputDecoration(
                              hintText: 'Select date',
                              suffixIcon: const Icon(
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
                                      height: 410.h,
                                      color: Colors.white,
                                      child: Column(
                                        children: [
                                          TableCalendar(
                                            firstDay: DateTime(2000),
                                            lastDay: DateTime(2050),
                                            focusedDay: DateTime.now(),
                                            availableCalendarFormats: const {CalendarFormat.month: 'Month'},
                                            calendarStyle: const CalendarStyle(
                                                selectedDecoration: BoxDecoration(
                                                  color: Colors.blue,
                                                ),
                                                todayDecoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                                                todayTextStyle: TextStyle(color: Colors.blue, fontSize: 16)),
                                            selectedDayPredicate: (date) {
                                              return isSameDay(dayoff.selectedFormDate, date);
                                            },
                                            onDaySelected: (date, focusedDay) {
                                              dayoff.chooseDayOffStart(date, context);
                                              // setState(() {
                                              //   dayoff.selectedFormDate = date;
                                              //   dayoff.dateFromControler.text = DateFormat('dd/MM/yyyy').format(dayoff.selectedFormDate!);
                                              //   dayoff.dateToControler.text = DateFormat('dd/MM/yyyy').format(dayoff.selectedFormDate!);
                                              //   print('_selectedDate ->>>> ${dayoff.selectedFormDate}');
                                              //   dayoff.selectedToDate = dayoff.selectedFormDate;
                                              // });
                                              // dayoff.getAnnualLeaveState(context);
                                              // Navigator.pop(context);
                                            },
                                            calendarBuilders: CalendarBuilders(
                                              headerTitleBuilder: (context, date) => Center(
                                                child: Text(
                                                  DateFormat('MMM yyyy').format(date),
                                                  style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 14.sp, fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                              selectedBuilder: (context, date, _) => Center(
                                                child: Text(
                                                  date.day.toString(),
                                                  style: TextStyle(color: Colors.blue, fontSize: 15.sp),
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
                            controller: dayoff.dateToControler,
                            onChanged: (value) {
                              dayoff.isActiveSave = dayoff.checkSaveDayOff();
                            },
                            decoration: InputDecoration(
                              hintText: 'Select date',
                              suffixIcon: const Icon(
                                Icons.calendar_month_rounded,
                              ),
                              suffixStyle: TextStyle(fontSize: 16.sp, fontFamily: FontFamily.bai_jamjuree),
                              border: InputBorder.none,
                            ),
                            onTap: dayoff.dateToControler != null
                                ? () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Container(
                                            height: 410.h,
                                            color: Colors.white,
                                            child: Column(
                                              children: [
                                                TableCalendar(
                                                  firstDay: DateTime(2000),
                                                  lastDay: DateTime(2050),
                                                  focusedDay: DateTime.now(),
                                                  availableCalendarFormats: const {CalendarFormat.month: 'Month'},
                                                  calendarStyle: const CalendarStyle(
                                                      selectedDecoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                                                      todayDecoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                                                      todayTextStyle: TextStyle(color: Colors.blue, fontSize: 17)),
                                                  selectedDayPredicate: (date) {
                                                    return isSameDay(dayoff.selectedToDate, date);
                                                  },
                                                  onDaySelected: (date, focusedDay) {
                                                    dayoff.chooseDayOffEnd(date, context);
                                                    // setState(() {
                                                    //   dayoff.selectedToDate = date;
                                                    //   dayoff.dateToControler.text = DateFormat('dd/MM/yyyy').format(dayoff.selectedToDate!);
                                                    //   print("_selectedToDate ------->>>>>> ${dayoff.selectedToDate}");
                                                    //   print("getNumberDayOff()----->>> ${dayoff.getNumberDayOff()}");
                                                    // });
                                                    // dayoff.getAnnualLeaveState(context);
                                                    // Navigator.pop(context);
                                                  },
                                                  calendarBuilders: CalendarBuilders(
                                                    headerTitleBuilder: (context, date) => Center(
                                                      child: Text(
                                                        DateFormat('MMM yyyy').format(date),
                                                        style: TextStyle(
                                                            fontFamily: FontFamily.bai_jamjuree, fontSize: 14.sp, fontWeight: FontWeight.bold),
                                                      ),
                                                    ),
                                                    selectedBuilder: (context, date, _) => Center(
                                                      child: Text(
                                                        date.day.toString(),
                                                        style: const TextStyle(color: Colors.blue),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        });
                                  }
                                : () {
                                    setState(() {
                                      dayoff.selectedToDate = dayoff.selectedFormDate;
                                    });
                                  },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Center(
                        child: Text('Annual leave : ${dayoff.annualLeave}',
                            style: TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 14.sp, color: Colors.grey, fontWeight: FontWeight.bold)),
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
                            controller: dayoff.descriptionControler,
                            onChanged: (value) {
                              setState(() {
                                dayoff.isActiveSave = dayoff.checkSaveDayOff();
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
                          onTap: dayoff.isActiveSave
                              ? () async {
                                  await dayoff.saveDataAndNavigator(context);
                                  // List<DayOff> listDayOff = await NPreferences().getListDataDayOff(widget.user.dayOff.toString());
                                  // int numberDayOff = 0;
                                  // DateTime? fromDate = dayoff.selectedFormDate;
                                  // DateTime? toDate = dayoff.selectedFormDate;
                                  // if (toDate != null && fromDate != null) {
                                  //   while (toDate.difference(fromDate!).inDays > 0) {
                                  //     fromDate = fromDate.add(const Duration(days: 1));
                                  //     if (fromDate.weekday != DateTime.saturday && fromDate.weekday != DateTime.sunday) {
                                  //       numberDayOff++;
                                  //     }
                                  //   }
                                  // }
                                  // setState(() {
                                  //   dayoff.dayoff.type = dayoff.dropdownValue;
                                  //   dayoff.dayoff.offFrom = dayoff.selectedFormDate;
                                  //   dayoff.dayoff.offTo = dayoff.selectedToDate;
                                  //   dayoff.dayoff.description = dayoff.descriptionControler.text;
                                  //   dayoff.dayoff.numberDayOff = numberDayOff;
                                  // });
                                  // listDayOff.add(dayoff.dayoff);
                                  // List<String> newDayOffJson = listDayOff.map((e) => jsonEncode(e.toJson())).toList();
                                  // await NPreferences().saveData(widget.user.dayOff.toString(), newDayOffJson);
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (_) => DayOffHomePage(
                                  //               user: widget.user,
                                  //             )));
                                }
                              : null,
                          child: Container(
                            alignment: Alignment.center,
                            height: 36.h,
                            width: 136.w,
                            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(12.r)), color: AppColors.main),
                            child: Text(
                              'Save',
                              style:
                                  TextStyle(fontFamily: FontFamily.bai_jamjuree, fontSize: 14.sp, color: Colors.white, fontWeight: FontWeight.bold),
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
      },
    );
  }
}
