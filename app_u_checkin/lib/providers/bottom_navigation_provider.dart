import 'package:app_u_checkin/pages/day_off_page.dart';
import 'package:app_u_checkin/pages/home_page.dart';
import 'package:app_u_checkin/pages/profile_page.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarProvider extends ChangeNotifier {
  int curentIndex = 0;
  final List<Widget> listScreen = <Widget>[const HomePage(), const DayOffHomePage(), const YourProFilePage()];
  void onItemTapped(int index) {
    curentIndex = index;
    notifyListeners();
  }

  setCurentIndex() {
    curentIndex = 2;
    notifyListeners();
  }

  setCurentIndexToDayOff() {
    curentIndex = 1;
    notifyListeners();
  }

  cleanBottomNavigatorBar() {
    curentIndex = 0;
    notifyListeners();
  }
}
