import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:smart_home/controllers/bluetooth_controller.dart';
import 'package:smart_home/utils/app_state.dart';
import 'package:smart_home/utils/local_storage.dart';

import '../pages/devices_pages/blue_devices.dart';

class Controller extends GetxController {
  BluetoothConnection? connection;
  bool isDisconnecting = false;
  List<Message> messages = <Message>[];
  int reconntedCount = 3;

  final _connectionState = Rx<AppState>(AppState.init);
  final _fanOn = true.obs;
  final _fanValue = 27.obs;
  bool _isCon = false;
  final _lightSwitch1 = false.obs;
  final _lightSwitch2 = false.obs;
  final _lightSwitch3 = false.obs;
  final _lightSwitch4 = false.obs;
  final String _messageBuffer = '';

  @override
  void dispose() {
    closeConnection();
    super.dispose();
  }

  AppState get connectionState => _connectionState.value;

  static Controller get to => Get.find();

  bool get isConnected => connection != null && connection!.isConnected;

  bool get lightSwitch1 => _lightSwitch1.value;

  bool get lightSwitch2 => _lightSwitch2.value;

  bool get lightSwitch3 => _lightSwitch3.value;

  bool get lightSwitch4 => _lightSwitch4.value;

  bool get fanOn => _fanOn.value;

  int get fanValue => _fanValue.value;

  onFanOnOff(bool v) {
    _fanOn.value = v;
    _sendMessage(v ? "I" : 'J');

    log(_fanOn.toString());
  }

  onFanValueChange(int value) {
    _fanValue.value = value;
    if (value < 20) {
      _sendMessage('a');
    } else if (value < 40) {
      _sendMessage('b');
    } else if (value < 60) {
      _sendMessage('c');
    } else if (value < 80) {
      _sendMessage('d');
    } else if (value < 100) {
      _sendMessage('e');
    }
  }

  onSwitchChange1(bool v) {
    _sendMessage(v ? "A" : 'B');
    _lightSwitch1.value = v;
  }

  onSwitchChange2(bool v) {
    _sendMessage(v ? 'C' : 'D');
    _lightSwitch2.value = v;
  }

  onSwitchChange3(bool v) {
    _sendMessage(v ? 'E' : 'F');
    _lightSwitch3.value = v;
  }

  onSwitchChange4(bool v) {
    _sendMessage(v ? 'G' : 'H');
    _lightSwitch4.value = v;
  }

  navigateToDeviceList() {
    // closeConnection();
    Get.to(() => BluetoothScreen());
  }

  backgroundRunConnection() async {
    log('connection-------');
    if (isConnected) {
      _connectionState.value = AppState.done;
      return;
    }
    final address = await _getDeviceAddress();
    BluetoothConnection.toAddress(address).then((con) async {
      log('Connected to device');
      _isCon = true;

      connection = con;
      _connectionState.value = AppState.done;
      isDisconnecting = false;
      await LocalStorage.saveDeviceAddress(address);
      _sendMessage('@');
      connection!.input!.listen(_onDataReceived).onDone(() {
        _connectionState.value = AppState.loading;
        if (isDisconnecting) {
          log('Disconnected localy!');
          backgroundRunConnection();
          _isCon = false;
          _connectionState.value = AppState.error;
        } else {
          _connectionState.value = AppState.error;
          _isCon = false;
          backgroundRunConnection();
          log('Disconnected remote!');
        }
      });
    }).catchError((error) {
      _isCon = false;
      backgroundRunConnection();
      log('Failed to connect, something is wrong!');
      log(error.toString());
    });
  }

