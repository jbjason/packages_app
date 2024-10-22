import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

class DeficeInfoScreen extends StatefulWidget {
  const DeficeInfoScreen({super.key});
  @override
  State<DeficeInfoScreen> createState() => _DeficeInfoScreenState();
}

class _DeficeInfoScreenState extends State<DeficeInfoScreen> {
  static const platform = MethodChannel('flutter.native/helper');
  String _deviceInfo = "Unknown";

  @override
  void initState() {
    super.initState();
    if (mounted) _getDeviceInfo();
  }

  Future<void> _getDeviceInfo() async {
    String result;
    try {
      await platform.invokeMethod('getDeviceInfo').then((value) {
        result = value.toString();
        setState(() {
          _deviceInfo = result;
        });
      });
    } on PlatformException catch (e) {
      Logger().e("_getDeviceInfo==>${e.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(_deviceInfo)));
  }
}
