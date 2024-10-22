import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:packages_app/core/util/mycolor.dart';

class OtpField extends StatefulWidget {
  const OtpField({super.key, required this.length, required this.onSubmit});
  final int length;
  final Function(String val) onSubmit;
  @override
  State<OtpField> createState() => _OtpFieldState();
}

class _OtpFieldState extends State<OtpField> {
  final _formKey = GlobalKey<FormState>();
  final _otpController1 = TextEditingController();
  final _otpController2 = TextEditingController();
  final _otpController3 = TextEditingController();
  final _otpController4 = TextEditingController();
  final _otpController5 = TextEditingController();
  final _otpController6 = TextEditingController();
  final List<TextEditingController> _otpControllerList = [];
  final _otpFocusNode1 = FocusNode();
  final _otpFocusNode2 = FocusNode();
  final _otpFocusNode3 = FocusNode();
  final _otpFocusNode4 = FocusNode();
  final _otpFocusNode5 = FocusNode();
  final _otpFocusNode6 = FocusNode();
  final List<FocusNode> _otpFocusList = [];

  @override
  void initState() {
    super.initState();
    _otpFocusList.add(_otpFocusNode1);
    _otpFocusList.add(_otpFocusNode2);
    _otpFocusList.add(_otpFocusNode3);
    _otpFocusList.add(_otpFocusNode4);
    _otpFocusList.add(_otpFocusNode5);
    _otpFocusList.add(_otpFocusNode6);
    _otpControllerList.add(_otpController1);
    _otpControllerList.add(_otpController2);
    _otpControllerList.add(_otpController3);
    _otpControllerList.add(_otpController4);
    _otpControllerList.add(_otpController5);
    _otpControllerList.add(_otpController6);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Form(
          key: _formKey,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              widget.length,
              (i) {
                final isLastItem = i == widget.length - 1;
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: isLastItem ? 0 : 8),
                    child: _getOtpField(
                      cntrl: _otpControllerList[i],
                      currentFocus: _otpFocusList[i],
                      // if it's last otp-field then we don't need nextFocus
                      nextFocus: isLastItem ? null : _otpFocusList[i + 1],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(onPressed: _onSubmit, child: Text("Submit")),
      ],
    );
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;
    String confirmedOTP = '';
    for (int i = 0; i < widget.length; i++) {
      confirmedOTP = [confirmedOTP, _otpControllerList[i].text].join();
    }
    widget.onSubmit(confirmedOTP);
  }

  TextFormField _getOtpField(
      {required TextEditingController cntrl,
      required FocusNode currentFocus,
      FocusNode? nextFocus}) {
    return TextFormField(
      controller: cntrl,
      focusNode: currentFocus,
      keyboardType: TextInputType.number,
      textInputAction:
          nextFocus == null ? TextInputAction.done : TextInputAction.next,
      textAlign: TextAlign.center,
      style: const TextStyle(height: 0),
      // setiing maximum length of each field is 1
      inputFormatters: [LengthLimitingTextInputFormatter(1)],
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 20),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: MyColor.skyPrimary, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: MyColor.inActiveColor, width: .3),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: Colors.red),
        ),
        errorStyle: const TextStyle(height: 0),
      ),
      onChanged: (val) {
        if (val.isEmpty) {
          // if we remove a OTP-text, we may wanna stay on the same field, so doing nothing
        } else if (nextFocus != null) {
          // goint to next-Field if it's not the last OTP-Field
          FocusScope.of(context).nextFocus();
        } else if (nextFocus == null) {
          // for last OTP-Field, we r removing focus automatically
          FocusManager.instance.primaryFocus?.unfocus();
        } else {
          FocusScope.of(context).canRequestFocus;
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) return '';
        return null;
      },
      // if user press somewhere but on textfield then keyboard & focus dismissed
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
    );
  }

  @override
  void dispose() {
    _otpFocusNode1.dispose();
    _otpFocusNode2.dispose();
    _otpFocusNode3.dispose();
    _otpFocusNode4.dispose();
    _otpFocusNode5.dispose();
    _otpFocusNode6.dispose();
    _otpController1.dispose();
    _otpController2.dispose();
    _otpController3.dispose();
    _otpController4.dispose();
    _otpController5.dispose();
    _otpController6.dispose();
    super.dispose();
  }
}
