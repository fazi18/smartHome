import 'package:flutter/material.dart';

import 'my_theme.dart';

class _CustomTheme extends InheritedWidget {
  final CustomThemeState data;

  const _CustomTheme({
    required this.data,
    required Widget child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(_CustomTheme oldWidget) {
    return true;
  }
}

class CustomTheme extends StatefulWidget {
  final Widget child;
  final MyThemeKeys initialThemeKey;

  const CustomTheme({
    required this.initialThemeKey,
    required this.child,
  }) : super();

  @override
  CustomThemeState createState() => CustomThemeState();

  static ThemeData of(BuildContext context) {
    _CustomTheme? inherited =
        (context.dependOnInheritedWidgetOfExactType<_CustomTheme>());
    return inherited!.data.theme!;
  }

  static CustomThemeState instanceOf(BuildContext context) {
    _CustomTheme? inherited =
        (context.dependOnInheritedWidgetOfExactType<_CustomTheme>());
    return inherited!.data;
  }
}

class CustomThemeState extends State<CustomTheme> {
  ThemeData? _theme;

  ThemeData? get theme => _theme;

  @override
  void initState() {
    _theme = MyThemes.getThemeFromKey(widget.initialThemeKey);
    super.initState();
  }

  void changeTheme(MyThemeKeys themeKey) {
    setState(() {
      _theme = MyThemes.getThemeFromKey(themeKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _CustomTheme(
      data: this,
      child: widget.child,
    );
  }
}
