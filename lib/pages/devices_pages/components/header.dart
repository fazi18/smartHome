import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:smart_home/theme/color/colors.dart';

class DeviceListHeader extends StatelessWidget {
  const DeviceListHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 25, left: 30),
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: const Align(
        alignment: Alignment.bottomLeft,
        child: Text(
          'Remote Devices',
          style: TextStyle(
            color: whiteColor,
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
      ),
    );
  }
}
