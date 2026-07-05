import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

class Check extends StatefulWidget {
  final VoidCallback ontap;
  final Color color;

  const Check({
    super.key,
    required this.ontap,
    required this.color,
  });

  @override
  State<Check> createState() => _CheckState();
}

class _CheckState extends State<Check> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: widget.ontap,
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: widget.color,
                border: Border.all(
                  color: const Color(0xFFE1F4FF),
                  width: 3,
                ),
              ),
            ),
          ),
          const Gap(8),
          customText(
            text: "Select All",
            color: Colors.white,
            textsize: 16,
            fontweight: FontWeight.w400,
          ),
        ],
      ),
    );
  }
}