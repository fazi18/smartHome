import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:smart_home/theme/color/colors.dart';

import '../../../custom_icon/custom_icon_icons.dart';

class LightSwitch extends StatelessWidget {
  final bool value;
  final Function(bool? value) onChange;
  const LightSwitch({Key? key, required this.value, required this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChange(!value),
      child: Neumorphic(
        style: NeumorphicStyle(
          shape: value ? NeumorphicShape.concave : NeumorphicShape.flat,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
          depth: value ? 6 : -3,
          color: value ? Theme.of(context).primaryColor : null,
          shadowLightColor: Colors.grey,
          shadowDarkColor: blackColor,
          intensity: .8,
          surfaceIntensity: .5,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: RotationTransition(
                        turns: const AlwaysStoppedAnimation(180 / 360),
                        // child: Image.asset(
                        //   'assets/icons/bulb_ic.png',
                        //   height: 70,
                        //   color: value
                        //       ? whiteColor
                        //       : Theme.of(context).primaryColorLight,
                        // ),
                        child: NeumorphicIcon(
                          value
                              ? CustomIcon.light_bulb_svgrepo_com__1_
                              : CustomIcon.icons8_idea,
                          size: 65,
                          style: NeumorphicStyle(
                            color: !value
                                ? Theme.of(context).primaryColorLight
                                : null,
                            // depth: 0,
                            // intensity: 1,
                          ),
                        )),
                  ),
                  NeumorphicSwitch(
                    style: NeumorphicSwitchStyle(
                      activeTrackColor: whiteColor,
                      activeThumbColor: Theme.of(context).primaryColor,
                    ),
                    height: 25,
                    onChanged: onChange,
                    value: value,
                  ),
                ],
              ),
              const SizedBox(height: 30),
              NeumorphicText(
                'Smart Light',
                style: NeumorphicStyle(
                  depth: 8,
                  shadowDarkColor: value ? blackColor : blackColor,
                  shadowLightColor: value ? whiteColor : whiteColor,
                  color: value ? null : Theme.of(context).primaryColorLight,
                ),
                textStyle: NeumorphicTextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
