import 'dart:developer';

import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:smart_home/components/error_view.dart';
import 'package:smart_home/controllers/controller.dart';
import 'package:smart_home/theme/custom_theme.dart';

import '../../components/loading_progress_bar.dart';
import '../../utils/app_state.dart';
import 'components/color_picker.dart';
import 'components/fan_dimmer.dart';
import 'components/light_switch.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final _controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: CustomTheme.of(context),
      home: Scaffold(
        floatingActionButton: const MyWidget(),
        backgroundColor: const Color(0xffe4ebf8),
        body: SafeArea(
            child: StreamBuilder<BluetoothState>(
                stream: FlutterBlue.instance.state,
                initialData: BluetoothState.unknown,
                builder: (c, snapshot) {
                  final state = snapshot.data;
                  log('$state=======');
                  log(state.toString());
                  if (state == BluetoothState.on) {
                    _controller.bluetoothConnection();
                    return _buildBody(context);
                  } else if (state == BluetoothState.off) {
                    _controller.closeConnection();
                    return const ErrorView(
                      title: 'Bluetooth Turned off',
                      subtitle:
                          "Bluetooth of your device is turned off, Please turn it on.",
                    );
                  }
                  return const Center(child: Text('something is wrong'));
                })),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Obx(
      () => _controller.connectionState == AppState.loading
          ? const LoadingProgressBar()
          : _controller.connectionState == AppState.error
              ? ErrorView(
                  title: 'Connection Lost!',
                  subtitle:
                      "Please check your device, may be it's not connected",
                  onTryAgain: () => _controller.bluetoothConnection(),
                )
              : _controller.connectionState == AppState.done
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Expanded(
                            flex: 2,
                            child: FanView(),
                          ),
                          SizedBox(height: height * .05),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Obx(
                                      () => LightSwitch(
                                        value: _controller.lightSwitch1,
                                        onChange: (v) =>
                                            _controller.onSwitchChange1(v!),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 30),
                                  Expanded(
                                    child: Obx(
                                      () => LightSwitch(
                                        value: _controller.lightSwitch2,
                                        onChange: (v) =>
                                            _controller.onSwitchChange2(v!),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: height * .03),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Obx(
                                      () => LightSwitch(
                                        value: _controller.lightSwitch3,
                                        onChange: (v) =>
                                            _controller.onSwitchChange3(v!),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 30),
                                  Expanded(
                                    child: Obx(
                                      () => LightSwitch(
                                        value: _controller.lightSwitch4,
                                        onChange: (v) =>
                                            _controller.onSwitchChange4(v!),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: height * .01),
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: SizedBox(
                              height: 45,
                              width: 45,
                              child: InkWell(
                                onTap: _controller.navigateToDeviceList,
                                child: Neumorphic(
                                  style: NeumorphicStyle(
                                    shape: NeumorphicShape.convex,
                                    boxShape: NeumorphicBoxShape.roundRect(
                                        BorderRadius.circular(50)),
                                    depth: 5,
                                    // color: Theme.of(context).primaryColor,
                                    // shadowLightColor: Colors.grey,
                                    // shadowDarkColor: blackColor,
                                    intensity: .8,
                                    surfaceIntensity: .5,
                                  ),
                                  child: Icon(
                                    Icons.bluetooth_audio_rounded,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: height * .02),
                        ],
                      ),
                    )
                  : ErrorView(
                      title: 'Something is Wrong',
                      subtitle: "Something went wrong, please try again!",
                      onTryAgain: () => _controller.bluetoothConnection(),
                    ),
    );
  }
}
