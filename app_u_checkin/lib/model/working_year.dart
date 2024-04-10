// ignore_for_file: empty_constructor_bodies

import 'package:app_u_checkin/model/dayoff.dart';
import 'package:app_u_checkin/model/working_day.dart';
import 'package:intl/intl.dart';

class WorkingYear {
  List<DayOff> dayOff = [];

  WorkingYear({required this.dayOff});
  WorkingYear.init() {}
}
