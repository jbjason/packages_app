// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:packages_app/core/util/mycolor.dart';

enum OtpFiledShape { underscore, square }

class OtpField extends StatefulWidget {
  const OtpField({
    super.key,
    required this.length,
    required this.onSubmit,
    this.focusBorderWidth = .7,
    this.focusBorderColor = MyColor.skyPrimary,
    this.focusFillColor = MyColor.cardBackgroundColor,
    this.unFocusBorderWidth = .3,
    this.unFocusBorderColor = MyColor.inActiveColor,
    this.unFocusFillColor = MyColor.cardBackgroundColor,
    this.errorBorderWidth = 1,
    this.errorBorderColor = Colors.red,
    this.errorFillColor = MyColor.cardBackgroundColor,
    this.shadowElevation = 0,
    this.shodowColor = Colors.transparent,
    this.hideText = false,
    this.otpFiledShape = OtpFiledShape.square,
  });
  final int length;
  final Function(String val) onSubmit;
  final double focusBorderWidth;
  final Color focusBorderColor;
  final Color focusFillColor;
  final double unFocusBorderWidth;
  final Color unFocusBorderColor;
  final Color unFocusFillColor;
  final double errorBorderWidth;
  final Color errorBorderColor;
  final Color errorFillColor;
  final double shadowElevation;
  final Color shodowColor;
  final bool hideText;
  final OtpFiledShape otpFiledShape;
  @override
  State<OtpField> createState() => _OtpFieldState();
}

class _OtpFieldState extends State<OtpField> {
  final _formKey = GlobalKey<FormState>();
  InputBorder? _selectedFocusBorder;
  InputBorder? _selectedUnFocusBorder;
  InputBorder? _selectedErrorBorder;
  final _otpController1 = TextEditingController();
  final _otpController2 = TextEditingController();
  final _otpController3 = TextEditingController();
  final _otpController4 = TextEditingController();
  final _otpController5 = TextEditingController();
  final _otpController6 = TextEditingController();
  final _otpController7 = TextEditingController();
  final _otpController8 = TextEditingController();
  final List<TextEditingController> _otpControllerList = [];
  final _otpFocusNode1 = FocusNode();
  final _otpFocusNode2 = FocusNode();
  final _otpFocusNode3 = FocusNode();
  final _otpFocusNode4 = FocusNode();
  final _otpFocusNode5 = FocusNode();
  final _otpFocusNode6 = FocusNode();
  final _otpFocusNode7 = FocusNode();
  final _otpFocusNode8 = FocusNode();
  final List<FocusNode> _otpFocusList = [];

  @override
  void initState() {
    super.initState();
    _getFieldShape();
    _otpFocusList.add(_otpFocusNode1);
    _otpFocusList.add(_otpFocusNode2);
    _otpFocusList.add(_otpFocusNode3);
    _otpFocusList.add(_otpFocusNode4);
    _otpFocusList.add(_otpFocusNode5);
    _otpFocusList.add(_otpFocusNode6);
    _otpFocusList.add(_otpFocusNode7);
    _otpFocusList.add(_otpFocusNode8);
    _otpControllerList.add(_otpController1);
    _otpControllerList.add(_otpController2);
    _otpControllerList.add(_otpController3);
    _otpControllerList.add(_otpController4);
    _otpControllerList.add(_otpController5);
    _otpControllerList.add(_otpController6);
    _otpControllerList.add(_otpController7);
    _otpControllerList.add(_otpController8);
  }

