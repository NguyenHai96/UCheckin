import 'package:app_u_checkin/pages/make_day_off.dart';
import 'package:intl/intl.dart';

class DayOff {
  String? type;
  DateTime? offFrom;
  DateTime? offTo;
  String? description;
  int? numberDayOff;
  bool? _isStatus;

  DayOff({this.type, this.offFrom, this.offTo, this.description, this.numberDayOff});

  factory DayOff.fromJson(Map<String, dynamic> json) {
    String offFromString;
    if (json['offFrom'] != null) {
      offFromString = json['offFrom'] as String;
    } else {
      offFromString = '';
    }
    String offToString;
    if (json['offTo'] != null) {
      offToString = json['offTo'] as String;
    } else {
      offToString = '';
    }
    DateTime? checkOffFrom;
    DateTime? checkOffTo;
    if (offFromString != null && offFromString != "" && offFromString != "null") {
      checkOffFrom = DateFormat("yyyy-MM-dd hh:mm").parse(offFromString);
    }
    if (offToString != null && offToString != "" && offToString != "null") {
      checkOffTo = DateFormat("yyyy-MM-dd hh:mm").parse(offToString);
    }

    return DayOff(type: json['type'], offFrom: checkOffFrom, offTo: checkOffTo, description: json['description'], numberDayOff: json['numberDayOff']);
  }

  Map<String, dynamic> toJson() {
    return {'type': type, 'offFrom': offFrom.toString(), 'offTo': offTo.toString(), 'description': description, 'numberDayOff': numberDayOff};
  }

  int getAnnualLeaveNumber() {
    if (offTo != null && offFrom != null && type == 'Annual leave') {
      DateTime? fromDate = offFrom;
      DateTime? toDate = offTo;
      int annual = 0;
      while (toDate!.difference(fromDate!).inDays >= 0) {
        fromDate = fromDate.add(const Duration(days: 1));
        if (fromDate.weekday != DateTime.saturday && fromDate.weekday != DateTime.sunday) {
          annual++;
        }
      }

      return annual;
    }
    return 0;
  }

  String textTitle() {
    String titleYear = '';
    if (offFrom != null) {
      titleYear = DateFormat("yyyy").format(offFrom!);
    }
    return titleYear;
  }

  String dateString() {
    String dateOff = '';
    if (offFrom != null && offTo != null) {
      if (offFrom != offTo) {
        dateOff = '${offFrom!.day} - ${DateFormat("dd MMM").format(offTo!)}';
        return dateOff;
      } else {
        dateOff = '${DateFormat("dd MMM").format(offFrom!)}';
      }
    }
    return dateOff;
  }
}
