// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, prefer_const_constructors_in_immutables
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:app_u_checkin/values/app_colors.dart';
import 'package:app_u_checkin/values/app_styles.dart';

class CalendarBottom extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  DateTime? selectedDate;
  final OnDaySelected? onDaySelected;
  final String hintText;

  CalendarBottom({
    super.key,
    required this.controller,
    required this.selectedDate,
    required this.hintText,
    required this.onDaySelected,
    required this.onChanged,
  });

  @override
  State<CalendarBottom> createState() => _CalendarBottomState();
}

class _CalendarBottomState extends State<CalendarBottom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
      height: 48.h,
      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8.r)), color: AppColors.login),
      child: TextFormField(
        onChanged: widget.onChanged,
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: widget.hintText,
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
                return SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(bottom: 20.h),
                    color: Colors.white,
                    child: TableCalendar(
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
                        return isSameDay(widget.selectedDate, date);
                      },
                      onDaySelected: widget.onDaySelected,
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
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
