import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:smart_home/components/silder_widget.dart';

import '../../../controllers/controller.dart';
import '../../../theme/color/colors.dart';

class FanView extends StatelessWidget {
  const FanView({super.key});

  @override
  Widget build(BuildContext context) {
    final ctr = Controller.to;
    return Obx(() => Padding(
          padding: const EdgeInsets.all(20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NeumorphicText(
                      'Smart Fan',
                      style: NeumorphicStyle(
                        depth: 8,
                        shadowDarkColor: ctr.fanOn ? blackColor : blackColor,
                        shadowLightColor: ctr.fanOn ? whiteColor : whiteColor,
                        color: ctr.fanOn
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).primaryColorLight,
                      ),
                      textStyle: NeumorphicTextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    NeumorphicSwitch(
                      style: NeumorphicSwitchStyle(
                        activeTrackColor: Theme.of(context).primaryColor,
                        activeThumbColor: whiteColor,
                        inactiveThumbColor: Theme.of(context).primaryColor,
                        trackDepth: ctr.fanOn ? 5 : 0,
                        thumbDepth: 0,
                      ),
                      height: 25,
                      onChanged: (v) => ctr.onFanOnOff(v),
                      value: ctr.fanOn,
                    ),
                  ],
                ),
                const Expanded(child: SliderWidget()),
              ],
            ),
          ),
        ));
  }
}

// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:get/state_manager.dart';
// import 'package:smart_home/controllers/controller.dart';
// import 'package:syncfusion_flutter_sliders/sliders.dart';

// import '../../../custom_icon/custom_icon_icons.dart';
// import '../../../theme/color/colors.dart';

// class FanView extends StatelessWidget {
//   const FanView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final c = Controller.to;
//     final height = MediaQuery.of(context).size.height;
//     return Padding(
//       padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
//       child: Stack(
//         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         // crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               NeumorphicText(
//                 'Smart Fan',
//                 style: NeumorphicStyle(
//                   depth: 4,
//                   shadowDarkColor: blackColor,
//                   shadowLightColor: Colors.white,
//                   color: Theme.of(context).primaryColor,
//                 ),
//                 textStyle: NeumorphicTextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               SizedBox(height: height * .03),
//               Row(
//                 children: [
//                   SizedBox(
//                     height: height * .3,
//                     child: Obx(() => Neumorphic(
//                           style: NeumorphicStyle(
//                             shape: NeumorphicShape.concave,
//                             boxShape: NeumorphicBoxShape.roundRect(
//                                 BorderRadius.circular(10)),
//                             depth: c.fanOn ? 5 : -5,
//                             // color: const Color(0xffe4ebf8),
//                             shadowLightColor: Colors.grey,
//                             shadowDarkColor: blackColor,
//                             intensity: .8,
//                             surfaceIntensity: .5,
//                           ),
//                           // child: VerticalSlider(
//                           //   onChanged: !c.fanOn
//                           //       ? null
//                           //       : (v) => c.onFanValueChange(v.toInt()),
//                           //   min: 0.0,
//                           //   max: 100.0,
//                           //   value: c.fanValue.toDouble(),
//                           //   width: 60,
//                           //   activeTrackColor: c.fanOn
//                           //       ? Theme.of(context).primaryColor
//                           //       : Theme.of(context).primaryColorLight,
//                           //   inactiveTrackColor:
//                           //       Theme.of(context).primaryColorLight,
//                           // ),
//                           child: SfSlider.vertical(
//                             min: 0.0,
//                             max: 100.0,
//                             value: c.fanValue,
//                             interval: 10,
//                             showTicks: true,
//                             showLabels: false,
//                             showDividers: true,
//                             enableTooltip: true,
//                             shouldAlwaysShowTooltip: true,
//                             activeColor: Theme.of(context).primaryColor,
//                             inactiveColor: Theme.of(context).primaryColorLight,
//                             //  showTooltip: true,
//                             minorTicksPerInterval: 5,
//                             onChanged: !c.fanOn
//                                 ? null
//                                 : (v) => c.onFanValueChange(v.toInt()),
//                           ),
//                         )),
//                   ),
//                   const SizedBox(width: 10),
//                   SizedBox(
//                     height: height * .3,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         NeumorphicIcon(
//                           CustomIcon
//                               .ecological_generator_tool_of_rotatory_fan_svgrepo_com,
//                           size: 18,
//                           style: NeumorphicStyle(
//                             color: c.fanOn
//                                 ? Theme.of(context).primaryColorLight
//                                 : null,
//                             intensity: .8,
//                             surfaceIntensity: .5,
//                           ),
//                         ),
//                         NeumorphicIcon(
//                           CustomIcon.summer_cooler_fan_svgrepo_com,
//                           size: 18,
//                           style: NeumorphicStyle(
//                             color: c.fanOn
//                                 ? Theme.of(context).primaryColorLight
//                                 : null,
//                             intensity: .8,
//                             surfaceIntensity: .5,
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ],
//           ),
//           Positioned(
//             right: 0,
//             top: 0,
//             bottom: 0,
//             child: Padding(
//               padding: const EdgeInsets.only(top: 20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Obx(() => Row(
//                         children: [
//                           NeumorphicText(
//                             c.fanOn ? 'On' : 'Off',
//                             style: NeumorphicStyle(
//                               depth: 4,
//                               shadowDarkColor: blackColor,
//                               shadowLightColor: Colors.white,
//                               color: Theme.of(context).primaryColorLight,
//                             ),
//                             textStyle: NeumorphicTextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           const SizedBox(width: 8),
//                           NeumorphicSwitch(
//                             style: NeumorphicSwitchStyle(
//                               activeTrackColor: Theme.of(context).primaryColor,
//                               activeThumbColor: whiteColor,
//                               inactiveThumbColor:
//                                   Theme.of(context).primaryColor,
//                               trackDepth: c.fanOn ? 5 : 0,
//                               thumbDepth: 0,
//                             ),
//                             height: 25,
//                             onChanged: (v) => c.onFanOnOff(v),
//                             value: c.fanOn,
//                           ),
//                         ],
//                       )),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Obx(() => Padding(
//                             padding: const EdgeInsets.only(top: 20),
//                             child: Text(
//                               c.fanValue.toString(),
//                               style: TextStyle(
//                                 color: c.fanOn
//                                     ? Theme.of(context).primaryColor
//                                     : Theme.of(context).primaryColorLight,
//                                 fontWeight: FontWeight.w700,
//                                 fontSize: 60,
//                               ),
//                             ),
//                           )),
//                       Obx(() => NeumorphicText(
//                             '%',
//                             style: NeumorphicStyle(
//                               color: c.fanOn
//                                   ? Theme.of(context).primaryColor
//                                   : Theme.of(context).primaryColorLight,
//                             ),
//                             textStyle: NeumorphicTextStyle(
//                               fontWeight: FontWeight.w600,
//                               fontSize: 32,
//                             ),
//                           )),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//             left: 20,
//             top: 150,
//             bottom: 0,
//             right: 0,
//             child: Obx(() => NeumorphicIcon(
//                   CustomIcon
//                       .ecological_generator_tool_of_rotatory_fan_svgrepo_com,
//                   size: 150,
//                   style: NeumorphicStyle(
//                     color: c.fanOn ? Theme.of(context).primaryColorLight : null,
//                     intensity: .8,
//                     surfaceIntensity: .5,
//                   ),
//                 )),
//           )
//         ],
//       ),
//     );
//   }
// }
