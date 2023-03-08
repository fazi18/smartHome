import 'dart:async';
import 'dart:developer';

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:smart_home/controllers/controller.dart';
import 'package:smart_home/pages/home.dart/home_screen.dart';

class BluetoothController extends GetxController {
  static BluetoothController get to => Get.find();

  BluetoothDevice? device;

  BluetoothDevice? get getDevice => device;

  setDevice(BluetoothDevice? deviceReceived) {
    device = deviceReceived;
    log(device!.name.toString());
    if (Get.isRegistered<Controller>()) {
      Controller.to.closeConnection();
    }
    Get.to(() => HomeScreen());
  }

  final Rx<List<DeviceWithAvailability>> _devices =
      Rx<List<DeviceWithAvailability>>([]);
  List<DeviceWithAvailability> get devices => _devices.value;
  // Availability
  StreamSubscription<BluetoothDiscoveryResult>? _discoveryStreamSubscription;
  bool _isDiscovering = true;

  @override
  void onInit() {
    if (_isDiscovering) {
      _startDiscovery();
    }
    // Setup a list of the bonded devices
    FlutterBluetoothSerial.instance
        .getBondedDevices()
        .then((List<BluetoothDevice> bondedDevices) {
      // setState(() {
      _devices.value = bondedDevices
          .map(
            (device) => DeviceWithAvailability(
              device,
              _isDiscovering
                  ? DeviceAvailability.maybe
                  : DeviceAvailability.yes,
            ),
          )
          .toList();
      // for (var dev in _devices.value) {
      //   if (dev.device?.name == 'HC-06') {
      //     device = dev.device;
      //     Get.to(() => HomeScreen());
      //   }
      // }
      _devices.refresh();
    });
  }

  void _startDiscovery() {
    _discoveryStreamSubscription =
        FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
      // setState(() {
      Iterator i = _devices.value.iterator;
      while (i.moveNext()) {
        var device = i.current;
        if (device.device == r.device) {
          device.availability = DeviceAvailability.yes;
          device.rssi = r.rssi;
        }
      }
      // });
    });

    _discoveryStreamSubscription!.onDone(() {
      // setState(() {
      _isDiscovering = false;
      // });
    });
  }

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and cancel discovery
    _discoveryStreamSubscription?.cancel();
    super.dispose();
  }
}

class DeviceWithAvailability extends BluetoothDevice {
  BluetoothDevice? device;
  DeviceAvailability? availability;
  int? rssi;

  DeviceWithAvailability(this.device, this.availability, [this.rssi])
      : super(address: device!.address);
}

enum DeviceAvailability {
  no,
  maybe,
  yes,
}

class Message {
  int whom;
  String text;

  Message(this.whom, this.text);
}
