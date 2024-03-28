import 'package:app_u_checkin/model/working_day.dart';
import 'package:intl/intl.dart';

class WorkingMonth {
  List<WorkingDay> dayOfWeek = [];

  WorkingMonth({required this.dayOfWeek});
  WorkingMonth.init() {}

  String getMonthTitle() {
    if (dayOfWeek.isNotEmpty && dayOfWeek.first.date != null) {
      String formattedMonthYear =
          DateFormat('MMMM yyyy').format(dayOfWeek.first.date!);
      String monthtilte = formattedMonthYear;
      return monthtilte;
    }
    return "";
  }
}
