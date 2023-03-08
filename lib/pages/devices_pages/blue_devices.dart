import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:smart_home/pages/devices_pages/components/list_bluetooth.dart';
import 'package:smart_home/controllers/bluetooth_controller.dart';

import 'components/header.dart';

class BluetoothScreen extends StatelessWidget {
  BluetoothScreen({Key? key}) : super(key: key);

  final _controller = Get.put(BluetoothController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const DeviceListHeader(),
            Expanded(
              child: Obx(
                () => _controller.devices.isEmpty
                    ? const Center(child: Text('No Device'))
                    : ListView(
                        children: _controller.devices
                            .map(
                              (device) => ListaBluetoothPage(
                                device: device.device,
                                onTap: () {
                                  _controller.setDevice(device.device);
                                  // Navigator.of(context).pushReplacement(MaterialPageRoute(
                                  //     settings: const RouteSettings(name: '/'),
                                  //     builder: (context) => HomePage()));
                                },
                              ),
                            )
                            .toList(),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
