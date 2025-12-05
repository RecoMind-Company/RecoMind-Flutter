import 'package:flutter/material.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

class CategoryButton extends StatelessWidget {
  const CategoryButton(
      {super.key,
      required this.color,
      required this.borderColor,
      required this.text,
      required this.ontap});

  final Color? color, borderColor;
  final String? text;
  final Function() ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        alignment: Alignment.center,
        height: 40,
        width: 130,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: borderColor!)),
        child: customText(
          text: text!,
          color: Colors.white,
          fontweight: FontWeight.w400,
          textsize: 14,
        ),
      ),
    );
  }
}
