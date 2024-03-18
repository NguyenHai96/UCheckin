import 'package:app_u_checkin/model/working_day.dart';

class WorkingWeek {
  List<WorkingDay> dayOfWeek = [];
  String? weekTilte;

  WorkingWeek({required this.dayOfWeek, this.weekTilte});
}
