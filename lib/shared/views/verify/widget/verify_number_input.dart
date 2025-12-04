import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:recomind/core/constants/app_colors.dart';

class VerifyNumberInput extends StatefulWidget {
  VerifyNumberInput(
      {super.key, required this.isFilled, required this.pinController});

  final TextEditingController pinController;

  late final bool? isFilled;

  @override
  State<VerifyNumberInput> createState() => _VerifyNumberInputState();
}

class _VerifyNumberInputState extends State<VerifyNumberInput> {
  final defaultPinTheme = PinTheme(
    width: 60,
    height: 60,
    textStyle: const TextStyle(
      fontSize: 22,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.blueGrey),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 13.0, left: 13),
      child: Pinput(
        controller: widget.pinController,
        length: 4,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        showCursor: true,
        defaultPinTheme: defaultPinTheme,
        focusedPinTheme: defaultPinTheme.copyWith(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColor.primaryColor),
          ),
        ),
        errorPinTheme: defaultPinTheme.copyWith(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.redAccent),
          ),
        ),
        onChanged: (value) {
          setState(() {
            widget.isFilled = value.length == 4;
          });
        },
      ),
    );
  }
}
