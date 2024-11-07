import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:packages_app/features/device_info/data/data_sources/device_info_source.dart';
import 'package:packages_app/features/device_info/data/models/device_info.dart';
import 'package:packages_app/features/device_info/data/models/device_info_contact.dart';
import 'package:packages_app/features/device_info/data/repository/device_info_repo.dart';
import 'dart:developer' as developer;

class DeviceInfoProvider {
  static Future<dynamic> getInfo(
      DeviceInfoTypeEnum enumType, String type) async {
    try {
      await DeviceInfoRepo.platform.invokeMethod(type).then((result) {
        developer.log(result);
        dynamic response;
        switch (enumType) {
          case DeviceInfoTypeEnum.deviceInfo:
            {
              Logger().i(result);
              final item =
                  result.toString().substring(1, result.toString().length - 1);
              print(item);
              final items = item.split(", ");
              print(items);
              Logger().t("""
                id: ${items[0]},
                version: ${items[1]},
                device: ${items[2]},
                model: ${items[3]},
                product:${items[4]},
                manufacturer: ${items[5]},
                sdkVersion: ${items[6]},
""");
              response = DeviceInfo(
                  id: items[0],
                  version: items[1],
                  device: items[2],
                  model: items[3],
                  product: items[4],
                  manufacturer: items[5],
                  sdkVersion: items[6]);
              print(response.id);
              print(response.version);
              print(response.device);
              print(response.model);
              print(response.product);
              print(response.manufacturer);
              print(response.sdkVersion);
              break;
            }
          case DeviceInfoTypeEnum.battery:
            {
              response = '$result%';
              break;
            }
          case DeviceInfoTypeEnum.networkStatus:
            {
              response = result;
              break;
            }
          case DeviceInfoTypeEnum.contactList:
            {
              for (int i = 0; i < result.length; i++) {
                response.add(
                  DeviceInfoContact(
                    id: (result[i][0]).toString(),
                    name: (result[i][1]).toString(),
                    number: (result[i][2]).toString(),
                    image: result[i][3]!.toString(),
                  ),
                );
              }
              break;
            }
          default:
            print("not Matched");
            break;
        }
        return response;
      });
    } on PlatformException catch (e) {
      return e.message!;
    }
  }
}
