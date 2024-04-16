import 'package:intl/intl.dart';

class WorkingDay {
  DateTime? date;
  DateTime? checkin;
  DateTime? checkout;

  WorkingDay({this.date, this.checkin, this.checkout});

  factory WorkingDay.fromJson(Map<String, dynamic> json) {
    String dateString;
    if (json['date'] != null && json['date'] != 'null') {
      dateString = json['date'] as String;
    } else {
      dateString = '';
    }
    String checkinString;
    if (json['checkin'] != null && json['checkin'] != 'null') {
      checkinString = json['checkin'] as String;
    } else {
      checkinString = '';
    }
    String? checkoutString;

    if (json['checkout'] != null && json['checkout'] != 'null') {
      checkoutString = json['checkout'] as String;
    }

    DateTime? checkDate;
    if (dateString != null && dateString != "") {
      checkDate = DateFormat("yyyy-MM-dd hh:mm").parse(dateString);
    }

    DateTime? checkinDate;
    if (checkinString != null && checkinString != "") {
      checkinDate = DateFormat("yyyy-MM-dd hh:mm").parse(checkinString);
    }

    DateTime? checkoutDate;
    if (checkoutString != null) {
      checkoutDate = DateFormat("yyyy-MM-dd hh:mm").parse(checkoutString);
    }

    return WorkingDay(date: checkDate, checkin: checkinDate, checkout: checkoutDate);
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toString(),
      'checkin': checkin.toString(),
      'checkout': checkout.toString(),
    };
  }

  DateTime systemTime() => DateTime.now();

  DateTime getDataDateTime(String date) {
    return DateTime.parse(date);
  }

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
      if (getDateFormater(now, 'yyyy-MM-dd') == getDateFormater(date!, 'yyyy-MM-dd')) {}
      return getDateFormater(now, 'yyyy-MM-dd') == getDateFormater(date!, 'yyyy-MM-dd');
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
      int result = 0;
      if (checkin!.hour > 7 && checkin!.hour < 13 && checkout!.hour > 12) {
        result = checkout!.difference(checkin!).inMinutes - 60;
        if (checkout!.hour > 17 && checkout!.minute > 30) {
          DateTime setCheckOut = checkout!.copyWith(hour: 17, minute: 30);
          result = setCheckOut.difference(checkin!).inMinutes - 60;
        }
      } else {
        if (checkin!.hour > 7 && checkout!.hour < 12) {
          result = checkout!.difference(checkin!).inMinutes;
        } else {
          if (checkin!.hour > 12 && checkout!.hour > 12) {
            result = checkout!.difference(checkin!).inMinutes;
          }
        }
      }
      int hour = result ~/ 60;
      int residue = result % 60;
      double minutes;
      if (residue > -1 && residue < 16) {
        minutes = 0.0;
      } else {
        if (residue > 15 && residue < 31) {
          minutes = 0.25;
        } else {
          if (residue > 30 && residue < 46) {
            minutes = 0.5;
          } else {
            minutes = 0.75;
          }
        }
      }
      double workTime = hour + minutes;
      return workTime;
    }
    return 0;
  }

  bool checkEnoughWorkTime() {
    if (resultWorkTime() >= 8) {
      return true;
    }
    return false;
  }

  bool showWorkTime() {
    if (date != null && !isWeekend() == true && checkin != null && checkout != null) {
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