  void _getFieldShape() {
    if (widget.otpFiledShape == OtpFiledShape.square) {
      _selectedFocusBorder = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(
            color: widget.focusBorderColor, width: widget.focusBorderWidth),
      );
      _selectedUnFocusBorder = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(
            color: widget.unFocusBorderColor, width: widget.unFocusBorderWidth),
      );
      _selectedErrorBorder = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(
            color: widget.errorBorderColor, width: widget.errorBorderWidth),
      );
    } else {
      _selectedFocusBorder = UnderlineInputBorder(
        borderSide: BorderSide(
            color: widget.focusBorderColor, width: widget.focusBorderWidth),
      );
      _selectedUnFocusBorder = UnderlineInputBorder(
        borderSide: BorderSide(
            color: widget.unFocusBorderColor, width: widget.unFocusBorderWidth),
      );
      _selectedErrorBorder = UnderlineInputBorder(
        borderSide: BorderSide(
            color: widget.errorBorderColor, width: widget.errorBorderWidth),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
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
                  currentIndex: i,
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
    );
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) {
      widget.onSubmit("");
      return;
    }
    String confirmedOTP = '';
    for (int i = 0; i < widget.length; i++) {
      confirmedOTP = [confirmedOTP, _otpControllerList[i].text].join();
    }
    widget.onSubmit(confirmedOTP);
  }

  Widget _getOtpField(
      {required int currentIndex,
      required TextEditingController cntrl,
      required FocusNode currentFocus,
      FocusNode? nextFocus}) {
    return Material(
      elevation: widget.shadowElevation,
      color: Colors.transparent,
      clipBehavior: Clip.none,
      shadowColor: widget.shodowColor,
      child: TextFormField(
        controller: cntrl,
        focusNode: currentFocus,
        obscureText: widget.hideText, obscuringCharacter: "✶",
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
          focusedBorder: _selectedFocusBorder,
          enabledBorder: _selectedUnFocusBorder,
          errorBorder: _selectedErrorBorder,
          focusedErrorBorder: _selectedErrorBorder,
          errorStyle: const TextStyle(height: 0),
        ),
        onSaved: (_) => _onSubmit(),
        onFieldSubmitted: (_) => _onSubmit(),
        onChanged: (val) {
          if (val.isEmpty) {
            // if we remove a OTP-text, we may wanna stay on the same field, so doing nothing
          } else if (nextFocus != null) {
            // goint to next-Field if it's not the last OTP-Field
            FocusScope.of(context).nextFocus();
          } else if (nextFocus == null) {
            // for last OTP-Field, we r removing focus automatically
            FocusManager.instance.primaryFocus?.unfocus();
            _onSubmit();
          } else {
            FocusScope.of(context).canRequestFocus;
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty) return '';
          return null;
        },
        // if user press somewhere but on textfield then keyboard & focus dismissed
        onTapOutside: (_) {
          FocusManager.instance.primaryFocus?.unfocus();
          _onSubmit();
        },
        contextMenuBuilder: (context, editableTextState) {
          return AdaptiveTextSelectionToolbar(
            anchors: editableTextState.contextMenuAnchors,
            children: [
              TextSelectionToolbarTextButton(
                padding: EdgeInsets.all(10),
                onPressed: () => _onPasteCode(currentIndex),
                child: const Text('Paste'),
              ),
              TextSelectionToolbarTextButton(
                padding: EdgeInsets.all(10),
                onPressed: () => FocusManager.instance.primaryFocus?.unfocus(),
                child: const Text('Cancel'),
              ),
            ],
          );
        },
      ),
    );
  }

  void _onPasteCode(int currentIndex) {
    Clipboard.getData('text/plain').then((value) {
      if (value != null && value.text != null && value.text!.isNotEmpty) {
        for (int i = 0; (i < widget.length) && (i < value.text!.length); i++) {
          _otpControllerList[currentIndex + i].text = value.text![i];
        }
      }
      FocusManager.instance.primaryFocus?.unfocus();
    });
  }

  @override
  void dispose() {
    _otpFocusNode1.dispose();
    _otpFocusNode2.dispose();
    _otpFocusNode3.dispose();
    _otpFocusNode4.dispose();
    _otpFocusNode5.dispose();
    _otpFocusNode6.dispose();
    _otpFocusNode7.dispose();
    _otpFocusNode8.dispose();
    _otpController1.dispose();
    _otpController2.dispose();
    _otpController3.dispose();
    _otpController4.dispose();
    _otpController5.dispose();
    _otpController6.dispose();
    _otpController7.dispose();
    _otpController8.dispose();
    super.dispose();
  }
}
