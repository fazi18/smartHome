import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../../../theme/color/colors.dart';
import '../../../theme/custom_theme.dart';
import '../../../theme/my_theme.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: const IconThemeData(size: 22.0),
      // / This is ignored if animatedIcon is non null
      // child: Text("open"),
      // activeChild: Text("close"),
      direction: SpeedDialDirection.up,
      icon: Icons.add,
      activeIcon: Icons.close,
      spacing: 3,
      // openCloseDial: isDialOpen,
      childPadding: const EdgeInsets.all(5),
      spaceBetweenChildren: 4,
      dialRoot: (ctx, open, toggleChildren) {
        return SizedBox(
          height: 45,
          width: 45,
          child: InkWell(
            onTap: toggleChildren,
            child: Neumorphic(
              style: NeumorphicStyle(
                shape: NeumorphicShape.concave,
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(50)),
                depth: 5,
                color: Theme.of(context).primaryColor,
                shadowLightColor: Colors.grey,
                shadowDarkColor: blackColor,
                intensity: .8,
                surfaceIntensity: .5,
              ),
            ),
          ),
        );
      },
      // buttonSize:
      //     buttonSize, // it's the SpeedDial size which defaults to 56 itself
      // iconTheme: IconThemeData(size: 22),
      // label: extend
      //     ? const Text("Open")
      //     : null, // The label of the main button.
      // /// The active label of the main button, Defaults to label if not specified.
      // activeLabel: extend ? const Text("Close") : null,

      /// Transition Builder between label and activeLabel, defaults to FadeTransition.
      labelTransitionBuilder: (widget, animation) =>
          ScaleTransition(scale: animation, child: widget),

      /// The below button size defaults to 56 itself, its the SpeedDial childrens size
      // childrenButtonSize: childrenButtonSize,
      // visible: visible,
      // direction: speedDialDirection,
      switchLabelPosition: false,

      // /// If true user is forced to close dial manually
      // closeManually: closeManually,

      // /// If false, backgroundOverlay will not be rendered.
      // renderOverlay: renderOverlay,
      // overlayColor: Colors.black,
      // overlayOpacity: 0.5,
      onOpen: () => debugPrint('OPENING DIAL'),
      onClose: () => debugPrint('DIAL CLOSED'),
      // useRotationAnimation: useRAnimation,
      tooltip: 'Open Speed Dial',
      heroTag: 'speed-dial-hero-tag',
      // foregroundColor: Colors.black,
      // backgroundColor: Colors.white,
      // activeForegroundColor: Colors.red,
      // activeBackgroundColor: Colors.blue,
      elevation: 8.0,
      animationCurve: Curves.elasticInOut,
      isOpenOnStart: false,
      animationDuration: const Duration(milliseconds: 800),
      // shape: customDialRoot
      //     ? const RoundedRectangleBorder()
      //     : const StadiumBorder(),
      // childMargin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      children: [
        SpeedDialChild(
          child: Container(),
          backgroundColor: const Color(0xff1D1D1F),
          foregroundColor: Colors.white,
          onTap: () =>
              CustomTheme.instanceOf(context).changeTheme(MyThemeKeys.black),
        ),
        SpeedDialChild(
          child: Container(),
          backgroundColor: const Color.fromARGB(255, 50, 107, 182),
          foregroundColor: Colors.white,
          onTap: () =>
              CustomTheme.instanceOf(context).changeTheme(MyThemeKeys.blue),
        ),
        SpeedDialChild(
          child: Container(),
          backgroundColor: Colors.deepOrange,
          foregroundColor: Colors.white,
          onTap: () =>
              CustomTheme.instanceOf(context).changeTheme(MyThemeKeys.orange),
        ),
        // SpeedDialChild(
        //   child: Container(),
        //   backgroundColor: Colors.purple,
        //   foregroundColor: Colors.white,
        //   onTap: () =>
        //       CustomTheme.instanceOf(context).changeTheme(MyThemeKeys.LIGHT),
        // ),
        // SpeedDialChild(
        //   child: Container(),
        //   backgroundColor: Colors.grey,
        //   foregroundColor: Colors.white,
        //   onTap: () =>
        //       CustomTheme.instanceOf(context).changeTheme(MyThemeKeys.LIGHT),
        // ),
        // SpeedDialChild(
        //   child: Container(),
        //   backgroundColor: Colors.greenAccent,
        //   foregroundColor: Colors.white,
        //   onTap: () =>
        //       CustomTheme.instanceOf(context).changeTheme(MyThemeKeys.DARK),
        // ),
      ],
    );
  }
}
