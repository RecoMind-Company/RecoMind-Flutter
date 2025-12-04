import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

class ResendLine extends StatelessWidget {
  const ResendLine({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const customText(
          text: "Didn’t receive Code ?",
            color: Colors.grey,
            textsize: 13
        ),
        Gap(5),
        TextButton(
          onPressed: () {},
          child: const customText(
            text: "Resend Code",
            color: Colors.grey,
          ),
        ),
        const customText(
          text: "After 30 sec",
          color: Color(0xFF88E0FF), textsize: 13,
        ),
      ],
    );
  }
}
