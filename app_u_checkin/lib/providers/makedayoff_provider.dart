import 'package:app_u_checkin/cache/cache_sharepreferences.dart';
import 'package:app_u_checkin/model/dayoff.dart';
import 'package:app_u_checkin/providers/outthem_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MakeDayOffProvider extends ChangeNotifier {
  final TextEditingController dateFromControler = TextEditingController();
  final TextEditingController dateToControler = TextEditingController();
  final TextEditingController descriptionControler = TextEditingController();
  List<String> list = <String>['Annual leave', 'Sick leave', 'Wedding leave', 'Meternity leave', 'Other'];
  String dropdownValue = '';
  bool isActiveSave = false;
  DateTime? selectedFormDate;
  DateTime? selectedToDate;
  DayOff dayoff = DayOff();

  int annualLeave = 0;

  getNumberDayOffAnnual(BuildContext context) async {
    List<DayOff> listDayOff = await NPreferences().getListDataDayOff(context.read<OutThemeProvider>().user.dayOff.toString());
    int restDayOff = 12;
    for (int i = 0; i < listDayOff.length; i++) {
      restDayOff = restDayOff - (listDayOff[i].getAnnualLeaveNumber());
    }
    notifyListeners();
    return restDayOff;
  }

  getAnnualLeaveStart(BuildContext context) async {
    int restDayOff = await getNumberDayOffAnnual(context);
    if (restDayOff > 0) {
      annualLeave = restDayOff;
    }
    notifyListeners();
  }

  int getNumberDayOff() {
    int annual = 1;
    if (selectedFormDate != null && selectedToDate != null) {
      DateTime? fromDate = selectedFormDate;
      DateTime? toDate = selectedToDate;
      while (toDate!.difference(fromDate!).inDays > 0) {
        fromDate = fromDate.add(const Duration(days: 1));
        if (fromDate.weekday != DateTime.saturday && fromDate.weekday != DateTime.sunday) {
          annual++;
        }
      }
    }
    return annual;
  }

  getAnnualLeaveState(BuildContext context) async {
    int restDayOff = await getNumberDayOffAnnual(context);
    if (dropdownValue == 'Annual leave' && restDayOff > 0) {
      int numberDayOff = getNumberDayOff();
      if (numberDayOff >= restDayOff) {
        annualLeave = 0;
      } else {
        int newAnnual = restDayOff - numberDayOff;
        annualLeave = newAnnual;
      }
    }
  }

  bool checkSaveDayOff() {
    if (dropdownValue.isNotEmpty && dateFromControler.text.isNotEmpty && dateToControler.text.isNotEmpty && descriptionControler.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  chooseDayOffStart(DateTime date, BuildContext context) {
    selectedFormDate = date;
    dateFromControler.text = DateFormat('dd/MM/yyyy').format(selectedFormDate!);
    dateToControler.text = DateFormat('dd/MM/yyyy').format(selectedFormDate!);
    selectedToDate = selectedFormDate;
    getAnnualLeaveState(context);
    Navigator.pop(context);
    notifyListeners();
  }

  chooseDayOffEnd(DateTime date, BuildContext context) {
    selectedToDate = date;
    dateToControler.text = DateFormat('dd/MM/yyyy').format(selectedToDate!);
    getAnnualLeaveState(context);
    Navigator.pop(context);
    notifyListeners();
  }

  bool isDate(String input, String format) {
    try {
      final DateTime d = DateFormat(format).parseStrict(input);
      return true;
    } catch (e) {
      return false;
    }
  }

  inputValueFrom(String value, BuildContext context) {
    if (value != '' && isDate(value, "dd/MM/yyyy")) {
      selectedFormDate = DateFormat('dd/MM/yyyy').parse(value);
      dateFromControler.text = DateFormat('dd/MM/yyyy').format(selectedFormDate!);
      dateToControler.text = DateFormat('dd/MM/yyyy').format(selectedFormDate!);
      selectedToDate = selectedFormDate;
      getAnnualLeaveState(context);
    }
    notifyListeners();
  }

  inputValueTo(String value, BuildContext context) {
    if (value != '' && isDate(value, "dd/MM/yyyy")) {
      selectedToDate = DateFormat("dd/MM/yyyy").parse(value);
      dateToControler.text = DateFormat('dd/MM/yyyy').format(selectedToDate!);
      getAnnualLeaveState(context);
    }
    notifyListeners();
  }

  cleanData() {
    dateFromControler.text = '';
    dateToControler.text = '';
    descriptionControler.text = '';
    dropdownValue = '';
    notifyListeners();
  }
}
