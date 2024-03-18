import 'package:app_u_checkin/model/working_day.dart';
import 'package:app_u_checkin/note/date_time.dart';
import 'package:intl/intl.dart';

class WorkingWeek {
  List<WorkingDay> dayOfWeek = [];

  WorkingWeek({required this.dayOfWeek});
  WorkingWeek.init() {}

  String getWeekTitle() {
    if (dayOfWeek.isNotEmpty && dayOfWeek.first.date != null) {
      String formattedMonthYear =
          DateFormat('MMMM yyyy').format(dayOfWeek.first.date!);
      String weektilte =
          'Week ${dayOfWeek.first.date?.weekOfMonth ?? 0} ${formattedMonthYear}';
      return weektilte;
    }
    return "";
  }
}
