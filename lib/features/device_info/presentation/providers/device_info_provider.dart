import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:packages_app/features/device_info/data/data_sources/device_info_source.dart';
import 'package:packages_app/features/device_info/data/models/device_info.dart';
import 'package:packages_app/features/device_info/data/models/device_info_contact.dart';
import 'package:packages_app/features/device_info/data/repository/device_info_repo.dart';

class DeviceInfoProvider {
  Future<dynamic> getInfo(DeviceInfoTypeEnum enumType) async {
    try {
      dynamic response;
      switch (enumType) {
        case DeviceInfoTypeEnum.deviceInfo:
          {
            final result =
                await _getInfoFromDevice(DeviceInfoRepo.typeDeviceInfo);
            final item =
                result.toString().substring(1, result.toString().length - 1);
            final items = item.split(", ");
            response = DeviceInfo(
              id: items[0],
              version: items[1],
              device: items[2],
              model: items[3],
              product: items[4],
              manufacturer: items[5],
              sdkVersion: items[6],
            );
            break;
          }
        case DeviceInfoTypeEnum.battery:
          {
            response = await _getInfoFromDevice(DeviceInfoRepo.typeBatteryInfo);
            break;
          }
        case DeviceInfoTypeEnum.networkStatus:
          {
            response = await _getInfoFromDevice(DeviceInfoRepo.typeNetworkInfo);
            break;
          }
        case DeviceInfoTypeEnum.contactList:
          {
            final result =
                await _getInfoFromDevice(DeviceInfoRepo.typeContactInfo);
            if (result != null || result.toString().length > 5) {
              final List<DeviceInfoContact> contactList = [];
              final item = result.toString().substring(1, result.length - 2);
              final items = item.split("], ");
              Logger().e(items);
              for (int i = 0; i < items.length; i++) {
                final item2 = items[i]
                    .toString()
                    .substring(1, items[i].toString().length);
                final items2 = item2.split(", ");
                Logger().e(items2);
                contactList.add(
                  DeviceInfoContact(
                    id: (items2[0]),
                    name: (items2[1]),
                    number: (items2[2]),
                    image: items2[3],
                  ),
                );
              }
              response = contactList;
            }
            break;
          }
        default:
          null;
      }
      return response;
      // await DeviceInfoRepo.platform.invokeMethod(type).then((result) {
      //   developer.log(result);
      //   switch (enumType) {
      //     case DeviceInfoTypeEnum.deviceInfo:
      //       {
      //         Logger().i(result);
      //         final item =
      //             result.toString().substring(1, result.toString().length - 1);
      //         final items = item.split(", ");
      //         response = DeviceInfo(
      //             id: items[0],
      //             version: items[1],
      //             device: items[2],
      //             model: items[3],
      //             product: items[4],
      //             manufacturer: items[5],
      //             sdkVersion: items[6]);
      //         print(response.id);
      //         print(response.version);
      //         print(response.device);
      //         print(response.model);
      //         print(response.product);
      //         print(response.manufacturer);
      //         print(response.sdkVersion);
      //         break;
      //       }
      //     case DeviceInfoTypeEnum.battery:
      //       {
      //         response = '$result%';
      //         break;
      //       }
      //     case DeviceInfoTypeEnum.networkStatus:
      //       {
      //         response = result;
      //         break;
      //       }
      //     case DeviceInfoTypeEnum.contactList:
      //       {
      //         for (int i = 0; i < result.length; i++) {
      //           response.add(
      //             DeviceInfoContact(
      //               id: (result[i][0]).toString(),
      //               name: (result[i][1]).toString(),
      //               number: (result[i][2]).toString(),
      //               image: result[i][3]!.toString(),
      //             ),
      //           );
      //         }
      //         break;
      //       }
      //     default:
      //       print("not Matched");
      //       break;
      //   }
      // });
      // return response;
    } on PlatformException catch (e) {
      return e.message!;
    }
  }

  static dynamic _getInfoFromDevice(String type) async {
    try {
      final result = await DeviceInfoRepo.platform.invokeMethod(type);
      Logger().t(result);
      return result;
    } catch (e) {
      Logger().e(e);
    }
  }
}
