import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../constant/constants.dart';
import 'custom_draw.dart';

class SliderWidget extends StatefulWidget {
  const SliderWidget({super.key});

  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  double progressVal = 0.5;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ShaderMask(
          shaderCallback: (rect) {
            return SweepGradient(
              startAngle: degToRad(0),
              endAngle: degToRad(184),
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColor.withAlpha(50)
              ],
              stops: [progressVal, progressVal],
              transform: GradientRotation(
                degToRad(178),
              ),
            ).createShader(rect);
          },
          child: const Center(
            child: CustomArc(),
          ),
        ),

        Center(
          child: SizedBox(
            width: kDiameter - 30,
            height: kDiameter - 30,
            child: Neumorphic(
              style: NeumorphicStyle(
                shape: NeumorphicShape.convex,
                boxShape: const NeumorphicBoxShape.circle(),
                depth: 10,
                shadowDarkColorEmboss: Theme.of(context).primaryColor,
                shadowLightColorEmboss: Theme.of(context).primaryColorLight,
                shadowLightColor: Theme.of(context).primaryColorLight,
                shadowDarkColor: Theme.of(context).primaryColor.withAlpha(
                    normalize(progressVal * 30000, 100, 255).toInt()),
                intensity: 1,
                surfaceIntensity: 1,
              ),
              // child: Container(
              //   width: kDiameter - 30,
              //   height: kDiameter - 30,
              //   decoration: BoxDecoration(
              //       color: Colors.white,
              //       shape: BoxShape.circle,
              //       border: Border.all(
              //         color: Colors.white,
              //         width: 20,
              //         style: BorderStyle.solid,
              //       ),
              //       boxShadow: [
              //         BoxShadow(
              //             blurRadius: 30,
              //             spreadRadius: 10,
              //             color: Theme.of(context).primaryColor.withAlpha(
              //                 normalize(progressVal * 20000, 100, 255).toInt()),
              //             offset: const Offset(1, 3))
              //       ]),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: SleekCircularSlider(
                  min: kMinDegree,
                  max: kMaxDegree,
                  initialValue: 22,
                  appearance: CircularSliderAppearance(
                    startAngle: 180,
                    angleRange: 180,
                    size: kDiameter - 30,
                    customWidths: CustomSliderWidths(
                      trackWidth: 10,
                      shadowWidth: 0,
                      progressBarWidth: 02,
                      handlerSize: 15,
                    ),
                    customColors: CustomSliderColors(
                      hideShadow: true,
                      progressBarColor: Colors.transparent,
                      trackColor: Colors.transparent,
                      dotColor: Theme.of(context).primaryColor,
                    ),
                  ),
                  onChange: (value) {
                    setState(() {
                      progressVal =
                          normalize(value, kMinDegree, kMaxDegree).toDouble();
                    });
                  },
                  innerWidget: (percentage) {
                    return Center(
                      child: Text(
                        '${percentage.toInt()}%',
                        style: const TextStyle(
                          fontSize: 50,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        // ),
      ],
    );
  }
}
