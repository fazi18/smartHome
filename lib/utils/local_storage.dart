import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static saveDeviceAddress(String address) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    log(address);
    preferences.setString('device_address', address);
  }

  static getDeviceAddress() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('device_address');
  }

  static saveTheme(String name) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('theme_name', name);
  }

  static getTheme() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('theme_name');
  }
}
