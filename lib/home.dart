import 'package:flutter/material.dart';
import 'package:packages_app/core/util/myenum.dart';
import 'package:packages_app/features/device_info/presentation/device_info_screen.dart';
import 'package:packages_app/features/loading_percent/presentation/loading_percent_screen.dart';
import 'package:packages_app/features/otp_field/presentation/otp_field_screen.dart';
import 'package:packages_app/features/shimmer_loading/presentation/shimmer_loading_screen.dart';
import 'package:packages_app/language_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
        title: Text(local.pageTitleHome),
        actions: [
          PopupMenuButton<int>(
            onSelected: (item) {
              final data =
                  Provider.of<LanguageProvider>(context, listen: false);
              if (item == 0) {
                data.changeLanguage(LanguageType.english);
              } else if (item == 1) {
                data.changeLanguage(LanguageType.bangla);
              } else {
                data.changeLanguage(LanguageType.spanish);
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem<int>(value: 0, child: Text('English')),
              PopupMenuItem<int>(value: 1, child: Text('Bangla')),
              PopupMenuItem<int>(value: 2, child: Text('Spanish')),
            ],
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => ShimmerLoadingScreen()));
            },
            child: Text(local.shimmerLoading),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => OtpFieldScreen()));
            },
            child: Text(local.otpField),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => LoadingPercentScreen()),
              );
            },
            child: Text(local.loadingPercent),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => DeviceInfoScreen(onSubmit: (_) {})),
              );
            },
            child: Text(local.nativeFeature),
          ),
        ],
      ),
    );
  }
}
