import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/shared/widgets/custom_text.dart';


class StatColumn extends StatelessWidget {
  final String label;
  final String value;

  const StatColumn({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        customText(
         text:label,
              color: Color(0xffeeeeee), textsize: 15
        ),
        Gap(4),
        customText(
          text: value,
          color: Colors.white,
          textsize: 26,
          fontweight: FontWeight.w400,
        ),
      ],
    );
  }
}
