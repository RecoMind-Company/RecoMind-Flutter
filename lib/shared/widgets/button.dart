import 'package:flutter/material.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

class button extends StatelessWidget {
  final Function()? onPressed;
  final Color? color;
  final Color borderColor;
  final String buttonText;
  final Color? textColor;

  const button({
    super.key,
    required this.onPressed,
    required this.color,
    required this.borderColor,
    required this.buttonText,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: borderColor,
              width: 1,
            ),
          ),
        ),
        child: customText(
          text: buttonText,
            color: textColor,
            textsize: 16,
          fontweight: FontWeight.w400,
          ),
        ),
    );
  }
}
