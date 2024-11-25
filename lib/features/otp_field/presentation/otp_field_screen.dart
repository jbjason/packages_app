import 'package:flutter/material.dart';
import 'package:packages_app/core/util/mydimens.dart';
import 'package:packages_app/features/otp_field/presentation/widgets/otp_field.dart';

class OtpFieldScreen extends StatefulWidget {
  const OtpFieldScreen({super.key});
  @override
  State<OtpFieldScreen> createState() => _OtpFieldScreenState();
}

class _OtpFieldScreenState extends State<OtpFieldScreen> {
  String _otp = "";
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
            onSubmit: (val) => setState(() => _otp = val),
          ),
          const SizedBox(height: 20),
          Text(_otp),
        ],
      ),
    );
  }
}
