library npreferences;

import 'dart:convert';

import 'package:app_u_checkin/model/dayoff.dart';
import 'package:app_u_checkin/model/user.dart';
import 'package:app_u_checkin/model/working_day.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// This class for local storage using SharedPreferences
class NPreferences {
  // Create new Future ref to SharedPreferences instance
  final Future<SharedPreferences> preferences = SharedPreferences.getInstance();

  /// Save data with primary data types: String, List<String>, double, int, bool
  Future<bool> saveData<T>(String key, T value) async {
    // Get SharedPreferences ref
    final SharedPreferences ref = await preferences;
    // Delete if value is null
    if (value == null) {
      return ref.remove(key);
    }
    // With primary data type, save to local
    if (value is String) {
      return ref.setString(key, value);
    } else if (value is bool) {
      return ref.setBool(key, value);
    } else if (value is int) {
      return ref.setInt(key, value);
    } else if (value is double) {
      return ref.setDouble(key, value);
    } else if (value is List<String>) {
      return ref.setStringList(key, value);
    }
    // Default return false
    return false;
  }

  // Get data by key
  Future<T> getData<T>(String key) async {
    // Get SharedPreferences ref
    final SharedPreferences ref = await preferences;
    // Get data by key with cast to output data type
    if (ref != null) {
      return ref.get(key) as T;
    }
    return null as T;
  }

  Future<List<String>> getDataString<T>(String key) async {
    // Get SharedPreferences ref
    final SharedPreferences ref = await preferences;
    List<String> items = ref.getStringList(key) ?? [];

    // Get data by key with cast to output data type
    return items as List<String>;
  }

  Future<T> getDataWorkingDay<T>(String key) async {
    final SharedPreferences ref = await preferences;
    final newWorkingJson = ref.getString(key);

    if (newWorkingJson != null) {
      final newWokingObj = WorkingDay.fromJson(jsonDecode(newWorkingJson));
      return newWokingObj as T;
    }
    return null as T;
  }

  Future<T> getListDataWorkingDay<T>(String key) async {
    final SharedPreferences ref = await preferences;
    List<String> newListJson = ref.getStringList(key) ?? [];
    List<WorkingDay> items = [];
    if (newListJson != null) {
      for (dynamic item in newListJson) {
        items.add(WorkingDay.fromJson(jsonDecode(item)));
      }
      return items as T;
    }
    return null as T;
  }

  Future<T> getListDataDayOff<T>(String key) async {
    final SharedPreferences ref = await preferences;
    List<String> newListJson = ref.getStringList(key) ?? [];
    List<DayOff> items = [];
    if (newListJson != null) {
      for (dynamic item in newListJson) {
        items.add(DayOff.fromJson(jsonDecode(item)));
      }
      return items as T;
    }
    return null as T;
  }

  Future<T> getUser<T>(String key) async {
    final SharedPreferences ref = await preferences;
    final userJson = ref.getString(key);
    if (userJson != null) {
      final userObj = User.formJson(jsonDecode(userJson));
      return userObj as T;
    }
    return null as T;
  }

  // Clear all
  Future<bool> clear() async {
    // Get SharedPreferences ref
    final SharedPreferences ref = await preferences;
    // Clear all data
    return ref.clear();
  }
}
