// ignore_for_file: empty_constructor_bodies

import 'package:app_u_checkin/model/dayoff.dart';
import 'package:intl/intl.dart';

class WorkingYear {
  List<DayOff> dayOff = [];

  WorkingYear({required this.dayOff});
  WorkingYear.init() {}

  String getWeekTitle() {
    if (dayOff.isNotEmpty && dayOff.first.offFrom != null) {
      String formattedMonthYear = DateFormat('yyyy').format(dayOff.first.offFrom!);
      String weektilte = formattedMonthYear;
      return weektilte;
    }
    return DateTime.now().year.toString();
  }
}
