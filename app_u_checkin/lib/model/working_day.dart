import 'package:intl/intl.dart';

class WorkingDay {
  DateTime? date;
  String? checkin;
  String? checkout;
  double? workTime;

  WorkingDay({this.date, this.checkin, this.checkout, this.workTime});

  String getDateString() {
    if (date != null) {
      return DateFormat('d MMM').format(date!);
    }
    return "";
  }

  bool isWeekend() {
    if (date != null) {
      return date!.weekday < DateTime.saturday;
    }
    return false;
  }
}
