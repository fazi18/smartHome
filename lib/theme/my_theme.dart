import 'package:flutter/material.dart';
import 'package:smart_home/theme/color/colors.dart';

enum MyThemeKeys { black, blue, orange }

class MyThemes {
  static final ThemeData blueTheme = ThemeData(
    primaryColor: const Color(0xff467ff2),
    primaryColorLight: const Color(0xff467ff2).withOpacity(.3),
    // appBarTheme: const AppBarTheme(
    //   color: Color(0xff171d49),
    // ),
    // textSelectionTheme: const TextSelectionThemeData(
    //   selectionColor: Colors.grey,
    //   cursorColor: Color(0xff171d49),
    //   selectionHandleColor: Color(0xff005e91),
    // ),
    backgroundColor: blackColor,
    brightness: Brightness.light,
    highlightColor: blackColor,
    // floatingActionButtonTheme: const FloatingActionButtonThemeData(
    //     backgroundColor: Colors.blue,
    //     focusColor: Colors.blueAccent,
    //     splashColor: Colors.lightBlue),
    // colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
  );
  static final ThemeData orangeTheme = ThemeData(
    primaryColor: Colors.deepOrange,
    primaryColorLight: Colors.deepOrange.withOpacity(.3),
    backgroundColor: blackColor,
    brightness: Brightness.light,
    highlightColor: blackColor,
  );

  static final ThemeData blackTheme = ThemeData(
    primaryColor: const Color(0xff1D1D1F),
    primaryColorLight: const Color(0xff1D1D1F).withOpacity(.3),
    brightness: Brightness.dark,
    highlightColor: Colors.white,
    backgroundColor: Colors.white,
    textSelectionTheme:
        const TextSelectionThemeData(selectionColor: Colors.grey),
  );

  static ThemeData getThemeFromKey(MyThemeKeys themeKey) {
    switch (themeKey) {
      case MyThemeKeys.blue:
        return blueTheme;
      case MyThemeKeys.black:
        return blackTheme;
      case MyThemeKeys.orange:
        return orangeTheme;
      default:
        return blueTheme;
    }
  }
}
