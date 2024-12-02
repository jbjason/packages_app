// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:packages_app/core/util/mycolor.dart';

enum OtpFiledShape { underscore, square, circular }

class OtpField extends StatefulWidget {
  const OtpField(
      {super.key,
      required this.length,
      required this.onSubmit,
      this.borderRadius = 12,
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
      this.otpFiledShape = OtpFiledShape.circular});
  final int length;
  final Function(String val) onSubmit;
  final double borderRadius;
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
  bool _isShapeCircular = false, _isShapeCircularError = false;
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
    _defineShapeOfTheField();
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
      if (_isShapeCircular) setState(() => _isShapeCircularError = true);
      return;
    }
    _isShapeCircularError = false;
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
    final child = Material(
      elevation: widget.shadowElevation,
      color: Colors.transparent,
      clipBehavior: Clip.none,
      shadowColor: widget.shodowColor,
      shape: _isShapeCircular
          ? CircleBorder(
              side: BorderSide(
                color: _isShapeCircularError
                    ? widget.errorBorderColor
                    : widget.focusBorderColor,
                width: _isShapeCircularError
                    ? widget.errorBorderWidth
                    : widget.focusBorderWidth,
              ),
            )
          : null,
      child: Center(
        child: _getTextField(
          currentIndex: currentIndex,
          cntrl: cntrl,
          currentFocus: currentFocus,
          nextFocus: nextFocus,
        ),
      ),
    );
    if (_isShapeCircularError) return SizedBox(height: 60, child: child);
    return child;
  }

  TextFormField _getTextField(
          {required int currentIndex,
          required TextEditingController cntrl,
          required FocusNode currentFocus,
          FocusNode? nextFocus}) =>
      TextFormField(
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
          fillColor: Colors.transparent,
          contentPadding: EdgeInsets.symmetric(vertical: 20),
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
      );

  void _defineShapeOfTheField() {
    if (widget.otpFiledShape == OtpFiledShape.square) {
      _selectedFocusBorder =
          _getInputBorder(widget.focusBorderColor, widget.focusBorderWidth);
      _selectedUnFocusBorder =
          _getInputBorder(widget.unFocusBorderColor, widget.unFocusBorderWidth);
      _selectedErrorBorder =
          _getInputBorder(widget.errorBorderColor, widget.errorBorderWidth);
    } else if (widget.otpFiledShape == OtpFiledShape.underscore) {
      _selectedFocusBorder = _getInputBorder(
          widget.focusBorderColor, widget.focusBorderWidth,
          isUnderLine: true);
      _selectedUnFocusBorder = _getInputBorder(
          widget.unFocusBorderColor, widget.unFocusBorderWidth,
          isUnderLine: true);
      _selectedErrorBorder = _getInputBorder(
          widget.errorBorderColor, widget.errorBorderWidth,
          isUnderLine: true);
    } else {
      _isShapeCircular = true;
      _selectedFocusBorder =
          _getInputBorder(Colors.transparent, widget.focusBorderWidth);
      _selectedUnFocusBorder =
          _getInputBorder(Colors.transparent, widget.unFocusBorderWidth);
      _selectedErrorBorder =
          _getInputBorder(Colors.transparent, widget.errorBorderWidth);
    }
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

  InputBorder _getInputBorder(Color color, double width,
          {bool isUnderLine = false}) =>
      isUnderLine
          ? UnderlineInputBorder(
              borderSide: BorderSide(color: color, width: width))
          : OutlineInputBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(widget.borderRadius)),
              borderSide: BorderSide(color: color, width: width),
            );

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
