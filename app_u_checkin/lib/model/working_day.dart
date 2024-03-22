import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WorkingDay {
  DateTime? date;
  DateTime? checkin;
  DateTime? checkout;

  WorkingDay({this.date, this.checkin, this.checkout});

  factory WorkingDay.fromJson(Map<String, dynamic> json) {
    return WorkingDay(
        date: json['name'] as DateTime,
        checkin: json['checkin'] as DateTime,
        checkout: json['checkout'] as DateTime);
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'checkin': checkin,
      'checkout': checkout,
    };
  }

  DateTime systemTime() => DateTime.now();

  String getDateString() {
    if (date != null) {
      return DateFormat('d MMM').format(date!);
    }
    return "";
  }

  bool isWeekend() {
    if (date != null) {
      return date!.weekday >= DateTime.saturday;
    }
    return false;
  }

  bool checkinAvailable() {
    if (checkin == null) {
      return isToday() && !isWeekend();
    }
    return false;
  }

  bool checkoutAvailable() {
    if (checkout == null) {
      return isToday() && !isWeekend();
    }
    return false;
  }

  bool isToday() {
    var now = DateTime.now();
    if (date != null) {
      if (getDateFormater(now, 'yyyy-MM-dd') ==
          getDateFormater(date!, 'yyyy-MM-dd')) {}
      return getDateFormater(now, 'yyyy-MM-dd') ==
          getDateFormater(date!, 'yyyy-MM-dd');
    }
    return false;
  }

  String checkinTimeString() {
    if (checkin != null) {
      return getTimeString(checkin!);
    }
    return "";
  }

  String checkoutTimeString() {
    if (checkout != null) {
      return getTimeString(checkout!);
    }
    return "";
  }

  String getTimeString(DateTime time) {
    String formattedTime = DateFormat('HH:mm').format(time);
    return formattedTime;
  }

  String getDateFormater(DateTime time, String format) {
    String formattedTime = DateFormat(format).format(time);
    return formattedTime;
  }

  double resultWorkTime() {
    if (checkin != null && checkout != null) {
      int startTime = (checkin!.hour * 60) + checkin!.minute;
      int endTime = (checkout!.hour * 60) + checkout!.minute;
      var result = (endTime - startTime) / 60 - 1;
      print(result);
      return result.toPrecision(2);
    }
    return 0;
  }

  bool showWorkTime() {
    if (date != null &&
        !isWeekend() == true &&
        checkin != null &&
        checkout != null) {
      return true;
    }
    return false;
  }

  bool checkWrongTimeCheckIn() {
    if (checkin != null) {
      if (checkin!.hour > 8) {
        return false;
      } else {
        if (checkin!.hour < 8) {
          return true;
        } else {
          if (checkin!.minute < 35) {
            return true;
          } else {
            return false;
          }
        }
      }
    }
    return true;
  }

  bool checkWrongTimeCheckOut() {
    if (checkout != null) {
      if (checkout!.hour < 17) {
        return false;
      } else {
        if (checkout!.hour > 17) {
          return true;
        } else {
          if (checkout!.minute < 30) {
            return false;
          } else {
            return true;
          }
        }
      }
    }
    return true;
  }

  bool checkWrongTimeWorkTime() {
    if (resultWorkTime() < 8) {
      return false;
    }
    return true;
  }
}

// double convertString(String input) {
//   if (input != null) {
//     String firstHalf = input.substring(0, input.indexOf(':'));
//     String secHalf = input.substring(input.indexOf(':') + 1);

//     int hour = int.parse(firstHalf);
//     int min = int.parse(secHalf);

//     double output = hour + min / 60;

//     return output;
//   }
//   return 0;
// }

extension Ex on double {
  double toPrecision(int n) => double.parse(toStringAsFixed(n));
}
