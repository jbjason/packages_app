import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:packages_app/core/util/mydimens.dart';
import 'package:packages_app/features/device_info/data/data_sources/device_info_source.dart';
import 'package:packages_app/features/device_info/presentation/providers/device_info_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeviceInfoScreen extends StatelessWidget {
  const DeviceInfoScreen({super.key, required this.onSubmit});
  final Function(dynamic) onSubmit;
  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return Scaffold(
      appBar:
          MyDimens().getNormalAppBar(local.nativeFeature, [], context, true),
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
              onPressed: () async {
                await Permission.contacts.request();
                _getInfo(DeviceInfoTypeEnum.contactList);
              },
              child: Text("Get Contact List"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getInfo(DeviceInfoTypeEnum enumType) async {
    final result = await DeviceInfoProvider().getInfo(enumType);
    Logger().f(result);
  }
}
