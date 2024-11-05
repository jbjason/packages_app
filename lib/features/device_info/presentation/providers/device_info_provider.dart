import 'package:flutter/services.dart';
import 'package:packages_app/features/device_info/data/data_sources/device_info_source.dart';
import 'package:packages_app/features/device_info/data/models/device_info.dart';
import 'package:packages_app/features/device_info/data/models/device_info_contact.dart';
import 'package:packages_app/features/device_info/data/repository/device_info_repo.dart';
import 'dart:developer' as developer;

class DeviceInfoProvider {
  static Future<dynamic> getInfo(
      DeviceInfoTypeEnum enumType, String type) async {
    try {
      await DeviceInfoRepo.platform.invokeMethod(type).then((val) {
        developer.log(val!);
        switch (enumType) {
          case DeviceInfoTypeEnum.deviceInfo:
            {
              return DeviceInfo.fromJson(val);
            }
          case DeviceInfoTypeEnum.battery:
            {
              return '$val%';
            }
          case DeviceInfoTypeEnum.networkStatus:
            {
              return val.toString();
            }
          case DeviceInfoTypeEnum.contactList:
            {
              final List<DeviceInfoContact> contactList = [];
              for (int i = 0; i < val.length; val++) {
                contactList.add(
                  DeviceInfoContact(
                    id: val[i][0],
                    name: val[i][1],
                    number: val[i][2],
                    image: val[i][3],
                  ),
                );
              }
              return contactList;
            }
        }
      });
    } on PlatformException catch (e) {
      return e.message!;
    }
  }
}
