import 'package:flutter/material.dart';
import 'package:packages_app/core/util/mydialog.dart';
import 'package:packages_app/core/util/mydimens.dart';
import 'package:packages_app/features/otp_field/presentation/widgets/otp_field.dart';

class OtpFieldScreen extends StatelessWidget {
  const OtpFieldScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyDimens().getNormalAppBar("OTP Page", [], context, true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          OtpField(
            length: 4,
            onSubmit: (val) {
              MyDialog()
                  .showSuccessToast(msg: "$val OTP matched", context: context);
            },
          ),
        ],
      ),
    );
  }
}
