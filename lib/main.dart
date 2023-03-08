import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:smart_home/pages/devices_pages/blue_devices.dart';
import 'package:smart_home/pages/home.dart/home_screen.dart';
import 'package:smart_home/theme/my_theme.dart';
import 'package:smart_home/utils/local_storage.dart';

import 'theme/custom_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isAddressSaved = await LocalStorage.getDeviceAddress() != null;
  runApp(CustomTheme(
    initialThemeKey: MyThemeKeys.blue,
    child: MyApp(
      isSaved: isAddressSaved,
    ),
  ));
}

class MyApp extends StatefulWidget {
  final bool isSaved;
  const MyApp({Key? key, required this.isSaved}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isAddressSaved = false;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      home: widget.isSaved ? HomeScreen() : BluetoothScreen(),
    );
  }

  // checkAddress() async {
  //    = await LocalStorage.getDeviceAddress() != null;
  //   setState(() {});
  // }
}
