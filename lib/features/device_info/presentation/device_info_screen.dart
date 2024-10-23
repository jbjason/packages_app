import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:packages_app/core/util/mydimens.dart';

enum DeviceInfoType { deviceInfo, battery }

class DeviceInfoScreen extends StatefulWidget {
  const DeviceInfoScreen({super.key});
  @override
  State<DeviceInfoScreen> createState() => _DeviceInfoScreenState();
}

class _DeviceInfoScreenState extends State<DeviceInfoScreen> {
  static const platform = MethodChannel('flutter.native/helper');
  String _deviceInfo = "", _batteryInfo = "", _networkInfo = "";

  Future<void> _getDeviceInfo() async {
    try {
      await platform.invokeMethod('getDeviceInfo').then((value) {
        _deviceInfo = value;
      });
    } on PlatformException catch (e) {
      _deviceInfo = e.message!;
    }
    setState(() {});
  }

  Future<void> _getBatteryLevel() async {
    try {
      await platform
          .invokeMethod<int>('getBatteryInfo')
          .then((val) => _batteryInfo = '$val%');
    } on PlatformException catch (e) {
      _batteryInfo = "Failed to get battery level: '${e.message}'.";
    }
    setState(() {});
  }

  Future<void> _getNetworkInfo() async {
    try {
      await platform
          .invokeMethod<String>('getNetworkInfo')
          .then((val) => _networkInfo = val!);
    } on PlatformException catch (e) {
      _networkInfo = e.message!;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyDimens().getNormalAppBar("Device Info", [], context, true),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(_deviceInfo),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _getDeviceInfo(),
              child: Text("Get Device Info"),
            ),
            MyDimens.cmDivider,
            MyDimens.cmDivider,
            Text(_batteryInfo),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _getBatteryLevel(),
              child: Text("Get Battery Info"),
            ),
            MyDimens.cmDivider,
            MyDimens.cmDivider,
            Text(_networkInfo),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _getNetworkInfo(),
              child: Text("Get Network Status"),
            ),
          ],
        ),
      ),
    );
  }
}
