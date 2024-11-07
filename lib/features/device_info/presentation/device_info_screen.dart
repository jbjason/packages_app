import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:packages_app/core/util/mydimens.dart';
import 'package:packages_app/features/device_info/data/data_sources/device_info_source.dart';

import 'package:packages_app/features/device_info/data/repository/device_info_repo.dart';
import 'package:packages_app/features/device_info/presentation/providers/device_info_provider.dart';

class DeviceInfoScreen extends StatefulWidget {
  const DeviceInfoScreen({super.key, required this.onSubmit});
  final Function(dynamic) onSubmit;
  @override
  State<DeviceInfoScreen> createState() => _DeviceInfoScreenState();
}

class _DeviceInfoScreenState extends State<DeviceInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyDimens().getNormalAppBar("Device Info", [], context, true),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _getInfo(DeviceInfoTypeEnum.deviceInfo),
              child: Text("Get Device Info"),
            ),
            MyDimens.cmDivider,
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _getInfo(DeviceInfoTypeEnum.battery),
              child: Text("Get Battery Info"),
            ),
            MyDimens.cmDivider,
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _getInfo(DeviceInfoTypeEnum.networkStatus),
              child: Text("Get Network Status"),
            ),
            MyDimens.cmDivider,
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _getInfo(DeviceInfoTypeEnum.contactList),
              child: Text("Get Contact List"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getInfo(DeviceInfoTypeEnum enumType) async {
    String type = "";
    switch (enumType) {
      case DeviceInfoTypeEnum.deviceInfo:
        {
          type = DeviceInfoRepo.typeDeviceInfo;
          break;
        }
      case DeviceInfoTypeEnum.battery:
        {
          type = DeviceInfoRepo.typeBatteryInfo;
          break;
        }
      case DeviceInfoTypeEnum.networkStatus:
        {
          type = DeviceInfoRepo.typeNetworkInfo;
          break;
        }
      case DeviceInfoTypeEnum.contactList:
        {
          type = DeviceInfoRepo.typeContactInfo;
          break;
        }
      default:
        null;
    }
    final result = await DeviceInfoProvider.getInfo(enumType, type);

    Logger().f(result);
  }

  // Future<void> _getDeviceInfo() async {
  //   try {
  //     await DeviceInfoRepo.platform
  //         .invokeMethod(DeviceInfoRepo.typeDeviceInfo)
  //         .then((value) {
  //       _deviceInfo = value;
  //     });
  //   } on PlatformException catch (e) {
  //     _deviceInfo = e.message!;
  //   }
  //   setState(() {});
  // }

  // Future<void> _getBatteryLevel() async {
  //   try {
  //     await DeviceInfoRepo.platform
  //         .invokeMethod<int>(DeviceInfoRepo.typeBatteryInfo)
  //         .then((val) => _batteryInfo = '$val%');
  //   } on PlatformException catch (e) {
  //     _batteryInfo = "Failed to get battery level: '${e.message}'.";
  //   }
  //   setState(() {});
  // }

  // Future<void> _getNetworkInfo() async {
  //   try {
  //     await DeviceInfoRepo.platform
  //         .invokeMethod<String>(DeviceInfoRepo.typeNetworkInfo)
  //         .then((val) => _networkInfo = val!);
  //   } on PlatformException catch (e) {
  //     _networkInfo = e.message!;
  //   }
  //   setState(() {});
  // }

  // Future<void> _getContactInfo() async {
  //   try {
  //     await DeviceInfoRepo.platform
  //         .invokeMethod<String>(DeviceInfoRepo.typeContactInfo)
  //         .then((val) => developer.log(val!));
  //   } on PlatformException catch (e) {
  //     Logger().e(e);
  //   }
  // }
}
