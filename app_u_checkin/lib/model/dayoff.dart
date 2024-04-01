import 'package:app_u_checkin/page/make_day_off.dart';
import 'package:intl/intl.dart';

class MakeDayOff {
  String? type;
  DateTime? offFrom;
  DateTime? offTo;
  String? description;
  int? annualLeave;

  MakeDayOff({this.type, this.offFrom, this.offTo, this.description, this.annualLeave});

  factory MakeDayOff.fromJson(Map<String, dynamic> json) {
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

    DateTime checkOffFrom = DateFormat("yyyy-MM-dd hh:mm").parse(offFromString);
    DateTime checkOffTo = DateFormat("yyyy-MM-dd hh:mm").parse(offToString);

    return MakeDayOff(
        type: json['type'] as String,
        offFrom: checkOffFrom,
        offTo: checkOffTo,
        description: json['description'] as String,
        annualLeave: json['annualLeave'] as int);
  }

  Map<String, dynamic> toJson() {
    return {'type': type, 'offFrom': offFrom.toString(), 'offTo': offTo.toString(), 'description': description, 'annualLeave': annualLeave};
  }
}