  bluetoothConnection() async {
    _connectionState.value = AppState.loading;
    if (isConnected) {
      _connectionState.value = AppState.done;
      return;
    }
    final address = await _getDeviceAddress();
    BluetoothConnection.toAddress(address).then((con) async {
      log('Connected to device');
      connection = con;

      _connectionState.value = AppState.done;
      isDisconnecting = false;
      await LocalStorage.saveDeviceAddress(address);
      _sendMessage('@');
      connection!.input!.listen(_onDataReceived).onDone(() {
        _connectionState.value = AppState.loading;
        // Example: Detect which side closed the connection
        // There should be `isDisconnecting` flag to show are we are (locally)
        // in middle of disconnecting process, should be set before calling
        // `dispose`, `finish` or `close`, which all causes to disconnect.
        // If we except the disconnection, `onDone` should be fired as result.
        // If we didn't except this (no flag set), it means closing by remote.
        if (isDisconnecting) {
          log('Disconnected localy!');
          backgroundRunConnection();
          _isCon = false;
          _connectionState.value = AppState.error;
          // _connectionState.value = AppState.disconnected;
        } else {
          _connectionState.value = AppState.error;
          _isCon = false;
          backgroundRunConnection();
          log('Disconnected remote!');
        }
        // if (mounted) {
        //   setState(() {});
        // }
      });
    }).catchError((error) {
      log('------>$reconntedCount');
      if (reconntedCount > 0) {
        reconntedCount--;
        bluetoothConnection();
      } else {
        _isCon = false;
        closeConnection();
        backgroundRunConnection();
        log('Failed to connect, something is wrong!');
        log(error.toString());
        _connectionState.value = AppState.error;
      }
    });
  }

  closeConnection() {
    reconntedCount = 3;
    isDisconnecting = true;
    _isCon = false;
    if (connection != null) {
      connection!.dispose();
    }
    // connection!.close();
    // connection!.finish();
    connection = null;
  }

  void _onDataReceived(Uint8List data) {
    // Allocate buffer for parsed data
    int backspacesCounter = 0;
    for (var byte in data) {
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    }
    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    int bufferIndex = buffer.length;

    // Apply backspace control character
    backspacesCounter = 0;
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
    }

    // Create message if there is new line character
    String dataString = String.fromCharCodes(buffer);
    // int index = buffer.indexOf(13);
    // if (~index != 0) {
    //   // setState(() {
    //   messages.add(
    //     Message(
    //       1,
    //       backspacesCounter > 0
    //           ? _messageBuffer.substring(
    //               0, _messageBuffer.length - backspacesCounter)
    //           : _messageBuffer + dataString.substring(0, index),
    //     ),
    //   );
    //   _messageBuffer = dataString.substring(index);
    //   // });
    // } else {
    //   _messageBuffer = (backspacesCounter > 0
    //       ? _messageBuffer.substring(
    //           0, _messageBuffer.length - backspacesCounter)
    //       : _messageBuffer + dataString);
    // }
    log('--------$dataString ________');
    if (dataString.contains('A')) {
      _lightSwitch1.value = true;
    } else if (dataString[0].contains('B')) {
      _lightSwitch1.value = false;
    }
    if (dataString.contains('C')) {
      _lightSwitch2.value = true;
    } else if (dataString.contains('D')) {
      _lightSwitch2.value = false;
    }
    if (dataString.contains('E')) {
      _lightSwitch3.value = true;
    } else if (dataString.contains('F')) {
      _lightSwitch3.value = false;
    }
    if (dataString.contains('G')) {
      _lightSwitch4.value = true;
    } else if (dataString.contains('H')) {
      _lightSwitch4.value = false;
    }
    if (dataString.contains('I')) {
      _fanOn.value = true;
    } else if (dataString.contains('J')) {
      _fanOn.value = false;
    }
    if (dataString.contains('a')) {
      log('dataString = 96');
      _fanValue.value = 00;
    } else if (dataString.contains('b')) {
      _fanValue.value = 20;
      log('dataString = 97');
    } else if (dataString.contains('c')) {
      _fanValue.value = 40;
      log('dataString = 98');
    } else if (dataString.contains('d')) {
      _fanValue.value = 60;
      log('dataString = 99');
    } else if (dataString.contains('e')) {
      _fanValue.value = 80;
      log('dataString = 100');
    } else if (dataString.contains('f')) {
      _fanValue.value = 100;
      log('dataString = 101');
    }
  }

  _sendMessage(text) async {
    // text = text.trim();

    if (text.length > 0) {
      try {
        // log("------${Uint8List.fromList(utf8.encode('242'))}");
        connection!.output.add(Uint8List.fromList(utf8.encode(text)));
        await connection!.output.allSent;

        // setState(() {
        //   messages.add(_Message(widget.clientID, text));
        // });
      } catch (e) {
        // setState(() {});
        log('------$e');
      }
    }
  }

  _getDeviceAddress() async {
    final address = await LocalStorage.getDeviceAddress();
    if (address == null) {
      return BluetoothController.to.device!.address;
    } else {
      return address;
    }
  }
}
