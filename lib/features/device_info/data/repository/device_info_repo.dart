import 'package:flutter/services.dart';

class DeviceInfoRepo {
  static const platform = MethodChannel('flutter.native/helper');
  static const typeDeviceInfo = "getDeviceInfo";
  static const typeBatteryInfo = "getBatteryInfo";
  static const typeNetworkInfo = "getNetworkInfo";
  static const typeContactInfo = "getContactInfo";
}
